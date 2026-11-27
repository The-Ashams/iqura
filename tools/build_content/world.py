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


# ---------------------------------------------------------------------------
# Objets (boutique, équipement)

STATS = {"pv", "attaque", "defense", "critique", "concentration"}
ITEMS_FILE = os.path.join(WORLD_DIR, "objets.json")


def load_items(path: str = ITEMS_FILE) -> dict:
    with open(path, encoding="utf-8") as f:
        return json.load(f)


def validate_items(data: dict, region_ids: set[str]) -> None:
    if data.get("statut") != "ia":
        raise WorldError("objets : statut « ia » attendu (descriptions rédigées par IA)")
    seen = set()
    for it in data["objets"]:
        where = f"objet {it.get('id')}"
        if it["id"] in seen:
            raise WorldError(f"{where} : en double")
        seen.add(it["id"])
        if it["emplacement"] not in data["emplacements"]:
            raise WorldError(f"{where} : emplacement inconnu {it['emplacement']}")
        if it["rarete"] not in data["raretes"]:
            raise WorldError(f"{where} : rareté inconnue {it['rarete']}")
        if not isinstance(it["prix"], int) or it["prix"] <= 0:
            raise WorldError(f"{where} : prix invalide")
        if it["region"] not in region_ids:
            raise WorldError(f"{where} : région inconnue {it['region']}")
        if not it["stats"] or set(it["stats"]) - STATS or any(
                not isinstance(v, int) or v <= 0 for v in it["stats"].values()):
            raise WorldError(f"{where} : statistiques invalides")
        if "ensemble" in it and it["ensemble"] not in data["ensembles"]:
            raise WorldError(f"{where} : ensemble inconnu {it['ensemble']}")
    for sid, e in data["ensembles"].items():
        if set(e["bonus"]) - STATS:
            raise WorldError(f"ensemble {sid} : bonus invalide")


def write_items(con: sqlite3.Connection, data: dict) -> int:
    for it in data["objets"]:
        e = data["ensembles"].get(it.get("ensemble", ""))
        con.execute(
            "INSERT INTO item VALUES (?,?,?,?,?,?,?,?,?,?)",
            (it["id"], it["nom"], it["emplacement"], it["rarete"], it["prix"], it["region"],
             json.dumps(it["stats"]), it.get("ensemble"),
             json.dumps({"nom": e["nom"], "pieces": e["pieces"], "bonus": e["bonus"]}) if e else None,
             it["description"]),
        )
    return len(data["objets"])


def arabic_texts(regions: list[dict]) -> dict[str, str]:
    """Textes arabes du monde (noms de personnages), pour le garde-fou
    coranique."""
    out = {}
    for r in regions:
        for c in r["personnages"]:
            if c.get("nom_ar"):
                out[f"monde · {c['id']}"] = c["nom_ar"]
    return out
