#!/usr/bin/env python3
"""Retélécharge les sources Tanzil et les compare aux copies versionnées.

N'écrase rien : les fichiers téléchargés vont dans un dossier temporaire et
le script indique lesquels diffèrent (mise à jour de Tanzil, changement
d'année dans l'en-tête…). Pour adopter une nouvelle version, copier le
fichier dans sources/ et mettre à jour son empreinte dans sources.json,
puis relancer les tests.

La morphologie du Quranic Arabic Corpus n'est pas retéléchargée : le site
demande une adresse e-mail (https://corpus.quran.com/download/).

Usage : python3 tools/build_content/fetch_sources.py
"""

from __future__ import annotations

import os
import sys
import tempfile
import urllib.request

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import sources  # noqa: E402

AUTOMATIC = ("tanzil-uthmani", "tanzil-simple-clean", "tanzil-metadata", "tanzil-fr-hamidullah")


def main() -> int:
    manifest = sources.load_manifest()
    out_dir = tempfile.mkdtemp(prefix="iqura-sources-")
    differ = 0
    for sid in AUTOMATIC:
        entry = manifest[sid]
        target = os.path.join(out_dir, os.path.basename(entry["path"]))
        with urllib.request.urlopen(entry["url"], timeout=60) as r, open(target, "wb") as f:
            f.write(r.read())
        digest = sources.sha256_file(target)
        same = digest == entry["sha256"]
        differ += not same
        print(f"{'identique' if same else 'DIFFÉRENT'}  {sid}  {digest}")
    print(f"Fichiers téléchargés dans {out_dir}")
    return 1 if differ else 0


if __name__ == "__main__":
    sys.exit(main())
