"""Lecture et contrôle des leçons (tools/build_content/lessons/).

Contrôles :
- identifiants uniques, ordre continu, prérequis existants et antérieurs ;
- leçons au format mini-donjon (format 2), contrôlées par `mini_donjon.py` :
  un exemple ou une syllabe n'utilise que des lettres et des signes déjà
  introduits (leçon courante comprise) ;
- les fiches citées existent ;
- aucun texte coranique : plus aucune référence ni salle d'étude coranique
  (avenant n° 1, 24/10/2026) ; le garde-fou `quran_guard.py` vérifie en plus
  qu'aucun texte ne reprend une suite de mots du Coran.

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

import mini_donjon
import world

LESSONS_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "lessons")
REPO_ROOT = os.path.normpath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", ".."))
AUDIO_MANIFEST = os.path.join(REPO_ROOT, "tools", "build_audio", "clips.json")

SIGNS = {
    "fatha": "َ",
    "kasra": "ِ",
    "damma": "ُ",
    "sukun": "ْ",
    "shadda": "ّ",
    "fathatan": "ً",
    "kasratan": "ٍ",
    "dammatan": "ٌ",
    # Signes de l'écriture du Mushaf (leçon 14, reconnaissance seulement).
    "alif_suscrit": "\u0670",
    "madda": "\u0653",
    "petit_waw": "\u06e5",
    "petit_ya": "\u06e6",
    "rond_muet": "\u06df",
}

# Formes d'écriture enseignées par une règle, sans fiche de lettre : supports
# de la hamza, madda, fins de mots (cahier v3 §5.1, leçons 9 et 10).
FORMS = {
    "أ": "hamza sur alif",
    "إ": "hamza sous alif",
    "ؤ": "hamza sur wāw",
    "ئ": "hamza sur yāʾ sans points",
    "آ": "alif madda",
    "ة": "tāʾ marbūṭa",
    "ى": "alif maqṣūra",
    "ٱ": "alif waṣla (écriture du Mushaf)",
}



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


def validate(data: LessonData) -> None:
    """Lève LessonError à la première incohérence."""
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
        if lesson.get("format") != 2:
            raise LessonError(f"{where} : seul le format mini-donjon (format 2) est accepté")
        for key in ("id", "etape", "ordre", "titre", "objectif", "statut",
                    "prerequis", "introduit", "ecrans"):
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

    regions = world.load()
    places = {p["id"] for r in regions for p in r["lieux"]}
    characters = {c["id"] for r in regions for c in r["personnages"]}

    for stage, lessons in sorted(by_stage.items()):
        known_letters: set[str] = set()
        known_signs: set[str] = set()
        known_readings: set[str] = set()
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
            for form in intro.get("formes", []):
                if form not in FORMS:
                    raise LessonError(f"{where} : forme inconnue {form}")
            known_letters |= set(intro["lettres"]) | set(intro.get("formes", []))
            known_signs |= {SIGNS[s] for s in intro["signes"]}
            for kind in ("syllabes", "mots"):
                known_readings |= {i["ar"] for i in lesson.get("elements", {}).get(kind, [])}
            try:
                mini_donjon.validate(
                    lesson, known_letters=known_letters, known_signs=known_signs,
                    known_readings=known_readings, letter_cards=letter_cards,
                    places=places, characters=characters)
            except mini_donjon.LessonError as e:
                raise LessonError(str(e)) from None


def inscriptions(data: LessonData) -> dict[str, str]:
    """Inscriptions des salles de lecture (mots isolés), contrôlées sur
    2 mots voisins par le garde-fou coranique."""
    out: dict[str, str] = {}
    for lesson in data.lessons:
        for i, s in enumerate(x for x in lesson["ecrans"] if x["type"] == "lecture"):
            out[f"{lesson['_file']} · salle de lecture {i + 1}"] = " ".join(s["inscription"])
    return out


def arabic_texts(data: LessonData) -> dict[str, str]:
    """Tous les textes arabes des leçons et des fiches (garde-fou coranique),
    inscriptions des salles de lecture comprises."""
    out: dict[str, str] = {}
    for card in data.letters["lettres"]:
        out[f"fiche {card['lettre']}"] = card["nom_ar"]
    for lesson in data.lessons:
        for i, t in enumerate(mini_donjon.arabic_strings(lesson, silent=True)):
            out[f"{lesson['_file']} · texte {i + 1}"] = t
        for i, s in enumerate(lesson["ecrans"]):
            if s.get("type") == "lecture":
                out[f"{lesson['_file']} · salle de lecture {i + 1}"] = " ".join(s["inscription"])
    return out


def audio_key(text: str) -> str:
    """Identifiant stable d'un enregistrement : empreinte du texte arabe
    (forme NFC)."""
    norm = unicodedata.normalize("NFC", text)
    return "ar-" + hashlib.sha256(norm.encode("utf-8")).hexdigest()[:16]


def audio_clips(data: LessonData) -> dict[str, tuple[str, str]]:
    """Enregistrements nécessaires aux leçons : clé → (genre, texte arabe).

    Lettres (le nom de la lettre), syllabes, mots et phrases des écrans. Les
    inscriptions des salles de lecture se lisent sans son.
    """
    clips: dict[str, tuple[str, str]] = {}

    def add(kind: str, text: str) -> None:
        clips.setdefault(audio_key(text), (kind, text))

    for card in data.letters["lettres"]:
        add("lettre", card["nom_ar"])
    for lesson in data.lessons:
        syll = {i["ar"] for i in lesson["elements"]["syllabes"]}
        words = {i["ar"] for i in lesson["elements"]["mots"]}
        for t in mini_donjon.arabic_strings(lesson):
            # Seuls les textes vocalisés se lisent à voix haute ; une
            # lettre seule ou une forme isolée n'a pas d'enregistrement.
            if not any(ch in SIGNS.values() for ch in t):
                continue
            if t in syll:
                kind = "syllabe"
            elif t in words:
                kind = "mot"
            elif " " in t:
                kind = "phrase"
            else:
                letters = sum(1 for ch in t if "\u0621" <= ch <= "\u064A")
                kind = "syllabe" if letters <= 2 else "mot"
            add(kind, t)
    return clips


def load_audio_manifest(path: str = AUDIO_MANIFEST) -> dict:
    """Manifeste des enregistrements livrés (tools/build_audio/clips.json),
    vide s'il n'existe pas encore."""
    if not os.path.exists(path):
        return {"origine": None, "synthese": True, "clips": {}}
    with open(path, encoding="utf-8") as f:
        return json.load(f)


def audio_rows(clips: dict[str, tuple[str, str]], manifest: dict,
               root: str = REPO_ROOT) -> list[tuple]:
    """Lignes de `audio_clip`. Un enregistrement du manifeste n'est retenu que
    si son texte est identique à celui de la leçon et si l'empreinte SHA-256
    du fichier correspond ; sinon LessonError. Un enregistrement que plus
    aucune leçon n'utilise est aussi refusé (à régénérer ou retirer)."""
    entries = manifest.get("clips", {})
    orphans = sorted(set(entries) - set(clips))
    if orphans:
        raise LessonError(f"enregistrements audio sans leçon : {orphans}")
    rows = []
    for key, (kind, text) in sorted(clips.items()):
        e = entries.get(key)
        if e is None:
            rows.append((key, kind, text, None, None, None))
            continue
        if e["texte"] != text:
            raise LessonError(f"audio {key} : texte différent de la leçon")
        path = os.path.join(root, e["fichier"])
        if not os.path.exists(path):
            raise LessonError(f"audio {key} : fichier absent {e['fichier']}")
        with open(path, "rb") as f:
            if hashlib.sha256(f.read()).hexdigest() != e["sha256"]:
                raise LessonError(f"audio {key} : empreinte SHA-256 différente")
        asset = e["fichier"].removeprefix("assets/")
        rows.append((key, kind, text, asset, manifest["origine"],
                     1 if manifest.get("synthese", True) else 0))
    return rows


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
    for lesson in data.lessons:
        content = {k: v for k, v in lesson.items() if not k.startswith("_")}
        con.execute(
            "INSERT INTO lesson VALUES (?,?,?,?,?,?,?)",
            (lesson["id"], lesson["etape"], lesson["ordre"], lesson["titre"],
             lesson["objectif"], lesson["statut"],
             json.dumps(content, ensure_ascii=False, sort_keys=True)),
        )
    clips = audio_clips(data)
    # Fichier relatif à assets/, origine, synthèse (1) : NULL = pas d'audio.
    rows = audio_rows(clips, load_audio_manifest())
    con.executemany("INSERT INTO audio_clip VALUES (?,?,?,?,?,?)", rows)
    return {"lessons": len(data.lessons), "letters": len(data.letters["lettres"]),
            "audio_clips": len(clips),
            "audio_files": sum(1 for r in rows if r[3] is not None)}


# ---------------------------------------------------------------------------
# Tracé guidé

TRACES_FILE = os.path.join(LESSONS_DIR, "traces.json")


def load_traces(path: str = TRACES_FILE) -> dict:
    with open(path, encoding="utf-8") as f:
        return json.load(f)


def validate_traces(traces: dict, data: LessonData) -> None:
    letters = {c["lettre"] for c in data.letters["lettres"]}
    if traces.get("statut") != "ia_non_verifie":
        raise LessonError("traces.json : statut « ia_non_verifie » attendu")
    for letter, strokes in traces["traces"].items():
        if letter not in letters:
            raise LessonError(f"tracé de {letter} : lettre sans fiche")
        if not strokes or not strokes[0] or len(strokes[0]) < 2:
            raise LessonError(f"tracé de {letter} : le premier trait doit avoir 2 points au moins")
        for stroke in strokes:
            for pt in stroke:
                if len(pt) != 2 or not all(0 <= v <= 100 for v in pt):
                    raise LessonError(f"tracé de {letter} : point hors du carré {pt}")
    for lesson in data.lessons:
        for screen in lesson.get("ecrans", []):
            for q in screen.get("exercices", []) + [screen.get("question") or {}]:
                if q.get("type") == "tracer" and q["lettre"] not in traces["traces"]:
                    raise LessonError(f"{lesson['_file']} : pas de tracé guidé pour {q['lettre']}")


def write_traces(con: sqlite3.Connection, traces: dict) -> int:
    con.executemany(
        "INSERT INTO letter_trace VALUES (?, ?)",
        [(k, json.dumps(v)) for k, v in sorted(traces["traces"].items())],
    )
    return len(traces["traces"])
