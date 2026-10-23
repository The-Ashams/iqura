"""Lecture et contrôle du monde du jeu (tools/build_content/world/).

Contrôles : identifiants uniques ; liens et lieux de personnages existants ;
positions dans la carte (160 × 90) ; images citées présentes dans
tools/build_art/art/ ; chaque lieu de la tranche J1a a sa scène, et ses
leçons existent déjà (étape de la région).
"""

from __future__ import annotations

import glob
import json
import os
import sqlite3

HERE = os.path.dirname(os.path.abspath(__file__))
WORLD_DIR = os.path.join(HERE, "world")
ART_DIR = os.path.normpath(os.path.join(HERE, "..", "build_art", "art"))
MAP_W, MAP_H = 160, 90


class WorldError(Exception):
    pass


def load(base: str = WORLD_DIR) -> list[dict]:
    regions = []
    for path in sorted(glob.glob(os.path.join(base, "region*.json"))):
        with open(path, encoding="utf-8") as f:
            regions.append(json.load(f))
    return regions


def _art_exists(name: str) -> bool:
    return os.path.exists(os.path.join(ART_DIR, f"{name}.json"))


def validate(regions: list[dict], con: sqlite3.Connection) -> None:
    lessons_by_stage: dict[int, set[int]] = {}
    for stage, ordinal in con.execute("SELECT stage, ordinal FROM lesson"):
        lessons_by_stage.setdefault(stage, set()).add(ordinal)
    region_ids = set()
    for data in regions:
        r = data["region"]
        if r["id"] in region_ids:
            raise WorldError(f"région en double : {r['id']}")
        region_ids.add(r["id"])
        if data.get("statut") != "ia":
            raise WorldError(f"{r['id']} : statut « ia » attendu (descriptions rédigées par IA)")
        if not _art_exists(r["carte"]):
            raise WorldError(f"{r['id']} : carte absente {r['carte']}")
        places = {}
        for p in data["lieux"]:
            if p["id"] in places:
                raise WorldError(f"lieu en double : {p['id']}")
            places[p["id"]] = p
        for p in data["lieux"]:
            x, y = p["position"]
            if not (0 <= x < MAP_W and 0 <= y < MAP_H):
                raise WorldError(f"{p['id']} : position hors de la carte {p['position']}")
            for link in p["liens"]:
                if link not in places:
                    raise WorldError(f"{p['id']} : lien vers un lieu inconnu {link}")
            if p["scene"] is not None and not _art_exists(p["scene"]):
                raise WorldError(f"{p['id']} : scène absente {p['scene']}")
            if p["tranche_j1a"]:
                if p["scene"] is None:
                    raise WorldError(f"{p['id']} : lieu de la tranche J1a sans scène")
                if not 0 < p.get("sol", 0) <= MAP_H:
                    raise WorldError(f"{p['id']} : hauteur du sol absente ou invalide")
                missing = set(p["lecons"]) - lessons_by_stage.get(r["numero"], set())
                if missing:
                    raise WorldError(f"{p['id']} : leçons inexistantes {sorted(missing)}")
        for c in data["personnages"]:
            for place in c["lieux"]:
                if place not in places:
                    raise WorldError(f"{c['id']} : lieu inconnu {place}")
            if c["sprite"] is not None and not _art_exists(c["sprite"]):
                raise WorldError(f"{c['id']} : image absente {c['sprite']}")


def write(con: sqlite3.Connection, regions: list[dict]) -> dict[str, int]:
    n_places = n_chars = 0
    for data in regions:
        r = data["region"]
        con.execute("INSERT INTO region VALUES (?,?,?,?,?,?)",
                    (r["id"], r["numero"], r["nom"], r["competence"], r["adversaire"], r["carte"]))
        for p in data["lieux"]:
            con.execute(
                "INSERT INTO place VALUES (?,?,?,?,?,?,?,?,?,?,?,?)",
                (p["id"], r["id"], p["numero"], p["nom"], p["description"],
                 p["position"][0], p["position"][1], p["scene"], p.get("sol"),
                 1 if p["tranche_j1a"] else 0,
                 json.dumps(p["lecons"]), json.dumps(p["liens"])),
            )
            n_places += 1
        for c in data["personnages"]:
            con.execute("INSERT INTO character VALUES (?,?,?,?,?,?,?)",
                        (c["id"], r["id"], c["nom"], c["nom_ar"], c["role"], c["sprite"],
                         json.dumps(c["lieux"])))
            n_chars += 1
    return {"regions": len(regions), "places": n_places, "characters": n_chars}
