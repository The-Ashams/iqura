"""Examens de fin de région (tools/build_content/exams/), à partir de la région 2.

L'examen de la région 1 est construit par l'application à partir des leçons ;
les suivants sont des fichiers JSON (cahier v3 §5.11) : un récit à comprendre,
une épreuve d'écoute, des réponses à un personnage.

Contrôles :
- structure de chaque épreuve (choix, réponses, seuils) ;
- tous les mots arabes sont connus à la fin de la région (fiches, aperçus,
  terminaisons enseignées) ;
- textes rendus au garde-fou coranique et au contrôle des paires ;
- enregistrements : phrases du récit, phrases écoutées, répliques.
"""

from __future__ import annotations

import glob
import json
import os
import sqlite3

import vocab

EXAMS_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "exams")
# Longueur du récit (cahier §5.11 : « récit d'environ 150 mots »).
MIN_STORY_WORDS = 130


class ExamError(Exception):
    pass


def load(base: str = EXAMS_DIR) -> list[dict]:
    exams = []
    for path in sorted(glob.glob(os.path.join(base, "*.json"))):
        with open(path, encoding="utf-8") as f:
            exam = json.load(f)
        exam["_file"] = "exams/" + os.path.basename(path)
        exams.append(exam)
    return exams


def known_at_end_of_region(lessons: list[dict], words: list[dict], region: int):
    """Clés connues et groupes de terminaisons à la fin de la région."""
    ids = {l["id"] for l in lessons if l["etape"] <= region}
    keys: set[str] = set()
    endings: set[str] = set()
    for lesson in lessons:
        if lesson["id"] not in ids:
            continue
        keys |= {vocab.key(i["ar"]) for i in lesson.get("elements", {}).get("mots", [])}
        keys |= {vocab.key(f) for f in lesson.get("apercu", [])}
        endings |= set(lesson.get("terminaisons", []))
    for w in words:
        if w["lecon"] in ids:
            keys |= vocab.known_keys(w)
    return keys, endings


def _choices(q: dict, field: str, where: str) -> None:
    choix = q.get(field)
    if not isinstance(choix, list) or len(choix) < 2 or len(set(choix)) != len(choix):
        raise ExamError(f"{where} : « {field} » doit avoir au moins deux choix distincts")
    if not isinstance(q.get("reponse"), int) or not 0 <= q["reponse"] < len(choix):
        raise ExamError(f"{where} : réponse hors des choix")
    if not q.get("consigne") or not q.get("explication"):
        raise ExamError(f"{where} : consigne ou explication absente")


def _seuil(part: dict, where: str) -> None:
    s = part.get("seuil")
    if not isinstance(s, (int, float)) or not 0.5 <= s <= 1:
        raise ExamError(f"{where} : seuil attendu entre 0,5 et 1")


def arabic_parts(exam: dict) -> list[tuple[str, str, str]]:
    """(où, genre d'enregistrement ou None, texte) pour chaque texte arabe."""
    f = exam["_file"]
    out = []
    for i, p in enumerate(exam["lecture"]["phrases"]):
        out.append((f"{f} · récit {i + 1}", "phrase", p))
    for i, q in enumerate(exam["ecoute"]["questions"]):
        out.append((f"{f} · écoute {i + 1}", "phrase", q["audio"]))
        for j, c in enumerate(q.get("choix_ar", [])):
            out.append((f"{f} · écoute {i + 1} · choix {j + 1}", None, c))
    for i, q in enumerate(exam["reponses"]["questions"]):
        out.append((f"{f} · réponse {i + 1} · réplique", "phrase", q["replique"]["ar"]))
        for j, t in enumerate(q.get("tuiles", [])):
            out.append((f"{f} · réponse {i + 1} · tuile {j + 1}", None, t))
        if q.get("solution"):
            out.append((f"{f} · réponse {i + 1} · solution", None, " ".join(q["solution"])))
        for j, m in enumerate(q.get("modeles", [])):
            out.append((f"{f} · réponse {i + 1} · modèle {j + 1}", None, m))
    return out


def validate(exams: list[dict], lessons: list[dict], words: list[dict],
             places: set[str], characters: set[str], monsters: set[str]) -> None:
    ids = set()
    regions = {l["etape"] for l in lessons}
    for exam in exams:
        where = exam["_file"]
        for k in ("id", "region", "lieu", "titre", "statut", "adversaire", "intro",
                  "lecture", "ecoute", "reponses"):
            if k not in exam:
                raise ExamError(f"{where} : champ « {k} » absent")
        if exam["id"] in ids:
            raise ExamError(f"{where} : identifiant en double")
        ids.add(exam["id"])
        if exam["id"] != f"examen-r{exam['region']}":
            raise ExamError(f"{where} : identifiant attendu examen-r{exam['region']}")
        if exam["region"] < 2 or exam["region"] not in regions:
            raise ExamError(f"{where} : région {exam['region']} sans leçons")
        if exam["statut"] != "ia_non_verifie":
            raise ExamError(f"{where} : statut inattendu")
        if exam["lieu"] not in places:
            raise ExamError(f"{where} : lieu inconnu {exam['lieu']}")
        if exam["adversaire"] not in monsters:
            raise ExamError(f"{where} : adversaire inconnu {exam['adversaire']}")

        lecture = exam["lecture"]
        _seuil(lecture, f"{where} · lecture")
        if not lecture.get("phrases") or not lecture.get("questions"):
            raise ExamError(f"{where} : récit ou questions absents")
        n = sum(len(vocab.tokens(p)) for p in lecture["phrases"])
        if n < MIN_STORY_WORDS:
            raise ExamError(f"{where} : récit de {n} mots ({MIN_STORY_WORDS} au moins)")
        for i, q in enumerate(lecture["questions"]):
            if q.get("type") != "qcm":
                raise ExamError(f"{where} · lecture {i + 1} : type qcm attendu")
            _choices(q, "choix", f"{where} · lecture {i + 1}")

        ecoute = exam["ecoute"]
        _seuil(ecoute, f"{where} · écoute")
        for i, q in enumerate(ecoute["questions"]):
            w = f"{where} · écoute {i + 1}"
            if not q.get("audio"):
                raise ExamError(f"{w} : audio absent")
            if q.get("type") == "qcm":
                _choices(q, "choix", w)
            elif q.get("type") == "ecouter":
                _choices(q, "choix_ar", w)
                if q["choix_ar"][q["reponse"]] != q["audio"]:
                    raise ExamError(f"{w} : la bonne réponse doit être la phrase entendue")
            else:
                raise ExamError(f"{w} : type inconnu {q.get('type')}")

        graded = 0
        for i, q in enumerate(exam["reponses"]["questions"]):
            w = f"{where} · réponse {i + 1}"
            rep = q.get("replique") or {}
            if rep.get("qui") not in characters or not rep.get("ar"):
                raise ExamError(f"{w} : réplique ou personnage invalide")
            if not q.get("consigne") or not q.get("explication"):
                raise ExamError(f"{w} : consigne ou explication absente")
            if q.get("type") == "ordonner":
                graded += 1
                tuiles, sol = q.get("tuiles", []), q.get("solution", [])
                if not sol or len(sol) > len(tuiles) \
                        or any(sol.count(t) > tuiles.count(t) for t in sol):
                    raise ExamError(f"{w} : la solution doit se faire avec les tuiles")
            elif q.get("type") == "libre":
                if not q.get("modeles"):
                    raise ExamError(f"{w} : réponses modèles absentes")
            else:
                raise ExamError(f"{w} : type inconnu {q.get('type')}")
        if graded == 0:
            raise ExamError(f"{where} : au moins une réponse notée (ordonner)")

        known, endings = known_at_end_of_region(lessons, words, exam["region"])
        for w, _, text in arabic_parts(exam):
            missing = vocab.unknown(text, known, endings)
            if missing:
                raise ExamError(f"{w} : mots inconnus {missing}")


def arabic_texts(exams: list[dict]) -> dict[str, str]:
    return {w: t for exam in exams for w, _, t in arabic_parts(exam)}


def audio_texts(exams: list[dict]) -> list[tuple[str, str]]:
    return [(kind, t) for exam in exams for _, kind, t in arabic_parts(exam) if kind]


def write(con: sqlite3.Connection, exams: list[dict]) -> int:
    con.execute("""CREATE TABLE region_exam (
        id TEXT NOT NULL PRIMARY KEY,
        region INTEGER NOT NULL,
        place_id TEXT NOT NULL,
        content_json TEXT NOT NULL
    ) STRICT""")
    con.executemany(
        "INSERT INTO region_exam VALUES (?,?,?,?)",
        [(e["id"], e["region"], e["lieu"],
          json.dumps({k: v for k, v in e.items() if not k.startswith("_")},
                     ensure_ascii=False, sort_keys=True))
         for e in exams])
    return len(exams)
