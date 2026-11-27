"""Liste des enregistrements manquants, par région (phase audio J6).

Pour chaque texte qui a un emplacement audio (`lessons.audio_clips`) mais pas
encore de fichier dans le manifeste `clips.json`, donne la première région
où il apparaît (lettres et syllabes : région 1 ; mot : région de sa fiche ;
texte d'écran : région de la leçon ; examen : sa région).

Utilisation : python manquants.py [--region N] [--genre mot|phrase|syllabe]
Sortie : une ligne JSON par texte (clé, genre, texte, région), dans l'ordre
des leçons.
"""

from __future__ import annotations

import argparse
import json
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "..", "build_content"))

import lessons  # noqa: E402
import mini_donjon  # noqa: E402


def regions_of_texts(data) -> dict[str, int]:
    """Texte arabe → première région où il apparaît."""
    region: dict[str, int] = {}
    stage = {l["id"]: l["etape"] for l in data.lessons}
    order = sorted(data.lessons, key=lambda l: (l["etape"], l["ordre"]))
    for card in data.letters["lettres"]:
        region.setdefault(card["nom_ar"], 1)
    for lesson in order:
        for t in mini_donjon.arabic_strings(lesson):
            region.setdefault(t, lesson["etape"])
    for w in data.words or []:
        r = stage.get(w["lecon"])
        if r is not None:
            region.setdefault(w["ar"], r)
            if w.get("exemple"):
                region.setdefault(w["exemple"]["ar"], r)
    for exam in data.exams or []:
        for _, t in lessons.exams_mod.audio_texts([exam]):
            region.setdefault(t, exam["region"])
    return region


def missing(data=None) -> list[dict]:
    data = data or lessons.load()
    clips = lessons.audio_clips(data)
    done = set(lessons.load_audio_manifest().get("clips", {}))
    where = regions_of_texts(data)
    rows = [{"key": k, "kind": kind, "text": text, "region": where.get(text, 5)}
            for k, (kind, text) in clips.items() if k not in done]
    rank = {"lettre": 0, "syllabe": 1, "mot": 2, "phrase": 3}
    return sorted(rows, key=lambda r: (r["region"], rank[r["kind"]], r["key"]))


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--region", type=int)
    ap.add_argument("--genre")
    args = ap.parse_args()
    for r in missing():
        if args.region and r["region"] != args.region:
            continue
        if args.genre and r["kind"] != args.genre:
            continue
        print(json.dumps(r, ensure_ascii=False))


if __name__ == "__main__":
    main()
