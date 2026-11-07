#!/usr/bin/env python3
"""Graphismes pixel art d'IQURA, créés pour le projet (cahier v3 §8.1).

Chaque image (scène ou personnage) est décrite dans `art/<nom>.json` par une
liste de rectangles, dans une grille de pixels (une scène fait 160 × 90) :

    {"largeur": 160, "hauteur": 90,
     "rectangles": [[x, y, largeur, hauteur, "#rrggbb", opacité?], …]}

Les rectangles sont peints dans l'ordre (le dernier par-dessus) ; l'opacité,
facultative, va de 0 à 1. Le script écrit `assets/art/<nom>.png`, un pixel par
case : l'application agrandit l'image sans lissage.

Usage :
    python3 tools/build_art/build_art.py            # régénère les PNG
    python3 tools/build_art/build_art.py --verifier # vérifie qu'ils sont à jour

Bibliothèque standard uniquement (zlib, struct) ; la sortie est déterministe.
"""

from __future__ import annotations

import argparse
import glob
import json
import os
import struct
import sys
import zlib

HERE = os.path.dirname(os.path.abspath(__file__))
SOURCES = os.path.join(HERE, "art")
OUT = os.path.normpath(os.path.join(HERE, "..", "..", "assets", "art"))


class ArtError(Exception):
    pass


def _color(spec: str) -> tuple[int, int, int]:
    if len(spec) != 7 or spec[0] != "#":
        raise ArtError(f"couleur invalide : {spec}")
    return int(spec[1:3], 16), int(spec[3:5], 16), int(spec[5:7], 16)


def render(data: dict, name: str = "?") -> tuple[int, int, bytearray]:
    """Pixels RGBA (non prémultipliés) de l'image décrite."""
    w, h = data["largeur"], data["hauteur"]
    if not (0 < w <= 2048 and 0 < h <= 2048):
        raise ArtError(f"{name} : taille invalide {w} × {h}")
    px = bytearray(w * h * 4)
    for i, r in enumerate(data["rectangles"]):
        if len(r) not in (5, 6):
            raise ArtError(f"{name} : rectangle {i} mal formé")
        x, y, rw, rh = r[:4]
        cr, cg, cb = _color(r[4])
        a = float(r[5]) if len(r) == 6 else 1.0
        if not 0 < a <= 1:
            raise ArtError(f"{name} : opacité invalide au rectangle {i}")
        if rw <= 0 or rh <= 0 or x < 0 or y < 0 or x + rw > w or y + rh > h:
            raise ArtError(f"{name} : rectangle {i} hors de l'image : {r}")
        for yy in range(y, y + rh):
            for xx in range(x, x + rw):
                o = (yy * w + xx) * 4
                da = px[o + 3] / 255
                oa = a + da * (1 - a)
                if oa == 0:
                    continue
                for k, c in enumerate((cr, cg, cb)):
                    px[o + k] = round((c * a + px[o + k] * da * (1 - a)) / oa)
                px[o + 3] = round(oa * 255)
    return w, h, px


def png(w: int, h: int, px: bytearray) -> bytes:
    raw = b"".join(b"\x00" + bytes(px[y * w * 4:(y + 1) * w * 4]) for y in range(h))

    def chunk(kind: bytes, body: bytes) -> bytes:
        return (struct.pack(">I", len(body)) + kind + body
                + struct.pack(">I", zlib.crc32(kind + body) & 0xFFFFFFFF))

    return (b"\x89PNG\r\n\x1a\n"
            + chunk(b"IHDR", struct.pack(">IIBBBBB", w, h, 8, 6, 0, 0, 0))
            + chunk(b"IDAT", zlib.compress(raw, 9))
            + chunk(b"IEND", b""))


def build_all(src: str = SOURCES) -> dict[str, bytes]:
    images = {}
    for path in sorted(glob.glob(os.path.join(src, "*.json"))):
        name = os.path.splitext(os.path.basename(path))[0]
        with open(path, encoding="utf-8") as f:
            data = json.load(f)
        images[name] = png(*render(data, name))
    return images


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--verifier", action="store_true",
                    help="vérifier que assets/art est à jour, sans rien écrire")
    args = ap.parse_args()
    images = build_all()
    if args.verifier:
        stale = []
        for name, data in images.items():
            path = os.path.join(OUT, f"{name}.png")
            if not os.path.exists(path) or open(path, "rb").read() != data:
                stale.append(name)
        extra = sorted(set(os.path.splitext(os.path.basename(p))[0]
                           for p in glob.glob(os.path.join(OUT, "*.png"))) - set(images))
        if stale or extra:
            print("[build_art] à régénérer :", stale, "en trop :", extra, file=sys.stderr)
            return 1
        print(f"[build_art] {len(images)} images à jour")
        return 0
    os.makedirs(OUT, exist_ok=True)
    for name, data in images.items():
        with open(os.path.join(OUT, f"{name}.png"), "wb") as f:
            f.write(data)
    print(f"[build_art] {len(images)} images écrites dans {OUT}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
