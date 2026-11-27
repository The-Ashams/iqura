"""Une part de la génération audio (phase J6), pour GitHub Actions.

Prend les enregistrements manquants d'une région (et d'un genre), garde
ceux de rang i, i + n, i + 2n… (part i sur n) et les génère dans un dossier
avec son `rapport.json`, que `package.py` livre ensuite.

Utilisation : python part.py --region 3 --genre mot --part 0 --parts 20 SORTIE/
"""

from __future__ import annotations

import argparse
import json
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

from generate import generate  # noqa: E402
from manquants import missing  # noqa: E402


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("sortie")
    ap.add_argument("--region", type=int, required=True)
    ap.add_argument("--genre", default="")
    ap.add_argument("--part", type=int, required=True)
    ap.add_argument("--parts", type=int, required=True)
    ap.add_argument("--essais", type=int, default=5)
    args = ap.parse_args()
    rows = [r for r in missing() if r["region"] == args.region
            and (not args.genre or r["kind"] == args.genre)]
    mine = rows[args.part::args.parts]
    print(f"part {args.part}/{args.parts} : {len(mine)} enregistrements", flush=True)
    os.makedirs(args.sortie, exist_ok=True)
    report = generate([(r["key"], r["kind"], r["text"]) for r in mine], args.sortie, args.essais)
    with open(os.path.join(args.sortie, "rapport.json"), "w", encoding="utf-8") as f:
        json.dump(report, f, ensure_ascii=False, indent=1)


if __name__ == "__main__":
    main()
