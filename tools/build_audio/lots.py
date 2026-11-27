"""Génération par lots de la phase audio (J6), avec reprise.

Pour une région : prend les enregistrements manquants (mots, puis phrases),
les génère par lots (`generate.py`), livre chaque lot (`package.py`),
reconstruit la base de contenu (contrôle des empreintes) et, avec --git,
crée un commit et l'envoie, pour ne rien perdre si la machine s'arrête.
Relancé, il reprend là où il s'était arrêté (le manifeste fait foi).

Utilisation (environnement audio) :
    python lots.py --region 3 [--genre mot] [--taille 20] [--git] [--max N]
"""

from __future__ import annotations

import argparse
import json
import os
import subprocess
import sys
import time

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.normpath(os.path.join(HERE, "..", ".."))
sys.path.insert(0, HERE)

from generate import generate  # noqa: E402
from manquants import missing  # noqa: E402


def run(cmd: list[str]) -> None:
    subprocess.run(cmd, cwd=ROOT, check=True)


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--region", type=int, required=True)
    ap.add_argument("--genre", choices=["syllabe", "mot", "phrase"])
    ap.add_argument("--taille", type=int, default=20)
    ap.add_argument("--essais", type=int, default=5)
    ap.add_argument("--max", type=int, default=0, help="nombre de lots au plus (0 : tous)")
    ap.add_argument("--travail", default=os.path.join(ROOT, "build", "audio_lots"))
    ap.add_argument("--git", action="store_true")
    args = ap.parse_args()
    n = 0
    while True:
        rows = [r for r in missing() if r["region"] == args.region
                and (not args.genre or r["kind"] == args.genre)]
        if not rows:
            print("terminé : région", args.region, flush=True)
            return
        batch = rows[: args.taille]
        out = os.path.join(args.travail, f"r{args.region}-{int(time.time())}")
        t0 = time.time()
        report = generate([(r["key"], r["kind"], r["text"]) for r in batch], out, args.essais)
        with open(os.path.join(out, "rapport.json"), "w", encoding="utf-8") as f:
            json.dump(report, f, ensure_ascii=False, indent=1)
        run([sys.executable, os.path.join(HERE, "package.py"), out])
        run(["python3", "tools/build_content/build_content.py"])
        left = len(rows) - len(batch)
        print(f"lot de {len(batch)} en {time.time() - t0:.0f} s ; reste {left}", flush=True)
        if args.git:
            run(["git", "add", "assets/audio/lecons", "tools/build_audio/clips.json"])
            msg = (f"Phase audio : région {args.region}, {len(batch)} enregistrements "
                   f"(reste {left})\n\nCo-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>\n"
                   "Claude-Session: https://claude.ai/code/session_01U4NMXNGvgwQH71Vay1rC9m")
            run(["git", "commit", "-q", "-m", msg])
            for i in range(4):
                if subprocess.run(["git", "push", "-q", "origin", "HEAD"], cwd=ROOT).returncode == 0:
                    break
                time.sleep(2 ** (i + 1))
        n += 1
        if args.max and n >= args.max:
            return


if __name__ == "__main__":
    main()
