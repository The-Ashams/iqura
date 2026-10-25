"""Contrôle des leçons de la région 2 (format 3, « Fondations »).

Déroulement proposé (docs/PROPOSITION_REGION_2.md, cahier §6.1) :
entrée, échauffement, dialogue (découverte par l'exemple), les mots, la
règle, salle d'entraînement, salle de lecture (court texte gradué), Atelier
des phrases (production), mini-boss, fin.

Règles vérifiées, en plus de celles de la région 1 (`mini_donjon`) :
- chaque mot nouveau de la leçon (vocab/mots.json, champ « lecon ») est
  présenté sur un écran « mots » ;
- dialogue, règle, exercices : tout mot arabe est déjà connu (leçons
  précédentes, région 1 comprise) ou introduit par la leçon ;
- salle de lecture : 3 à 6 phrases, au moins 95 % de mots déjà connus
  (cahier §4) ; aucun verset (garde-fou `quran_guard`, à la construction) ;
- Atelier des phrases : 2 à 6 exercices de production (ordonner, traduire,
  compléter, répondre) ;
- repère de l'avenant n° 2 : au moins 40 % des exercices de la leçon sont
  des exercices de production (environ 50 % visé en région 2).
"""

from __future__ import annotations

import math

import mini_donjon
import vocab
from mini_donjon import LessonError, check_question, check_short

SCREEN_TYPES = {"entree", "echauffement", "dialogue", "mots", "regle",
                "entrainement", "lecture", "atelier", "mini_boss", "fin"}
PRODUCTION = {"ordonner", "traduire", "completer", "repondre", "repeter", "reconstruire"}
ATELIER_TYPES = {"ordonner", "traduire", "completer", "repondre"}
READING_TYPES = {"qcm", "sens", "reperer_mot"}
BOSS_TYPES = {"qcm", "sens", "traduire", "completer", "ecouter", "lire"}
MIN_KNOWN = 0.95
MIN_PRODUCTION = 0.40


def validate(lesson: dict, *, check_ar, known_keys: set[str], lesson_words: list[dict],
             letter_cards: dict, places: set[str], characters: set[str],
             known_endings: set[str] = frozenset()) -> None:
    """`known_keys` : formes de base des mots connus, leçon courante comprise ;
    `lesson_words` : mots introduits par la leçon ; `known_endings` : groupes
    de terminaisons enseignés (`vocab.ENDINGS`), leçon courante comprise."""
    where = lesson["_file"]
    for key in ("lieu", "maitre", "ecrans"):
        if key not in lesson:
            raise LessonError(f"{where} : champ « {key} » absent")
    if lesson["lieu"] not in places:
        raise LessonError(f"{where} : lieu inconnu {lesson['lieu']}")
    if lesson["maitre"] not in characters:
        raise LessonError(f"{where} : personnage inconnu {lesson['maitre']}")
    apercu = set(lesson.get("apercu", []))

    def ar(text: str, here: str, all_known: bool = True) -> None:
        if text in apercu:
            return
        check_ar(text)
        if all_known:
            missing = [t for t in vocab.unknown(text, known_keys, known_endings) if t not in apercu]
            if missing:
                raise LessonError(f"{here} : mot(s) inconnu(s) à ce stade : {' '.join(missing)}")

    screens = lesson["ecrans"]
    types = [s.get("type") for s in screens]
    for t in types:
        if t not in SCREEN_TYPES:
            raise LessonError(f"{where} : écran inconnu {t}")
    if types[:2] != ["entree", "echauffement"] or types[-2:] != ["mini_boss", "fin"] \
            or types.count("mini_boss") != 1:
        raise LessonError(f"{where} : entrée et échauffement au début, mini-boss et fin à la fin")
    for needed in ("dialogue", "mots", "lecture", "atelier"):
        if needed not in types:
            raise LessonError(f"{where} : écran « {needed} » attendu")

    presented: set[str] = set()
    graded = production = 0

    def question(q: dict, here: str, allowed: set[str] | None = None) -> None:
        nonlocal graded, production
        if allowed is not None and q.get("type") not in allowed:
            raise LessonError(f"{here} : type {q.get('type')} non permis ici")
        check_question(q, here, lambda t: ar(t, here), letter_cards=letter_cards)
        if q["type"] == "repondre" and q["replique"]["qui"] not in characters:
            raise LessonError(f"{here} : personnage inconnu {q['replique']['qui']}")
        graded += 1
        if q["type"] in PRODUCTION:
            production += 1

    for i, s in enumerate(screens):
        here = f"{where} écran {i + 1} ({s['type']})"
        t = s["type"]
        if t == "entree":
            if not s.get("repliques") or not s.get("objectif"):
                raise LessonError(f"{here} : répliques et objectif attendus")
            for r in s["repliques"]:
                if r["qui"] not in characters:
                    raise LessonError(f"{here} : personnage inconnu {r['qui']}")
                check_short(r["texte"], "réplique", here)
        elif t == "dialogue":
            lines = s.get("repliques", [])
            if not 2 <= len(lines) <= 4:
                raise LessonError(f"{here} : 2 à 4 répliques attendues")
            for r in lines:
                if r.get("qui") not in characters and r.get("qui") != "voyageur":
                    raise LessonError(f"{here} : personnage inconnu {r.get('qui')}")
                if not r.get("ar") or not r.get("fr"):
                    raise LessonError(f"{here} : réplique en arabe et sa traduction attendues")
                ar(r["ar"], here)
            question(s["question"], here)
        elif t == "mots":
            ids = s.get("mots", [])
            if not 1 <= len(ids) <= 8:
                raise LessonError(f"{here} : 1 à 8 mots par écran")
            by_id = {w["id"]: w for w in lesson_words}
            for wid in ids:
                if wid not in by_id:
                    raise LessonError(f"{here} : {wid} n'est pas un mot introduit par cette leçon")
            presented |= set(ids)
            question(s["question"], here)
        elif t == "regle":
            check_short(s["texte"], "règle", here)
            for a in s.get("exemples", []):
                ar(a, here)
            question(s["question"], here)
        elif t in ("echauffement", "entrainement"):
            exs = s["exercices"]
            if not 3 <= len(exs) <= 12:
                raise LessonError(f"{here} : 3 à 12 exercices attendus")
            for j, q in enumerate(exs):
                question(q, f"{here} exercice {j + 1}")
        elif t == "lecture":
            check_short(s["texte"], "texte", here)
            phrases = s.get("phrases", [])
            if not 3 <= len(phrases) <= 6:
                raise LessonError(f"{here} : 3 à 6 phrases attendues")
            words = unknown = 0
            for p in phrases:
                ar(p, here, all_known=False)
                words += len(vocab.tokens(p))
                unknown += len(vocab.unknown(p, known_keys, known_endings))
            if words == 0 or (words - unknown) / words < MIN_KNOWN:
                raise LessonError(
                    f"{here} : {words - unknown} mots connus sur {words} (95 % au moins)")
            qs = s.get("questions", [])
            if not 1 <= len(qs) <= 4:
                raise LessonError(f"{here} : 1 à 4 questions attendues")
            for j, q in enumerate(qs):
                if q.get("type") == "reperer_mot":
                    raise LessonError(f"{here} : repérer un mot n'est pas encore permis ici")
                question(q, f"{here} question {j + 1}", READING_TYPES)
            if "extraits" in s or "verset" in s:
                raise LessonError(f"{here} : aucun verset ni extrait coranique (avenant n° 1)")
        elif t == "atelier":
            exs = s.get("exercices", [])
            if not 2 <= len(exs) <= 6:
                raise LessonError(f"{here} : 2 à 6 exercices de production attendus")
            for j, q in enumerate(exs):
                question(q, f"{here} exercice {j + 1}", ATELIER_TYPES)
        elif t == "mini_boss":
            if s.get("seuil") != 0.8:
                raise LessonError(f"{here} : seuil de réussite de 80 % attendu")
            qs = s["questions"]
            if not 10 <= len(qs) <= 12:
                raise LessonError(f"{here} : 10 à 12 questions attendues")
            for j, q in enumerate(qs):
                if q["type"] not in BOSS_TYPES:
                    raise LessonError(f"{here} question {j + 1} : type interdit au combat {q['type']}")
                check_question(q, f"{here} question {j + 1}", lambda t: ar(t, here),
                               letter_cards=letter_cards)
            rev = sum(1 for q in qs if q.get("revision"))
            if not (math.ceil(0.2 * len(qs)) <= rev <= math.floor(0.3 * len(qs))):
                raise LessonError(f"{here} : 20 à 30 % de questions de révision attendues ({rev}/{len(qs)})")
        elif t == "fin":
            if not s.get("acquis"):
                raise LessonError(f"{here} : « ce que tu sais maintenant » attendu")

    missing = {w["id"] for w in lesson_words} - presented
    if missing:
        raise LessonError(f"{where} : mots introduits sans écran « mots » : {', '.join(sorted(missing))}")
    if graded and production / graded < MIN_PRODUCTION:
        raise LessonError(
            f"{where} : {production} exercices de production sur {graded} "
            f"({MIN_PRODUCTION:.0%} au moins, avenant n° 2)")


def arabic_strings(lesson: dict, silent: bool = False) -> list[str]:
    return mini_donjon.arabic_strings(lesson, silent=silent)
