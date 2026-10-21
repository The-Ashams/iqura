"""Livraison des enregistrements générés par `generate.py`.

Convertit chaque fichier WAV en MP3 mono (lisible sur Android et Windows sans
codec supplémentaire ; MP3 n'est plus soumis à brevet), le copie dans
`assets/audio/lecons/` et écrit le manifeste `tools/build_audio/clips.json`.
Le pipeline de contenu lit ce manifeste, vérifie l'empreinte SHA-256 de
chaque fichier et remplit la table `audio_clip`.

Utilisation : python package.py DOSSIER_GENERE   (nécessite ffmpeg)
"""

from __future__ import annotations

import datetime
import hashlib
import json
import os
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.normpath(os.path.join(HERE, "..", ".."))
ASSET_DIR = "assets/audio/lecons"
MANIFEST = os.path.join(HERE, "clips.json")

ORIGIN = ("Synthèse vocale Chatterbox Multilingual (Resemble AI, licence MIT, "
          "révision 5bb1f6e), voix par défaut")


def sha256(path: str) -> str:
    with open(path, "rb") as f:
        return hashlib.sha256(f.read()).hexdigest()


def main() -> None:
    src = sys.argv[1]
    with open(os.path.join(src, "rapport.json"), encoding="utf-8") as f:
        report = json.load(f)
    if os.path.exists(MANIFEST):
        with open(MANIFEST, encoding="utf-8") as f:
            manifest = json.load(f)
    else:
        manifest = {"origine": ORIGIN, "synthese": True, "clips": {}}
    os.makedirs(os.path.join(ROOT, ASSET_DIR), exist_ok=True)
    today = datetime.date.today().isoformat()
    for entry in report:
        if "erreur" in entry:
            print("ignoré :", entry["text"], entry["erreur"])
            continue
        rel = f"{ASSET_DIR}/{entry['key']}.mp3"
        subprocess.run(
            ["ffmpeg", "-loglevel", "error", "-y", "-i",
             os.path.join(src, f"{entry['key']}.wav"),
             "-ac", "1", "-codec:a", "libmp3lame", "-b:a", "64k",
             "-map_metadata", "-1", "-fflags", "+bitexact",
             os.path.join(ROOT, rel)],
            check=True,
        )
        manifest["clips"][entry["key"]] = {
            "genre": entry["kind"],
            "texte": entry["text"],
            "fichier": rel,
            "sha256": sha256(os.path.join(ROOT, rel)),
            "graine": entry["seed"],
            "a_ecouter": entry["a_ecouter"],
            "genere_le": today,
        }
    manifest["clips"] = dict(sorted(manifest["clips"].items()))
    with open(MANIFEST, "w", encoding="utf-8") as f:
        json.dump(manifest, f, ensure_ascii=False, indent=1)
        f.write("\n")
    print(len(manifest["clips"]), "enregistrements dans", MANIFEST)


if __name__ == "__main__":
    main()
