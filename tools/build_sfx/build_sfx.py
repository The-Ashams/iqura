#!/usr/bin/env python3
"""Bruitages d'IQURA, créés pour le projet (décision du 23/10/2026).

Sons rétro « 8 bits », dans l'esprit du pixel art du jeu, décrits dans
`sons.json` : chaque son est une suite de notes

    {"forme": "carree" | "triangle" | "bruit", "freq": Hz,
     "freq_fin": Hz (facultatif, glissement), "duree": s, "volume": 0 à 1}

Chaque note a une attaque et une chute courtes, pour éviter les claquements.
Le script écrit `assets/sfx/<nom>.wav` (mono, 16 bits). Aucune voix : ces sons
ne remplacent jamais l'audio des leçons.

Usage :
    python3 tools/build_sfx/build_sfx.py            # régénère les WAV
    python3 tools/build_sfx/build_sfx.py --verifier # vérifie qu'ils sont à jour

Bibliothèque standard uniquement ; la sortie est déterministe (le bruit vient
d'un générateur pseudo-aléatoire à graine fixe).
"""

from __future__ import annotations

import argparse
import io
import json
import math
import os
import struct
import sys
import wave

HERE = os.path.dirname(os.path.abspath(__file__))
SOURCE = os.path.join(HERE, "sons.json")
OUT = os.path.normpath(os.path.join(HERE, "..", "..", "assets", "sfx"))
FORMS = {"carree", "triangle", "bruit"}
FADE = 0.005  # secondes d'attaque et de chute


class SfxError(Exception):
    pass


def _note(n: dict, rate: int, seed: list[int], where: str) -> list[float]:
    form = n.get("forme")
    if form not in FORMS:
        raise SfxError(f"{where} : forme inconnue {form}")
    f0 = float(n["freq"])
    f1 = float(n.get("freq_fin", f0))
    dur, vol = float(n["duree"]), float(n["volume"])
    if not (20 <= f0 <= 8000 and 20 <= f1 <= 8000):
        raise SfxError(f"{where} : fréquence hors limites")
    if not 0 < dur <= 2:
        raise SfxError(f"{where} : durée hors limites")
    if not 0 < vol <= 0.5:
        raise SfxError(f"{where} : volume trop fort (0,5 au plus)")
    count = int(round(dur * rate))
    out = []
    phase = 0.0
    hold = 0.0
    for i in range(count):
        t = i / count
        f = f0 + (f1 - f0) * t
        phase = (phase + f / rate) % 1.0
        if form == "carree":
            v = 1.0 if phase < 0.5 else -1.0
        elif form == "triangle":
            v = 4 * abs(phase - 0.5) - 1
        else:
            # Bruit « échantillonné » à la fréquence f (plus grave en
            # descendant), générateur congruentiel à graine fixe.
            if phase < f / rate or i == 0:
                seed[0] = (seed[0] * 1103515245 + 12345) & 0x7FFFFFFF
                hold = seed[0] / 0x3FFFFFFF - 1
            v = hold
        k = min(1.0, i / (FADE * rate), (count - i) / (FADE * rate))
        # Légère décroissance pour un son plus naturel.
        out.append(v * vol * k * (1 - 0.5 * t))
    return out


def render(sound: dict, rate: int, name: str = "?") -> bytes:
    """Fichier WAV (mono, 16 bits) d'un son."""
    if not sound.get("notes"):
        raise SfxError(f"{name} : aucune note")
    seed = [sum(ord(c) for c in name) or 1]
    samples: list[float] = []
    for i, n in enumerate(sound["notes"]):
        samples += _note(n, rate, seed, f"{name} note {i + 1}")
    if len(samples) / rate > 2:
        raise SfxError(f"{name} : plus de 2 secondes")
    buf = io.BytesIO()
    with wave.open(buf, "wb") as w:
        w.setnchannels(1)
        w.setsampwidth(2)
        w.setframerate(rate)
        w.writeframes(b"".join(
            struct.pack("<h", int(max(-1.0, min(1.0, s)) * 32767)) for s in samples))
    return buf.getvalue()


def load(path: str = SOURCE) -> dict:
    with open(path, encoding="utf-8") as f:
        data = json.load(f)
    for name, s in data["sons"].items():
        if not s.get("role"):
            raise SfxError(f"{name} : rôle absent")
    return data


def build(check: bool = False) -> list[str]:
    data = load()
    rate = int(data["frequence"])
    stale = []
    os.makedirs(OUT, exist_ok=True)
    for name, sound in sorted(data["sons"].items()):
        wav = render(sound, rate, name)
        path = os.path.join(OUT, f"{name}.wav")
        current = open(path, "rb").read() if os.path.exists(path) else None
        if current != wav:
            stale.append(name)
            if not check:
                with open(path, "wb") as f:
                    f.write(wav)
    extra = {f[:-4] for f in os.listdir(OUT) if f.endswith(".wav")} - set(data["sons"])
    if extra:
        stale += sorted(f"{e} (orphelin)" for e in extra)
    return stale


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--verifier", action="store_true")
    args = ap.parse_args()
    try:
        stale = build(check=args.verifier)
    except SfxError as e:
        sys.exit(f"[build_sfx] {e}")
    n = len(load()["sons"])
    if args.verifier and stale:
        sys.exit(f"[build_sfx] à régénérer : {', '.join(stale)}")
    print(f"[build_sfx] {n} sons à jour" if not stale or args.verifier
          else f"[build_sfx] {len(stale)} sons écrits sur {n}")


if __name__ == "__main__":
    main()
