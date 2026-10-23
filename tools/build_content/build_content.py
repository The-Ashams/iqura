#!/usr/bin/env python3
"""Génère iqura_content.db, la base de contenu en lecture seule d'IQURA.

Étapes :
1. vérifie l'empreinte SHA-256 de chaque fichier source (sources/sources.json) ;
2. lit le texte coranique Tanzil (Uthmani + version sans voyelles pour la
   recherche), les métadonnées, la traduction Hamidullah ;
3. lit la morphologie du Quranic Arabic Corpus et l'aligne sur les mots
   Tanzil (100 % des versets alignés, sinon échec) ;
4. écrit la base dans un fichier temporaire, puis la met en place.

Aucune donnée coranique n'est saisie à la main ni modifiée : les textes sont
copiés tels quels depuis les sources.

Usage : python3 tools/build_content/build_content.py [--out CHEMIN]
"""

from __future__ import annotations

import argparse
import json
import os
import sqlite3
import sys
import tempfile
from collections import Counter

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

import align  # noqa: E402
import buckwalter  # noqa: E402
import lessons  # noqa: E402
import qac  # noqa: E402
import sources  # noqa: E402
import tanzil  # noqa: E402
import world  # noqa: E402

# Version du schéma de la base de contenu (lue par l'application).
CONTENT_SCHEMA_VERSION = 6
# Version des données ; à augmenter à chaque changement de contenu.
CONTENT_VERSION = "0.5.0-j1a"

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
    """CREATE TABLE surah (
        id INTEGER NOT NULL PRIMARY KEY,
        name_ar TEXT NOT NULL,
        name_translit TEXT NOT NULL,
        name_en TEXT NOT NULL,
        revelation_place TEXT NOT NULL,
        revelation_order INTEGER NOT NULL,
        ayah_count INTEGER NOT NULL,
        bismillah TEXT
    ) STRICT""",
    """CREATE TABLE verse (
        id INTEGER NOT NULL PRIMARY KEY,
        surah_id INTEGER NOT NULL REFERENCES surah(id),
        ayah INTEGER NOT NULL,
        text_uthmani TEXT NOT NULL,
        text_search TEXT NOT NULL,
        juz INTEGER NOT NULL,
        hizb_quarter INTEGER NOT NULL,
        page INTEGER NOT NULL,
        sajda TEXT,
        UNIQUE (surah_id, ayah)
    ) STRICT""",
    """CREATE TABLE translation (
        id TEXT NOT NULL PRIMARY KEY,
        language TEXT NOT NULL,
        name TEXT NOT NULL,
        translator TEXT NOT NULL,
        source_id TEXT NOT NULL REFERENCES source(id)
    ) STRICT""",
    """CREATE TABLE verse_translation (
        verse_id INTEGER NOT NULL REFERENCES verse(id),
        translation_id TEXT NOT NULL REFERENCES translation(id),
        text TEXT NOT NULL,
        PRIMARY KEY (verse_id, translation_id)
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
    """CREATE TABLE token (
        id TEXT NOT NULL PRIMARY KEY,
        verse_id INTEGER NOT NULL REFERENCES verse(id),
        position INTEGER NOT NULL,
        text TEXT NOT NULL,
        UNIQUE (verse_id, position)
    ) STRICT""",
    """CREATE TABLE segment (
        id TEXT NOT NULL PRIMARY KEY,
        verse_id INTEGER NOT NULL REFERENCES verse(id),
        corpus_word INTEGER NOT NULL,
        position INTEGER NOT NULL,
        form TEXT NOT NULL,
        form_bw TEXT NOT NULL,
        tag TEXT NOT NULL,
        kind TEXT NOT NULL,
        pos TEXT,
        lemma_id TEXT REFERENCES lemma(id),
        root_id TEXT REFERENCES root(id),
        features TEXT NOT NULL
    ) STRICT""",
    """CREATE TABLE token_segment (
        token_id TEXT NOT NULL REFERENCES token(id),
        segment_id TEXT NOT NULL REFERENCES segment(id),
        PRIMARY KEY (token_id, segment_id)
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
    # Références coraniques des leçons : le texte n'est jamais recopié.
    """CREATE TABLE lesson_quran_ref (
        lesson_id TEXT NOT NULL REFERENCES lesson(id),
        verse_id INTEGER NOT NULL REFERENCES verse(id),
        token_id TEXT REFERENCES token(id)
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
    "CREATE INDEX segment_lemma ON segment(lemma_id)",
    "CREATE INDEX segment_root ON segment(root_id)",
    "CREATE INDEX token_verse ON token(verse_id)",
    "CREATE INDEX token_segment_segment ON token_segment(segment_id)",
    "CREATE INDEX lemma_root ON lemma(root_id)",
    "CREATE INDEX lemma_root_form ON lemma(root_id, verb_form, derivation)",
]


class BuildError(Exception):
    pass


def collect(manifest: dict[str, dict] | None = None) -> dict:
    """Lit et contrôle toutes les sources ; retourne les données à écrire."""
    m = manifest or sources.load_manifest()
    uthmani = tanzil.read_text_xml(sources.verified_path("tanzil-uthmani", m))
    clean = tanzil.read_text_xml(sources.verified_path("tanzil-simple-clean", m))
    meta = tanzil.read_metadata(sources.verified_path("tanzil-metadata", m))
    translation, translation_header = tanzil.read_translation_txt(
        sources.verified_path("tanzil-fr-hamidullah", m)
    )
    segments, qac_header = qac.read_zip(sources.verified_path("qac-morphology", m))

    clean_by_key = clean.by_key()
    keys = [v.key for v in uthmani.verses]
    if keys != [v.key for v in clean.verses]:
        raise BuildError("les deux textes Tanzil n'ont pas les mêmes versets")
    if set(translation) != set(keys):
        raise BuildError("la traduction ne couvre pas exactement les versets")
    if set(segments) != set(keys):
        raise BuildError("la morphologie ne couvre pas exactement les versets")
    for sm in meta.surahs:
        count = sum(1 for k in keys if k[0] == sm.index)
        if count != sm.ayas:
            raise BuildError(f"sourate {sm.index} : {count} versets, métadonnées {sm.ayas}")

    alignments = {}
    failures = []
    differing_word_counts = []
    for v in uthmani.verses:
        words = v.words()
        try:
            alignments[v.key] = align.align_verse(words, segments[v.key])
        except align.AlignmentError as e:
            failures.append(f"{v.surah}:{v.ayah} : {e}")
        corpus_words = len({s.word for s in segments[v.key]})
        if corpus_words != len(words):
            differing_word_counts.append(f"{v.surah}:{v.ayah}")
    if failures:
        raise BuildError(
            f"{len(failures)} verset(s) non alignés :\n" + "\n".join(failures[:20])
        )

    return {
        "manifest": m,
        "uthmani": uthmani,
        "clean": clean_by_key,
        "meta": meta,
        "translation": translation,
        "translation_header": translation_header,
        "segments": segments,
        "qac_header": qac_header,
        "alignments": alignments,
        "differing_word_counts": differing_word_counts,
    }


def write(con: sqlite3.Connection, data: dict) -> dict[str, int]:
    for sql in SCHEMA:
        con.execute(sql)
    m = data["manifest"]
    uthmani: tanzil.QuranText = data["uthmani"]
    meta: tanzil.Metadata = data["meta"]

    con.executemany(
        "INSERT INTO source VALUES (?,?,?,?,?,?,?,?,?)",
        [
            (s["id"], s["title"], s["publisher"], s["license"], s["attribution"],
             s["link"], s["sha256"], s["retrieved"], s.get("notes"))
            for s in m.values()
        ],
    )

    con.executemany(
        "INSERT INTO surah VALUES (?,?,?,?,?,?,?,?)",
        [
            (sm.index, sm.name, sm.tname, sm.ename, sm.type, sm.order, sm.ayas,
             uthmani.bismillah.get(sm.index))
            for sm in meta.surahs
        ],
    )

    verse_id = {}
    rows = []
    for i, v in enumerate(uthmani.verses, 1):
        verse_id[v.key] = i
        rows.append((
            i, v.surah, v.ayah, v.text, data["clean"][v.key].text,
            tanzil.division_of(meta.juzs, v.key),
            tanzil.division_of(meta.quarters, v.key),
            tanzil.division_of(meta.pages, v.key),
            meta.sajdas.get(v.key),
        ))
    con.executemany("INSERT INTO verse VALUES (?,?,?,?,?,?,?,?,?)", rows)

    con.execute(
        "INSERT INTO translation VALUES (?,?,?,?,?)",
        ("fr.hamidullah", "fr", "Hamidullah", "Muhammad Hamidullah",
         "tanzil-fr-hamidullah"),
    )
    con.executemany(
        "INSERT INTO verse_translation VALUES (?,?,?)",
        [(verse_id[k], "fr.hamidullah", t) for k, t in data["translation"].items()],
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

    token_rows, segment_rows, link_rows = [], [], []
    for v in uthmani.verses:
        vid = verse_id[v.key]
        words = v.words()
        for p, w in enumerate(words, 1):
            token_rows.append((f"{v.surah}:{v.ayah}:{p}", vid, p, w))
        alignment = data["alignments"][v.key]
        for s, word_indices in zip(data["segments"][v.key], alignment.segment_words):
            segment_rows.append((
                s.location, vid, s.word, s.index, s.form, s.form_bw, s.tag,
                s.kind, s.pos, s.lemma, s.root, s.features,
            ))
            for wi in word_indices:
                link_rows.append((f"{v.surah}:{v.ayah}:{wi + 1}", s.location))
    con.executemany("INSERT INTO token VALUES (?,?,?,?)", token_rows)
    con.executemany(
        "INSERT INTO segment VALUES (?,?,?,?,?,?,?,?,?,?,?,?)", segment_rows
    )
    con.executemany("INSERT INTO token_segment VALUES (?,?)", link_rows)

    lesson_data = data.get("lessons") or lessons.load()
    lessons.validate(lesson_data, con)
    lesson_counts = lessons.write(con, lesson_data)
    world_data = data.get("world") or world.load()
    world.validate(world_data, con)
    world_counts = world.write(con, world_data)

    counts = {
        "surahs": len(meta.surahs),
        "verses": len(uthmani.verses),
        "tokens": len(token_rows),
        "segments": len(segment_rows),
        "roots": len(root_count),
        "lemmas": len(lemma_count),
        **lesson_counts,
        **world_counts,
    }
    content_meta = {
        "schema_version": str(CONTENT_SCHEMA_VERSION),
        "content_version": CONTENT_VERSION,
        "quran_text_sha256": tanzil.integrity_sha256(uthmani),
        "counts": json.dumps(counts, sort_keys=True),
        # Versets où Tanzil et le Corpus ne comptent pas le même nombre de
        # mots (tous alignés lettre par lettre malgré tout).
        "alignment_word_count_differences": json.dumps(data["differing_word_counts"]),
        "translation_header": "\n".join(data["translation_header"]),
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
        # Petit fichier lu au démarrage pour savoir s'il faut recopier la base.
        with open(out_path + ".version", "w", encoding="utf-8") as f:
            f.write(CONTENT_VERSION)
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
    except (BuildError, sources.SourceError, tanzil.TanzilError, qac.QacError,
            lessons.LessonError, world.WorldError) as e:
        print(f"[build_content] ÉCHEC : {e}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
