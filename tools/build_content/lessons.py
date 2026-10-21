"""Lecture et contrôle des leçons (tools/build_content/lessons/).

Contrôles :
- identifiants uniques, ordre continu, prérequis existants et antérieurs ;
- un exemple ou une syllabe n'utilise que des lettres et des signes déjà
  introduits (leçon courante comprise) ;
- chaque référence coranique existe, et chaque lettre à repérer figure dans
  au moins un des mots cités ;
- les fiches citées existent ;
- aucun texte coranique n'est recopié dans une leçon (seulement des
  références) : vérifié en refusant tout champ `ar` dans une section `coran`.

La cohérence des translittérations avec le moteur de l'application est
vérifiée par les tests Dart (test/data/lessons_test.dart).
"""

from __future__ import annotations

import glob
import hashlib
import json
import os
import re
import sqlite3
import unicodedata
from dataclasses import dataclass

LESSONS_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "lessons")

SIGNS = {
    "fatha": "َ",
    "kasra": "ِ",
    "damma": "ُ",
    "sukun": "ْ",
    "shadda": "ّ",
    "fathatan": "ً",
    "kasratan": "ٍ",
    "dammatan": "ٌ",
}

SECTION_TYPES = {
    "texte", "regle", "encadre", "lettres", "syllabes", "exemples",
    "decomposition", "coran",
}
EXERCISE_TYPES = {
    "qcm", "reconnaitre_lettre", "formes", "points", "lire", "reconstruire",
    "reperer", "controle_final",
}
VERSE_REF = re.compile(r"^(\d+):(\d+)$")
TOKEN_REF = re.compile(r"^(\d+):(\d+):(\d+)$")


class LessonError(Exception):
    pass


@dataclass
class LessonData:
    letters: dict
    lessons: list[dict]


def load(base: str = LESSONS_DIR) -> LessonData:
    with open(os.path.join(base, "lettres.json"), encoding="utf-8") as f:
        letters = json.load(f)
    lessons = []
    for path in sorted(glob.glob(os.path.join(base, "etape*", "*.json"))):
        with open(path, encoding="utf-8") as f:
            lesson = json.load(f)
        lesson["_file"] = os.path.relpath(path, base)
        lessons.append(lesson)
    return LessonData(letters, lessons)


def validate(data: LessonData, con: sqlite3.Connection) -> None:
    """Lève LessonError à la première incohérence. `con` : base de contenu
    déjà remplie (versets et mots)."""
    zones = data.letters["zones"]
    letter_cards = {}
    for card in data.letters["lettres"]:
        if card["lettre"] in letter_cards:
            raise LessonError(f"fiche en double : {card['lettre']}")
        if card["zone"] not in zones:
            raise LessonError(f"{card['lettre']} : zone inconnue {card['zone']}")
        letter_cards[card["lettre"]] = card

    ids = set()
    by_stage: dict[int, list[dict]] = {}
    for lesson in data.lessons:
        where = lesson["_file"]
        for key in ("id", "etape", "ordre", "titre", "objectif", "statut",
                    "prerequis", "introduit", "sections", "exercices"):
            if key not in lesson:
                raise LessonError(f"{where} : champ « {key} » absent")
        if lesson["id"] in ids:
            raise LessonError(f"{where} : identifiant en double {lesson['id']}")
        if lesson["statut"] != "ia_non_verifie":
            raise LessonError(f"{where} : statut inattendu {lesson['statut']}")
        ids.add(lesson["id"])
        by_stage.setdefault(lesson["etape"], []).append(lesson)

    order_of = {}
    for stage, lessons in by_stage.items():
        lessons.sort(key=lambda l: l["ordre"])
        if [l["ordre"] for l in lessons] != list(range(len(lessons))):
            raise LessonError(f"étape {stage} : ordre des leçons non continu")
        for l in lessons:
            order_of[l["id"]] = (stage, l["ordre"])

    for stage, lessons in sorted(by_stage.items()):
        known_letters: set[str] = set()
        known_signs: set[str] = set()
        for lesson in lessons:
            where = lesson["_file"]
            for pre in lesson["prerequis"]:
                if pre not in order_of or order_of[pre] >= order_of[lesson["id"]]:
                    raise LessonError(f"{where} : prérequis invalide {pre}")
            intro = lesson["introduit"]
            for c in intro["lettres"]:
                if c not in letter_cards:
                    raise LessonError(f"{where} : lettre sans fiche {c}")
            for sign in intro["signes"]:
                if sign not in SIGNS:
                    raise LessonError(f"{where} : signe inconnu {sign}")
            known_letters |= set(intro["lettres"])
            known_signs |= {SIGNS[s] for s in intro["signes"]}

            def check_text(text: str, what: str) -> None:
                for ch in text:
                    if ch in known_letters or ch in known_signs:
                        continue
                    name = unicodedata.name(ch, hex(ord(ch)))
                    raise LessonError(
                        f"{where} : {what} « {text} » utilise {ch} ({name}), "
                        "pas encore enseigné"
                    )

            for section in lesson["sections"]:
                kind = section.get("type")
                if kind not in SECTION_TYPES:
                    raise LessonError(f"{where} : section inconnue {kind}")
                if kind == "lettres":
                    for c in section["lettres"]:
                        if c not in intro["lettres"]:
                            raise LessonError(f"{where} : fiche {c} hors leçon")
                if kind in ("syllabes", "exemples"):
                    for item in section["items"]:
                        if not item.get("translit"):
                            raise LessonError(f"{where} : translittération absente")
                        check_text(item["ar"], "l'exemple")
                if kind == "coran":
                    _check_quran_section(section, con, where)

            finals = [ex for ex in lesson["exercices"] if ex.get("type") == "controle_final"]
            if len(finals) != 1 or lesson["exercices"][-1] is not finals[0]:
                raise LessonError(f"{where} : un contrôle final, en dernier, est obligatoire")
            for ex in lesson["exercices"]:
                if ex.get("type") not in EXERCISE_TYPES:
                    raise LessonError(f"{where} : exercice inconnu {ex.get('type')}")
                for c in ex.get("lettres", []):
                    if c not in known_letters:
                        raise LessonError(f"{where} : exercice sur {c}, non enseignée")


def _check_quran_section(section: dict, con: sqlite3.Connection, where: str) -> None:
    for extract in section["extraits"]:
        if set(extract) - {"verset", "mots", "lettres"}:
            raise LessonError(
                f"{where} : champ interdit dans un extrait coranique "
                f"{sorted(set(extract) - {'verset', 'mots', 'lettres'})} "
                "(le texte n'est jamais recopié, seulement référencé)"
            )
        m = VERSE_REF.match(extract["verset"])
        if not m:
            raise LessonError(f"{where} : référence de verset invalide {extract['verset']}")
        row = con.execute(
            "SELECT id FROM verse WHERE surah_id = ? AND ayah = ?",
            (int(m[1]), int(m[2])),
        ).fetchone()
        if row is None:
            raise LessonError(f"{where} : verset inexistant {extract['verset']}")
        texts = []
        for tok in extract.get("mots", []):
            tm = TOKEN_REF.match(tok)
            if not tm or f"{tm[1]}:{tm[2]}" != extract["verset"]:
                raise LessonError(f"{where} : mot {tok} hors du verset {extract['verset']}")
            r = con.execute("SELECT text FROM token WHERE id = ?", (tok,)).fetchone()
            if r is None:
                raise LessonError(f"{where} : mot inexistant {tok}")
            texts.append(r[0])
        for letter in extract.get("lettres", []):
            if not any(letter in t for t in texts):
                raise LessonError(
                    f"{where} : la lettre {letter} n'est dans aucun mot cité de "
                    f"{extract['verset']}"
                )


def audio_key(text: str) -> str:
    """Identifiant stable d'un enregistrement : empreinte du texte arabe
    (forme NFC)."""
    norm = unicodedata.normalize("NFC", text)
    return "ar-" + hashlib.sha256(norm.encode("utf-8")).hexdigest()[:16]


def audio_clips(data: LessonData) -> dict[str, tuple[str, str]]:
    """Enregistrements nécessaires aux leçons : clé → (genre, texte arabe).

    Lettres (le nom de la lettre), syllabes, mots et décompositions. Les
    extraits coraniques n'en font pas partie : ils viendront des récitations.
    """
    clips: dict[str, tuple[str, str]] = {}

    def add(kind: str, text: str) -> None:
        clips.setdefault(audio_key(text), (kind, text))

    for card in data.letters["lettres"]:
        add("lettre", card["nom_ar"])
    for lesson in data.lessons:
        for section in lesson["sections"]:
            if section["type"] == "syllabes":
                for item in section["items"]:
                    add("syllabe", item["ar"])
            elif section["type"] == "exemples":
                for item in section["items"]:
                    add("mot" if " " not in item["ar"] else "phrase", item["ar"])
            elif section["type"] == "decomposition":
                add("mot", section["ar"])
    return clips


def write(con: sqlite3.Connection, data: LessonData) -> dict[str, int]:
    con.executemany(
        "INSERT INTO articulation_zone VALUES (?, ?)",
        sorted(data.letters["zones"].items()),
    )
    con.executemany(
        "INSERT INTO letter VALUES (?,?,?,?,?,?,?)",
        [
            (c["lettre"], c["nom"], c["nom_ar"], 1 if c["liaison_gauche"] else 0,
             c["zone"], c["prononciation"], data.letters["statut"])
            for c in data.letters["lettres"]
        ],
    )
    refs = []
    for lesson in data.lessons:
        content = {k: v for k, v in lesson.items() if not k.startswith("_")}
        con.execute(
            "INSERT INTO lesson VALUES (?,?,?,?,?,?,?)",
            (lesson["id"], lesson["etape"], lesson["ordre"], lesson["titre"],
             lesson["objectif"], lesson["statut"],
             json.dumps(content, ensure_ascii=False, sort_keys=True)),
        )
        for section in lesson["sections"]:
            if section["type"] != "coran":
                continue
            for extract in section["extraits"]:
                s, a = (int(x) for x in extract["verset"].split(":"))
                vid = con.execute(
                    "SELECT id FROM verse WHERE surah_id = ? AND ayah = ?", (s, a)
                ).fetchone()[0]
                refs.append((lesson["id"], vid, None))
                for tok in extract.get("mots", []):
                    refs.append((lesson["id"], vid, tok))
    con.executemany("INSERT INTO lesson_quran_ref VALUES (?,?,?)", refs)
    clips = audio_clips(data)
    # Fichier, origine et indication « synthèse » : remplis quand la solution
    # audio sera choisie (décision ouverte n° 1). NULL = pas encore d'audio.
    con.executemany(
        "INSERT INTO audio_clip (key, kind, text) VALUES (?,?,?)",
        [(k, kind, text) for k, (kind, text) in sorted(clips.items())],
    )
    return {"lessons": len(data.lessons), "letters": len(data.letters["lettres"]),
            "audio_clips": len(clips)}
