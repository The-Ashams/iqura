#!/usr/bin/env python3
"""Génère iqura_content.db, la base de contenu en lecture seule d'IQURA.

Phase 1 (socle) : la base ne contient que la table `content_meta`.
Les phases 2 et 3 ajouteront ici les étapes qui téléchargent les sources
(Tanzil, Quranic Arabic Corpus / QUL), vérifient leurs empreintes SHA-256
et remplissent les tables. Aucune donnée coranique n'est saisie à la main.

Usage : python3 tools/build_content/build_content.py [--out CHEMIN]
"""

from __future__ import annotations

import argparse
import json
import os
import sqlite3
import sys
import tempfile

# Version du schéma de la base de contenu (lue par l'application).
CONTENT_SCHEMA_VERSION = 1
# Version des données ; à augmenter à chaque changement de contenu.
CONTENT_VERSION = "0.1.0-socle"

DEFAULT_OUT = os.path.join(
    os.path.dirname(__file__), "..", "..", "assets", "content", "iqura_content.db"
)

SCHEMA = [
    """CREATE TABLE content_meta (
        key TEXT NOT NULL PRIMARY KEY,
        value TEXT NOT NULL
    ) STRICT""",
]


def build(out_path: str) -> None:
    out_path = os.path.abspath(out_path)
    os.makedirs(os.path.dirname(out_path), exist_ok=True)
    # Construction dans un fichier temporaire puis remplacement atomique.
    fd, tmp = tempfile.mkstemp(suffix=".db", dir=os.path.dirname(out_path))
    os.close(fd)
    try:
        con = sqlite3.connect(tmp)
        try:
            for sql in SCHEMA:
                con.execute(sql)
            meta = {
                "schema_version": str(CONTENT_SCHEMA_VERSION),
                "content_version": CONTENT_VERSION,
                # Sources intégrées : aucune en phase 1.
                "sources": json.dumps([], ensure_ascii=False),
            }
            con.executemany(
                "INSERT INTO content_meta (key, value) VALUES (?, ?)",
                sorted(meta.items()),
            )
            con.execute(f"PRAGMA user_version = {CONTENT_SCHEMA_VERSION}")
            con.commit()
            con.execute("VACUUM")
        finally:
            con.close()
        os.chmod(tmp, 0o644)
        os.replace(tmp, out_path)
        # Petit fichier lu au démarrage pour savoir s'il faut recopier la base.
        with open(out_path + ".version", "w", encoding="utf-8") as f:
            f.write(CONTENT_VERSION)
    except BaseException:
        if os.path.exists(tmp):
            os.remove(tmp)
        raise
    print(f"[build_content] {out_path} (contenu {CONTENT_VERSION})", file=sys.stderr)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--out", default=DEFAULT_OUT, help="chemin du fichier généré")
    args = parser.parse_args()
    build(args.out)
    return 0


if __name__ == "__main__":
    sys.exit(main())
