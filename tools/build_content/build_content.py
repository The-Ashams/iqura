#!/usr/bin/env python3
"""Génère iqura_content.db, la base de contenu en lecture seule d'IQURA.

Étapes :
1. vérifie l'empreinte SHA-256 de chaque fichier source (sources/sources.json) ;
2. lit la morphologie du Quranic Arabic Corpus pour en tirer racines, lemmes
   et fréquences (aucun texte coranique n'est écrit dans la base : avenant
   n° 1 au cahier des charges, 24/10/2026) ;
3. lit et contrôle les leçons, les fiches et le monde du jeu, et vérifie
   qu'aucun texte ne reprend une suite de mots du Coran (quran_guard) ;
4. écrit la base dans un fichier temporaire, puis la met en place.

Usage : python3 tools/build_content/build_content.py [--out CHEMIN]
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import sqlite3
import sys
import tempfile
from collections import Counter

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

import buckwalter  # noqa: E402
import lessons  # noqa: E402
import qac  # noqa: E402
import quran_guard  # noqa: E402
import vocab  # noqa: E402
import sources  # noqa: E402
import world  # noqa: E402

# Version du schéma de la base de contenu (lue par l'application).
CONTENT_SCHEMA_VERSION = 9
# Version des données ; à augmenter à chaque changement de contenu.
CONTENT_VERSION = "0.9.0-fondations"

DEFAULT_OUT = os.path.join(
    os.path.dirname(os.path.abspath(__file__)),
    "..", "..", "assets", "content", "iqura_content.db",
)

SCHEMA = [
    """CREATE TABLE content_meta (
        key TEXT NOT NULL PRIMARY KEY,
        value TEXT NOT NULL
    ) STRICT""",
    """CREATE TABLE source (
        id TEXT NOT NULL PRIMARY KEY,
        title TEXT NOT NULL,
        publisher TEXT NOT NULL,
        license TEXT NOT NULL,
        attribution TEXT NOT NULL,
        link TEXT NOT NULL,
        sha256 TEXT NOT NULL,
        retrieved TEXT NOT NULL,
        notes TEXT
    ) STRICT""",
    """CREATE TABLE root (
        id TEXT NOT NULL PRIMARY KEY,
        letters TEXT NOT NULL,
        occurrence_count INTEGER NOT NULL
    ) STRICT""",
    # Données nécessaires à l'arbre des racines (ARCHITECTURE §2 ter).
    # pattern (schème) : aucune source ouverte, reste NULL ; rien n'est deviné.
    """CREATE TABLE lemma (
        id TEXT NOT NULL PRIMARY KEY,
        form TEXT NOT NULL,
        root_id TEXT REFERENCES root(id),
        pos TEXT NOT NULL,
        pos_all TEXT NOT NULL,
        verb_form TEXT CHECK (verb_form IN
            ('I','II','III','IV','V','VI','VII','VIII','IX','X','XI','XII')),
        derivation TEXT CHECK (derivation IN ('ACT_PCPL','PASS_PCPL','VN')),
        pattern TEXT,
        occurrence_count INTEGER NOT NULL
    ) STRICT""",
    # Académie : fiches des lettres et leçons (rédigées par IA).
    """CREATE TABLE articulation_zone (
        id TEXT NOT NULL PRIMARY KEY,
        description TEXT NOT NULL
    ) STRICT""",
    """CREATE TABLE letter (
        letter TEXT NOT NULL PRIMARY KEY,
        name TEXT NOT NULL,
        name_ar TEXT NOT NULL,
        joins_left INTEGER NOT NULL,
        zone_id TEXT NOT NULL REFERENCES articulation_zone(id),
        pronunciation TEXT NOT NULL,
        status TEXT NOT NULL
    ) STRICT""",
    """CREATE TABLE letter_trace (
        letter TEXT NOT NULL PRIMARY KEY REFERENCES letter(letter),
        strokes_json TEXT NOT NULL
    ) STRICT""",
    """CREATE TABLE lesson (
        id TEXT NOT NULL PRIMARY KEY,
        stage INTEGER NOT NULL,
        ordinal INTEGER NOT NULL,
        title TEXT NOT NULL,
        objective TEXT NOT NULL,
        status TEXT NOT NULL,
        content TEXT NOT NULL,
        UNIQUE (stage, ordinal)
    ) STRICT""",
    # Enregistrements audio nécessaires aux leçons (cahier §7).
    """CREATE TABLE audio_clip (
        key TEXT NOT NULL PRIMARY KEY,
        kind TEXT NOT NULL CHECK (kind IN ('lettre','syllabe','mot','phrase')),
        text TEXT NOT NULL,
        file TEXT,
        origin TEXT,
        synthetic INTEGER
    ) STRICT""",
    """CREATE TABLE region (
        id TEXT NOT NULL PRIMARY KEY,
        number INTEGER NOT NULL,
        name TEXT NOT NULL,
        skill TEXT NOT NULL,
        adversary TEXT NOT NULL,
        map_image TEXT NOT NULL
    ) STRICT""",
    """CREATE TABLE place (
        id TEXT NOT NULL PRIMARY KEY,
        region_id TEXT NOT NULL REFERENCES region(id),
        number INTEGER NOT NULL,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        map_x INTEGER NOT NULL,
        map_y INTEGER NOT NULL,
        scene_image TEXT,
        ground_y INTEGER,
        in_j1a INTEGER NOT NULL,
        lessons_json TEXT NOT NULL,
        links_json TEXT NOT NULL
    ) STRICT""",
    """CREATE TABLE character (
        id TEXT NOT NULL PRIMARY KEY,
        region_id TEXT NOT NULL REFERENCES region(id),
        name TEXT NOT NULL,
        name_ar TEXT NOT NULL,
        role TEXT NOT NULL,
        sprite TEXT,
        places_json TEXT NOT NULL
    ) STRICT""",
    """CREATE TABLE item (
        id TEXT NOT NULL PRIMARY KEY,
        name TEXT NOT NULL,
        slot TEXT NOT NULL,
        rarity TEXT NOT NULL,
        price INTEGER NOT NULL,
        region_id TEXT NOT NULL REFERENCES region(id),
        stats_json TEXT NOT NULL,
        set_id TEXT,
        set_json TEXT,
        description TEXT NOT NULL
    ) STRICT""",
    "CREATE INDEX lemma_root ON lemma(root_id)",
    "CREATE INDEX lemma_root_form ON lemma(root_id, verb_form, derivation)",
]


class BuildError(Exception):
    pass


def collect(manifest: dict[str, dict] | None = None) -> dict:
    """Lit et contrôle les sources ; retourne les données à écrire."""
    m = manifest or sources.load_manifest()
    segments, qac_header = qac.read_zip(sources.verified_path("qac-morphology", m))
    return {
        "manifest": m,
        "segments": segments,
        "qac_header": qac_header,
        # Suites de mots du corpus, pour le garde-fou ; jamais écrites.
        "quran_ngrams": quran_guard.ngrams_from_segments(segments),
        "quran_pairs": quran_guard.ngrams_from_segments(segments, quran_guard.PAIR),
    }


def write(con: sqlite3.Connection, data: dict) -> dict[str, int]:
    for sql in SCHEMA:
        con.execute(sql)
    m = data["manifest"]

    con.executemany(
        "INSERT INTO source VALUES (?,?,?,?,?,?,?,?,?)",
        [
            (s["id"], s["title"], s["publisher"], s["license"], s["attribution"],
             s["link"], s["sha256"], s["retrieved"], s.get("notes"))
            for s in m.values()
        ],
    )

    # Racines et lemmes : nombre d'occurrences = nombre de segments.
    root_count: Counter = Counter()
    lemma_count: Counter = Counter()
    lemma_root: dict[str, str | None] = {}
    lemma_pos: dict[str, Counter] = {}
    lemma_form: dict[str, tuple[str | None, str | None]] = {}
    for segs in data["segments"].values():
        for s in segs:
            if s.root:
                root_count[s.root] += 1
            if s.lemma:
                lemma_count[s.lemma] += 1
                previous = lemma_root.setdefault(s.lemma, s.root)
                if previous != s.root:
                    raise BuildError(f"lemme {s.lemma} avec deux racines")
                lemma_pos.setdefault(s.lemma, Counter())[s.pos] += 1
                # Forme verbale et dérivation doivent être constantes pour un
                # lemme ; sinon on s'arrête plutôt que de choisir.
                form = (s.verb_form, s.derivation)
                if lemma_form.setdefault(s.lemma, form) != form:
                    raise BuildError(
                        f"lemme {s.lemma} : forme/dérivation variable "
                        f"{lemma_form[s.lemma]} et {form}"
                    )
    con.executemany(
        "INSERT INTO root VALUES (?,?,?)",
        [(r, buckwalter.to_arabic(r), n) for r, n in sorted(root_count.items())],
    )
    def main_pos(c: Counter) -> str:
        # Catégorie la plus fréquente ; égalité départagée par ordre alphabétique.
        return sorted(c.items(), key=lambda kv: (-kv[1], kv[0]))[0][0]

    con.executemany(
        "INSERT INTO lemma VALUES (?,?,?,?,?,?,?,?,?)",
        [
            (
                lem,
                buckwalter.to_arabic(qac.lemma_display_bw(lem)),
                lemma_root[lem],
                main_pos(lemma_pos[lem]),
                ",".join(sorted(lemma_pos[lem])),
                lemma_form[lem][0],
                lemma_form[lem][1],
                None,
                n,
            )
            for lem, n in sorted(lemma_count.items())
        ],
    )

    lesson_data = data.get("lessons") or lessons.load()
    lessons.validate(lesson_data)
    lesson_counts = lessons.write(con, lesson_data)
    # Vocabulaire (avenant n° 2) : fiches de mots, liées au Corpus.
    words = lesson_data.words or []
    allowed = ({c["lettre"] for c in lesson_data.letters["lettres"]} | set(lessons.FORMS)
               | set(lessons.SIGNS.values()) | {" ", "ـ"})

    def vocab_ar(text: str, where: str) -> None:
        for ch in text:
            if ch not in allowed and not vocab.PUNCT.match(ch):
                raise BuildError(f"{where} : caractère inattendu {ch!r} dans « {text} »")

    order = {l["id"]: (l["etape"], l["ordre"]) for l in lesson_data.lessons}
    vocab.validate(words, con, set(order), vocab_ar)
    lesson_counts["words"] = vocab.write(con, words, order)
    traces = data.get("traces") or lessons.load_traces()
    lessons.validate_traces(traces, lesson_data)
    lesson_counts["traces"] = lessons.write_traces(con, traces)
    world_data = data.get("world") or world.load()
    world.validate(world_data, con)
    world_counts = world.write(con, world_data)
    # Avenant n° 1 : aucune suite de mots du Coran dans le contenu.
    quran_guard.check(
        {**lessons.arabic_texts(lesson_data), **world.arabic_texts(world_data)},
        data["quran_ngrams"],
    )
    quran_guard.check(lessons.inscriptions(lesson_data), data["quran_pairs"], quran_guard.PAIR)
    for warning in vocab.quran_pair_warnings(
            {k: v for k, v in lessons.arabic_texts(lesson_data).items()
             if k.startswith("etape2") or k.startswith("vocab")},
            lesson_data.words or [], data["quran_pairs"]):
        print(f"[build_content] AVERTISSEMENT : {warning}", file=sys.stderr)
    item_data = data.get("items") or world.load_items()
    world.validate_items(item_data, {d["region"]["id"] for d in world_data})
    world_counts["items"] = world.write_items(con, item_data)

    counts = {
        "roots": len(root_count),
        "lemmas": len(lemma_count),
        **lesson_counts,
        **world_counts,
    }
    content_meta = {
        "schema_version": str(CONTENT_SCHEMA_VERSION),
        "content_version": CONTENT_VERSION,
        "counts": json.dumps(counts, sort_keys=True),
        "qac_header": "\n".join(data["qac_header"]),
    }
    con.executemany(
        "INSERT INTO content_meta (key, value) VALUES (?, ?)",
        sorted(content_meta.items()),
    )
    con.execute(f"PRAGMA user_version = {CONTENT_SCHEMA_VERSION}")
    return counts


def build(out_path: str, data: dict | None = None) -> dict[str, int]:
    data = data or collect()
    out_path = os.path.abspath(out_path)
    os.makedirs(os.path.dirname(out_path), exist_ok=True)
    fd, tmp = tempfile.mkstemp(suffix=".db", dir=os.path.dirname(out_path))
    os.close(fd)
    try:
        con = sqlite3.connect(tmp)
        try:
            con.execute("PRAGMA foreign_keys = ON")
            counts = write(con, data)
            con.commit()
            problems = con.execute("PRAGMA foreign_key_check").fetchall()
            if problems:
                raise BuildError(f"références cassées : {problems[:5]}")
            con.execute("VACUUM")
        finally:
            con.close()
        os.chmod(tmp, 0o644)
        os.replace(tmp, out_path)
        # Petit fichier lu au démarrage pour savoir s'il faut recopier la base :
        # la version et l'empreinte de la base, pour que tout changement de
        # contenu soit recopié sur l'appareil, même sans changer de version.
        with open(out_path, "rb") as f:
            digest = hashlib.sha256(f.read()).hexdigest()[:16]
        with open(out_path + ".version", "w", encoding="utf-8") as f:
            f.write(f"{CONTENT_VERSION}+{digest}")
    except BaseException:
        if os.path.exists(tmp):
            os.remove(tmp)
        raise
    size = os.path.getsize(out_path) / 1e6
    print(
        f"[build_content] {out_path} (contenu {CONTENT_VERSION}, {size:.1f} Mo) "
        + json.dumps(counts, sort_keys=True),
        file=sys.stderr,
    )
    return counts


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--out", default=DEFAULT_OUT, help="chemin du fichier généré")
    args = parser.parse_args()
    try:
        build(args.out)
    except (BuildError, sources.SourceError, qac.QacError, quran_guard.QuranGuardError,
            vocab.VocabError,
            lessons.LessonError, world.WorldError) as e:
        print(f"[build_content] ÉCHEC : {e}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
