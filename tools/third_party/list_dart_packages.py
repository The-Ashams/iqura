#!/usr/bin/env python3
"""Inventaire des paquets Dart (pubspec.lock) avec licence et éditeur.

Interroge l'API publique de pub.dev. Sortie : tableau Markdown, à reporter
dans THIRD_PARTY_LICENSES.md (section « Inventaire complet »).

Usage : python3 tools/third_party/list_dart_packages.py [pubspec.lock]
"""

from __future__ import annotations

import json
import re
import sys
import urllib.request


def parse_lock(path: str) -> list[tuple[str, str, str, str]]:
    """(nom, version, type de dépendance, source) pour chaque paquet."""
    text = open(path, encoding="utf-8").read()
    out = []
    for m in re.finditer(
        r"^  ([a-z0-9_]+):\n((?:    .*\n|      .*\n)+)", text, re.MULTILINE
    ):
        body = m.group(2)
        dep = re.search(r'dependency: "?([^"\n]+)"?', body).group(1)
        source = re.search(r"source: (\S+)", body).group(1)
        version = re.search(r'version: "([^"]+)"', body).group(1)
        out.append((m.group(1), version, dep, source))
    return out


def fetch(url: str):
    with urllib.request.urlopen(url, timeout=30) as r:
        return json.load(r)


def main() -> int:
    lock = sys.argv[1] if len(sys.argv) > 1 else "pubspec.lock"
    print("| Paquet | Version | Type | Licence (pub.dev) | Éditeur vérifié |")
    print("| --- | --- | --- | --- | --- |")
    for name, version, dep, source in sorted(parse_lock(lock)):
        if source != "hosted":
            print(f"| {name} | {version} | {dep} | SDK Flutter (BSD-3-Clause) | flutter.dev |")
            continue
        score = fetch(f"https://pub.dev/api/packages/{name}/score")
        publisher = fetch(f"https://pub.dev/api/packages/{name}/publisher").get(
            "publisherId"
        )
        licenses = [
            t.split(":", 1)[1]
            for t in score.get("tags", [])
            if t.startswith("license:") and t not in ("license:fsf-libre", "license:osi-approved")
        ]
        lic = ", ".join(licenses) or "INCONNUE — à vérifier"
        print(f"| {name} | {version} | {dep} | {lic} | {publisher or 'aucun'} |")
    return 0


if __name__ == "__main__":
    sys.exit(main())
