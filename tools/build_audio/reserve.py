"""Met en réserve les enregistrements qui ne servent plus à aucune leçon.

Ils sortent de l'application (`assets/`) et du manifeste `clips.json`, mais
sont gardés dans `reserve/` et `reserve.json` pour être réutilisés (le
pipeline de contenu refuse les enregistrements orphelins).

Utilisation : python3 tools/build_audio/reserve.py
"""

from __future__ import annotations

import json
import os
import shutil
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.normpath(os.path.join(HERE, "..", ".."))
MANIFEST = os.path.join(HERE, "clips.json")
RESERVE = os.path.join(HERE, "reserve.json")


def main() -> None:
    sys.path.insert(0, os.path.join(ROOT, "tools", "build_content"))
    import lessons  # noqa: E402

    used = set(lessons.audio_clips(lessons.load()))
    with open(MANIFEST, encoding="utf-8") as f:
        manifest = json.load(f)
    reserve = {"_comment": "Enregistrements validés mais plus utilisés par une leçon : "
               "gardés hors de l'application pour être réutilisés.", "clips": {}}
    if os.path.exists(RESERVE):
        with open(RESERVE, encoding="utf-8") as f:
            reserve = json.load(f)
    os.makedirs(os.path.join(HERE, "reserve"), exist_ok=True)
    for key in sorted(set(manifest["clips"]) - used):
        e = manifest["clips"].pop(key)
        dst = os.path.join("tools", "build_audio", "reserve", os.path.basename(e["fichier"]))
        shutil.move(os.path.join(ROOT, e["fichier"]), os.path.join(ROOT, dst))
        e["fichier"] = dst
        reserve["clips"][key] = e
        print("en réserve :", e["texte"])
    # Une entrée de réserve redevenue utile revient dans l'application.
    for key in sorted(set(reserve["clips"]) & used):
        e = reserve["clips"].pop(key)
        dst = f"assets/audio/lecons/{os.path.basename(e['fichier'])}"
        shutil.move(os.path.join(ROOT, e["fichier"]), os.path.join(ROOT, dst))
        e["fichier"] = dst
        manifest["clips"][key] = e
        print("réutilisé :", e["texte"])
    for path, data in ((MANIFEST, manifest), (RESERVE, reserve)):
        data["clips"] = dict(sorted(data["clips"].items()))
        with open(path, "w", encoding="utf-8") as f:
            json.dump(data, f, ensure_ascii=False, indent=1)
            f.write("\n")


if __name__ == "__main__":
    main()
