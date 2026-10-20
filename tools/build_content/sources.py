"""Accès aux fichiers sources versionnés, vérifiés par SHA-256."""

from __future__ import annotations

import hashlib
import json
import os

SOURCES_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "sources")
MANIFEST = os.path.join(SOURCES_DIR, "sources.json")


class SourceError(Exception):
    pass


def load_manifest(path: str = MANIFEST) -> dict[str, dict]:
    with open(path, encoding="utf-8") as f:
        data = json.load(f)
    return {s["id"]: s for s in data["sources"]}


def sha256_file(path: str) -> str:
    h = hashlib.sha256()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def verified_path(source_id: str, manifest: dict[str, dict] | None = None,
                  base: str = SOURCES_DIR) -> str:
    """Chemin d'une source, après vérification de son empreinte."""
    m = manifest or load_manifest()
    if source_id not in m:
        raise SourceError(f"source inconnue : {source_id}")
    entry = m[source_id]
    path = os.path.join(base, entry["path"])
    if not os.path.exists(path):
        raise SourceError(f"fichier source absent : {entry['path']}")
    actual = sha256_file(path)
    if actual != entry["sha256"]:
        raise SourceError(
            f"empreinte incorrecte pour {entry['path']} : {actual} "
            f"(attendu {entry['sha256']})"
        )
    return path


def verify_all(manifest: dict[str, dict] | None = None) -> None:
    m = manifest or load_manifest()
    for source_id in m:
        verified_path(source_id, m)
