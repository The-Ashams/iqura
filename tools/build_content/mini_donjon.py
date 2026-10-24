"""Contrôle des leçons au format mini-donjon (format 2, cahier v3 §6).

Règles vérifiées (cahier v3 §6.1, §6.2, §3.1) :
- écrans dans l'ordre : entrée au début, échauffement juste après (dès la
  leçon 2), mini-boss puis fin à la fin ;
- un écran = une idée : au plus 2 phrases et 40 mots par réplique,
  règle ou explication ; jamais deux écrans d'explication de suite (chaque
  découverte, élément et règle porte sa question) ;
- chaque lettre introduite a son écran « élément » ;
- questions à 3 ou 4 choix distincts, une seule bonne réponse ;
- mini-boss : 10 à 12 questions, seuil 80 %, 20 à 30 % sur les leçons
  précédentes (à partir de la leçon 1) ;
- salle de lecture (avenant n° 1, 24/10/2026) : une inscription d'exemples
  construits, faite uniquement de mots déjà lus dans les leçons (ou montrés
  en aperçu), et 1 à 4 questions (compter, repérer un mot, QCM) ; aucun
  verset, aucune référence coranique ;
- tout texte arabe n'utilise que des lettres et signes déjà enseignés, sauf
  les formes listées dans « apercu » (montrées, pas encore enseignées).
"""

from __future__ import annotations

import math
import re
import unicodedata

TATWEEL = "ـ"
MAX_WORDS = 40
SCREEN_TYPES = {"entree", "echauffement", "decouverte", "element", "regle",
                "entrainement", "lecture", "mini_boss", "fin"}
# Questions de la salle de lecture.
READING_TYPES = {"compter", "reperer_mot", "qcm"}
QUESTION_TYPES = {"qcm", "points", "formes", "reconnaitre", "ecouter", "paires",
                  "lire", "reconstruire", "tracer", "repeter", "reperer_mot",
                  "compter", "ecouter_lettre"}
# Au combat : jamais de translittération (§6.2) ; le nom d'une lettre se fait
# écouter (« ecouter_lettre »), il ne s'affiche pas en lettres latines.
BOSS_TYPES = {"qcm", "points", "formes", "ecouter", "paires", "lire", "ecouter_lettre"}
EXPLANATION_ONLY = {"entree", "fin"}
ARABIC = re.compile(r"[؀-ۿ]")


class LessonError(Exception):
    pass


def _words(text: str) -> int:
    return len(text.split())


def _sentences(text: str) -> int:
    return len([s for s in re.split(r"[.!?…]+", text) if s.strip()])


def check_short(text: str, what: str, where: str, sentences: int = 2) -> None:
    if _words(text) > MAX_WORDS:
        raise LessonError(f"{where} : {what} trop long ({_words(text)} mots, 40 au plus)")
    if _sentences(text) > sentences:
        raise LessonError(f"{where} : {what} : {sentences} phrases au plus")


def _choices(q: dict, where: str) -> list[str]:
    choices = q.get("choix") or q.get("choix_ar") or q.get("choix_audio")
    if not choices or not 3 <= len(choices) <= 4:
        raise LessonError(f"{where} : 3 ou 4 choix attendus")
    if len(set(choices)) != len(choices):
        raise LessonError(f"{where} : choix en double {choices}")
    r = q.get("reponse")
    if not isinstance(r, int) or not 0 <= r < len(choices):
        raise LessonError(f"{where} : réponse invalide")
    return choices


def check_question(q: dict, where: str, check_ar, inscription: list[str] | None = None,
                   letter_cards: dict | None = None) -> None:
    kind = q.get("type")
    if kind not in QUESTION_TYPES:
        raise LessonError(f"{where} : type de question inconnu {kind}")
    if not q.get("consigne"):
        raise LessonError(f"{where} : consigne absente")
    check_short(q["consigne"], "consigne", where)
    if kind not in ("tracer", "repeter", "compter"):
        if not q.get("explication"):
            raise LessonError(f"{where} : explication absente")
        check_short(q["explication"], "explication", where)
    for key in ("ar", "audio", "lettre"):
        if key in q:
            check_ar(q[key])
    for key in ("choix_ar", "choix_audio", "tuiles", "solution"):
        for t in q.get(key, []):
            check_ar(t)
    if kind == "ecouter_lettre":
        # Le son joué est le nom de la bonne lettre (fiche de la lettre).
        choices = _choices(q, where)
        if "choix_ar" not in q or any(c not in (letter_cards or {}) for c in choices):
            raise LessonError(f"{where} : choix attendus parmi les lettres qui ont une fiche")
    elif kind in ("qcm", "points", "formes", "reconnaitre", "ecouter", "paires", "lire"):
        choices = _choices(q, where)
        if kind in ("ecouter", "paires") and choices[q["reponse"]] != q["audio"]:
            raise LessonError(f"{where} : la bonne réponse doit être le son entendu")
        if kind == "lire" and choices[q["reponse"]] != q["ar"]:
            raise LessonError(f"{where} : la bonne réponse doit être le mot affiché")
        if kind in ("points", "formes") and "choix_ar" not in q:
            raise LessonError(f"{where} : choix en arabe attendus")
    elif kind == "reconstruire":
        tiles, sol = q.get("tuiles", []), q.get("solution", [])
        if not 3 <= len(tiles) <= 6 or not sol or any(t not in tiles for t in sol):
            raise LessonError(f"{where} : tuiles ou solution invalides")
        if unicodedata.normalize("NFC", "".join(sol)) != unicodedata.normalize("NFC", q["audio"]):
            raise LessonError(f"{where} : la solution ne reforme pas le mot entendu")
    elif kind == "tracer":
        if not q.get("lettre"):
            raise LessonError(f"{where} : lettre à tracer absente")
    elif kind == "repeter":
        if not q.get("ar"):
            raise LessonError(f"{where} : texte à répéter absent")
    elif kind in ("reperer_mot", "compter"):
        i = q.get("mot")
        if inscription is None or not isinstance(i, int) or not 0 <= i < len(inscription):
            raise LessonError(f"{where} : mot {i} hors de l'inscription")
        if kind == "compter":
            # Un signe seul se compte sur la forme décomposée : آ compte
            # aussi comme ا + ٓ.
            lettre = q["lettre"]
            form = "NFD" if unicodedata.combining(lettre[:1]) and len(lettre) == 1 else "NFC"
            n = unicodedata.normalize(form, inscription[i]).count(lettre)
            if not 1 <= n <= 3:
                raise LessonError(
                    f"{where} : {q['lettre']} apparaît {n} fois dans {inscription[i]} (1 à 3 attendu)")


def validate(lesson: dict, *, known_letters: set[str], known_signs: set[str],
             known_readings: set[str], letter_cards: dict, places: set[str],
             characters: set[str]) -> None:
    where = lesson["_file"]
    for key in ("lieu", "maitre", "apercu", "elements", "ecrans"):
        if key not in lesson:
            raise LessonError(f"{where} : champ « {key} » absent")
    if lesson["lieu"] not in places:
        raise LessonError(f"{where} : lieu inconnu {lesson['lieu']}")
    if lesson["maitre"] not in characters:
        raise LessonError(f"{where} : personnage inconnu {lesson['maitre']}")
    apercu = set(lesson["apercu"])

    def check_ar(text: str) -> None:
        if text in apercu:
            return
        for ch in text:
            if ch in known_letters or ch in known_signs or ch in (TATWEEL, " "):
                continue
            name = unicodedata.name(ch, hex(ord(ch)))
            raise LessonError(f"{where} : « {text} » utilise {ch} ({name}), pas encore enseigné")

    for kind in ("syllabes", "mots"):
        for item in lesson["elements"][kind]:
            if not item.get("translit"):
                raise LessonError(f"{where} : translittération absente pour {item.get('ar')}")
            check_ar(item["ar"])
            if kind == "mots" and not item.get("fr"):
                raise LessonError(f"{where} : sens absent pour {item['ar']}")

    screens = lesson["ecrans"]
    types = [s.get("type") for s in screens]
    for t in types:
        if t not in SCREEN_TYPES:
            raise LessonError(f"{where} : écran inconnu {t}")
    if types[0] != "entree" or types[-2:] != ["mini_boss", "fin"] or types.count("mini_boss") != 1:
        raise LessonError(f"{where} : entrée au début, puis mini-boss et fin à la fin")
    for a, b in zip(types, types[1:]):
        if a in EXPLANATION_ONLY and b in EXPLANATION_ONLY:
            raise LessonError(f"{where} : deux écrans d'explication à la suite")
    if lesson["ordre"] >= 2 and types[1] != "echauffement":
        raise LessonError(f"{where} : échauffement attendu juste après l'entrée (dès la leçon 2)")
    elements = [s["lettre"] for s in screens if s["type"] == "element"]
    if sorted(elements) != sorted(lesson["introduit"]["lettres"]):
        raise LessonError(f"{where} : un écran « élément » par lettre introduite")

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
        elif t in ("decouverte", "element", "regle"):
            if "question" not in s:
                raise LessonError(f"{here} : une question est attendue après l'explication")
            for a in s.get("support", []) + s.get("exemples", []):
                check_ar(a)
            if t == "element":
                if s["lettre"] not in letter_cards:
                    raise LessonError(f"{here} : lettre sans fiche")
            if t == "regle":
                check_short(s["texte"], "règle", here)
            check_question(s["question"], here, check_ar, letter_cards=letter_cards)
        elif t == "entrainement":
            if not 3 <= len(s["exercices"]) <= 12:
                raise LessonError(f"{here} : 3 à 12 exercices attendus")
            for j, q in enumerate(s["exercices"]):
                check_question(q, f"{here} exercice {j + 1}", check_ar, letter_cards=letter_cards)
        elif t == "lecture":
            check_short(s["texte"], "texte", here)
            words = s.get("inscription", [])
            if not 1 <= len(words) <= 6:
                raise LessonError(f"{here} : inscription de 1 à 6 mots attendue")
            for w in words:
                check_ar(w)
                if w not in known_readings and w not in apercu:
                    raise LessonError(
                        f"{here} : « {w} » n'a pas encore été lu dans une leçon "
                        "(salle de lecture : mots connus seulement)")
            qs = s.get("questions", [])
            if not 1 <= len(qs) <= 4:
                raise LessonError(f"{here} : 1 à 4 questions attendues")
            for j, q in enumerate(qs):
                if q.get("type") not in READING_TYPES:
                    raise LessonError(f"{here} question {j + 1} : type {q.get('type')} hors salle de lecture")
                check_question(q, f"{here} question {j + 1}", check_ar, inscription=words)
            if "extraits" in s or "verset" in s:
                raise LessonError(f"{here} : aucun verset ni extrait coranique (avenant n° 1)")
        elif t == "mini_boss":
            if s.get("seuil") != 0.8:
                raise LessonError(f"{here} : seuil de réussite de 80 % attendu")
            qs = s["questions"]
            if not 10 <= len(qs) <= 12:
                raise LessonError(f"{here} : 10 à 12 questions attendues")
            for j, q in enumerate(qs):
                if q["type"] not in BOSS_TYPES:
                    raise LessonError(f"{here} question {j + 1} : type interdit au combat {q['type']}")
                check_question(q, f"{here} question {j + 1}", check_ar, letter_cards=letter_cards)
            rev = sum(1 for q in qs if q.get("revision"))
            if lesson["ordre"] >= 1 and not (math.ceil(0.2 * len(qs)) <= rev <= math.floor(0.3 * len(qs))):
                raise LessonError(f"{here} : 20 à 30 % de questions de révision attendues ({rev}/{len(qs)})")
        elif t == "fin":
            if not s.get("acquis"):
                raise LessonError(f"{here} : « ce que tu sais maintenant » attendu")


def arabic_strings(lesson: dict) -> list[str]:
    """Textes arabes d'une leçon qui se lisent à voix haute (hors salle de
    lecture, dont l'inscription se lit sans son)."""
    out: list[str] = []

    def add(t):
        if isinstance(t, str) and ARABIC.search(t):
            out.append(t)

    for kind in ("syllabes", "mots"):
        for item in lesson["elements"][kind]:
            add(item["ar"])

    def from_question(q):
        for key in ("ar", "audio"):
            add(q.get(key))
        for key in ("choix_ar", "choix_audio", "tuiles"):
            for t in q.get(key, []):
                add(t)

    for s in lesson["ecrans"]:
        for t in s.get("support", []) + s.get("exemples", []):
            add(t)
        if "question" in s:
            from_question(s["question"])
        for q in s.get("exercices", []) + s.get("questions", []):
            from_question(q)
    return out
