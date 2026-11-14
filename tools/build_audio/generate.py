"""Génération des enregistrements des leçons avec Chatterbox Multilingual.

Décision ouverte n° 1 tranchée par l'utilisateur : Chatterbox Multilingual
(Resemble AI, licence MIT). Chaque fichier produit est une voix de synthèse,
marquée comme telle dans la base de contenu (`audio_clip.synthetic = 1`).
Chatterbox ajoute un filigrane inaudible (Perth) à tout ce qu'il produit.

Pour chaque texte :
1. synthèse avec une graine fixe (résultat reproductible) ;
2. coupure après la première prise de parole (`trim.py`) ;
3. si la durée de parole est invraisemblable (trop courte : mot tronqué ;
   trop longue : bafouillage), nouvelle graine, jusqu'à `--essais` fois ;
4. si aucun essai ne convient, le meilleur est gardé et signalé « à écouter ».

Le rapport JSON indique, pour chaque fichier, la graine retenue, les durées
et la parole parasite retirée, pour relecture à l'oreille.

Utilisation (dans un environnement où chatterbox-tts est installé) :
    python generate.py textes.tsv SORTIE/ [--essais 5]
où textes.tsv contient « genre <TAB> translittération <TAB> arabe », ou :
    python generate.py --lecons SORTIE/
pour tous les enregistrements nécessaires aux leçons.
"""

from __future__ import annotations

import argparse
import json
import os
import sys

import numpy as np

from trim import expected_max_duration, expected_min_duration, trim_first_utterance

HERE = os.path.dirname(os.path.abspath(__file__))


def lesson_texts() -> list[tuple[str, str, str]]:
    sys.path.insert(0, os.path.join(HERE, "..", "build_content"))
    import lessons  # noqa: E402

    clips = lessons.audio_clips(lessons.load())
    return [(key, kind, text) for key, (kind, text) in sorted(clips.items())]


def tsv_texts(path: str) -> list[tuple[str, str, str]]:
    rows = []
    with open(path, encoding="utf-8") as f:
        for i, line in enumerate(f, 1):
            kind, _translit, ar = line.rstrip("\n").split("\t")
            rows.append((str(i), kind, ar))
    return rows


def generate(rows, out_dir: str, tries: int, first_seed: int = 0,
             keep_raw: bool = False) -> list[dict]:
    import soundfile as sf
    import torch
    from chatterbox.mtl_tts import ChatterboxMultilingualTTS

    model = ChatterboxMultilingualTTS.from_pretrained(device="cpu")
    os.makedirs(out_dir, exist_ok=True)
    report = []
    for key, kind, text in rows:
        lo, hi = expected_min_duration(text), expected_max_duration(text)
        best = None
        for seed in range(first_seed, first_seed + tries):
            torch.manual_seed(seed)
            wav = model.generate(text, language_id="ar")
            raw = wav.squeeze(0).cpu().numpy()
            if keep_raw:
                sf.write(os.path.join(out_dir, f"{key}.brut{seed}.wav"), raw, model.sr)
            try:
                res = trim_first_utterance(raw, model.sr)
            except ValueError:
                continue
            d = res.speech_duration
            # Écart à l'intervalle plausible (0 = dans l'intervalle).
            miss = max(0.0, lo - d, d - hi)
            if best is None or miss < best[0]:
                best = (miss, seed, res, len(raw) / model.sr)
            if miss == 0:
                break
        if best is None:
            report.append({"key": key, "kind": kind, "text": text,
                           "erreur": "aucune parole détectée"})
            continue
        miss, seed, res, raw_len = best
        sf.write(os.path.join(out_dir, f"{key}.wav"), res.audio, model.sr)
        entry = {
            "key": key, "kind": kind, "text": text, "seed": seed,
            "brut_s": round(raw_len, 2),
            "parole_s": round(res.speech_duration, 2),
            "garde_s": round(len(res.audio) / model.sr, 2),
            "parasite_retire_s": round(res.dropped_seconds, 2),
            "a_ecouter": miss > 0,
        }
        report.append(entry)
        print(json.dumps(entry, ensure_ascii=False), flush=True)
    return report


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("textes", nargs="?")
    ap.add_argument("sortie")
    ap.add_argument("--lecons", action="store_true")
    ap.add_argument("--essais", type=int, default=5)
    ap.add_argument("--premiere-graine", type=int, default=0,
                    help="pour écarter des graines refusées à l'écoute")
    ap.add_argument("--seulement", nargs="+", metavar="TEXTE",
                    help="ne régénérer que ces textes arabes")
    ap.add_argument("--brut", action="store_true",
                    help="garder aussi chaque sortie brute, pour analyse")
    args = ap.parse_args()
    if args.lecons == bool(args.textes):
        ap.error("donner soit un fichier de textes, soit --lecons")
    rows = lesson_texts() if args.lecons else tsv_texts(args.textes)
    if args.seulement:
        rows = [r for r in rows if r[2] in set(args.seulement)]
    report = generate(rows, args.sortie, args.essais, args.premiere_graine, args.brut)
    with open(os.path.join(args.sortie, "rapport.json"), "w", encoding="utf-8") as f:
        json.dump(report, f, ensure_ascii=False, indent=1)


if __name__ == "__main__":
    main()
