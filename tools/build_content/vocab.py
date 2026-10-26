"""Vocabulaire : fiches de mots (avenant n° 2, cahier §5.4 bis).

Source : `tools/build_content/vocab/mots.json`. Chaque mot a une fiche
complète : forme vocalisée, translittération, sens, nature, genre et pluriel
(noms), passé et inaccompli (verbes), exemple construit, leçon qui l'introduit.

Données sourcées : le lien vers un lemme du Quranic Arabic Corpus (`lemme`)
donne la racine et la fréquence ; il est vérifié dans la table `lemma`.
Un mot sans lemme (pronoms, mots absents du Corpus) n'a ni racine ni
fréquence : rien n'est inventé. Sens, exemples, pluriels et conjugaisons sont
rédigés par IA et relus (agent relecteur).

Ce module sert aussi à reconnaître un mot dans une phrase (`key`), pour la
règle des 95 % de mots connus (cahier §4) et pour le sens au toucher.
"""

from __future__ import annotations

import json
import os
import re
import sqlite3

import quran_guard

VOCAB_FILE = os.path.join(os.path.dirname(os.path.abspath(__file__)), "vocab", "mots.json")

NATURES = {"nom", "adjectif", "verbe", "particule", "pronom", "demonstratif",
           "demonstratif_lieu", "interrogatif", "adverbe", "nom_lieu", "nombre"}
# Mots pleins (pour l'avertissement sur les paires coraniques).
FULL_NATURES = {"nom", "adjectif", "verbe", "nombre"}
# Pronoms et démonstratifs : une paire « pronom + mot plein » qui se suit
# dans le Coran est signalée aussi (relecture du 25/10/2026 : وَهُمْ فَرِحُونَ).
PAIRED_NATURES = {"pronom", "demonstratif"}
GENRES = {"m", "f"}
# Préfixes d'une lettre collés au mot (et, alors, avec/par, pour, comme).
PREFIXES = ("و", "ف", "ب", "ل", "ك")
PUNCT = re.compile(r"[،؛؟.!?,:«»\"()…]")


class VocabError(Exception):
    pass


def load(path: str = VOCAB_FILE) -> list[dict]:
    if not os.path.exists(path):
        return []
    with open(path, encoding="utf-8") as f:
        return json.load(f)["mots"]


def key(token: str) -> str:
    """Squelette d'un mot (sans voyelles ni signes, alifs et hamzas unifiés)."""
    return quran_guard.skeleton(PUNCT.sub("", token)).replace("ٱ", "ا")


# Terminaisons collées au nom (région 2), par groupe, sous forme de squelette
# (ة s'écrit ه dans le squelette) : un groupe n'est retiré qu'à partir de la
# leçon qui l'enseigne (champ « terminaisons » de la leçon).
ENDINGS = {
    "pronoms": ("هما", "كما", "ها", "نا", "كم", "كن", "هم", "هن", "ي", "ك", "ه"),  # 2.14, 2.15
    "duel": ("ان", "ين"),  # 2.16
    "pluriel": ("ون", "ين", "ات"),  # 2.17
    "accusatif": ("ا",),  # alif du tanwīn -an (2.20)
}


# Verbes réguliers (région 2, chapitre C) : formes conjuguées ramenées au
# passé ou à l'inaccompli de la 3e personne du masculin singulier, qui sont
# sur la fiche du verbe. Un groupe n'est reconnu qu'à partir de la leçon qui
# l'enseigne (champ « terminaisons »).
VERB_PAST_SUFFIXES = ("تما", "تم", "تن", "نا", "وا", "ت", "ا", "ن")
VERB_PRESENT_PREFIXES = ("ي", "ت", "ا", "ن")
VERB_PRESENT_SUFFIXES = ("ون", "ين", "ان", "وا", "ن", "ي", "ا")
VERB_GROUPS = ("passe", "inaccompli", "imperatif", "futur")


def _verb_stems(k: str, groups) -> list[str]:
    out = []

    def add(c: str) -> None:
        if len(c) >= 2 and c not in out:
            out.append(c)

    def present(form: str) -> None:
        # forme d'inaccompli : préfixe de personne, terminaison éventuelle
        if form[:1] in VERB_PRESENT_PREFIXES and len(form) > 3:
            stem = form[1:]
            add("ي" + stem)
            for s in VERB_PRESENT_SUFFIXES:
                if stem.endswith(s) and len(stem) - len(s) >= 2:
                    add("ي" + stem[: -len(s)])

    if "passe" in groups:
        for s in VERB_PAST_SUFFIXES:
            if k.endswith(s) and len(k) - len(s) >= 2:
                add(k[: -len(s)])
    if "inaccompli" in groups:
        present(k)
    if "futur" in groups and k.startswith("س") and len(k) > 4:
        add(k[1:])
        present(k[1:])
    if "imperatif" in groups and k.startswith("ا") and len(k) > 3:
        stem = k[1:]
        add("ي" + stem)
        for s in ("ي", "وا", "ا", "ن"):
            if stem.endswith(s) and len(stem) - len(s) >= 2:
                add("ي" + stem[: -len(s)])
    return out


def _without_endings(base: str, groups) -> list[str]:
    out = []
    for g in groups:
        for s in ENDINGS[g]:
            rest = base[: -len(s)]
            # Une seule lettre ne reste que pour لِـ, بِـ, كَـ… (لِي، لَهُ).
            if not base.endswith(s) or (len(rest) < 2 and rest not in PREFIXES):
                continue
            out.append(rest)
            if rest.endswith("ت"):  # ة devient ت devant une terminaison
                out.append(rest[:-1] + "ه")
            if s == "ات":  # pluriel féminin : ة remplacé par -āt
                out.append(rest + "ه")
    return out


def candidates(token: str, known_prefixes: set[str] | None = None,
               endings: set[str] | None = None) -> list[str]:
    """Formes de base possibles d'un mot d'une phrase : le mot lui-même, sans
    l'article, sans un préfixe d'une lettre (et sans l'article qui suit),
    sans une terminaison (pronom collé, duel, pluriel, alif du tanwīn).
    Avec `known_prefixes` et `endings`, seuls les préfixes et les groupes de
    terminaisons déjà enseignés sont retirés ; sans eux, tous le sont."""
    k = key(token)
    out = [k]
    if k.startswith("ال") and len(k) > 3:
        out.append(k[2:])
    if k[:1] in PREFIXES and len(k) > 2 and (known_prefixes is None or k[:1] in known_prefixes):
        rest = k[1:]
        out.append(rest)
        if rest.startswith("ال") and len(rest) > 3:
            out.append(rest[2:])
        if k.startswith("لل") and len(k) > 3:  # li- + al-
            out.append(k[2:])
    groups = ENDINGS.keys() if endings is None else [g for g in ENDINGS if g in endings]
    for base in list(out):
        out.extend(c for c in _without_endings(base, groups) if c not in out)
    verbs = VERB_GROUPS if endings is None else [g for g in VERB_GROUPS if g in endings]
    if verbs:
        # Avec un pronom complément collé (كَتَبَهُ), on retire d'abord le pronom.
        for base in list(out):
            out.extend(c for c in _verb_stems(base, verbs) if c not in out)
    return out


def word_keys(word: dict) -> set[str]:
    keys = {key(word["ar"])}
    for k in ("pluriel", "passe", "inaccompli"):
        if word.get(k):
            keys.add(key(word[k]))
    for f in word.get("formes", []):
        keys.add(key(f))
    return keys


def tokens(text: str) -> list[str]:
    return [t for t in PUNCT.sub(" ", text).split() if quran_guard.words_of(t)]


def unknown(text: str, known: set[str], endings: set[str] = frozenset()) -> list[str]:
    """Mots de `text` qui ne se ramènent à aucune forme connue (`endings` :
    groupes de terminaisons déjà enseignés)."""
    prefixes = {p for p in PREFIXES if p in known}
    return [t for t in tokens(text)
            if not any(c in known for c in candidates(t, prefixes, endings))]


def validate(words: list[dict], con: sqlite3.Connection, lesson_ids: set[str],
             check_ar) -> None:
    """`check_ar(texte, où)` vérifie lettres et signes (région 1 acquise)."""
    ids = set()
    for w in words:
        where = f"vocab · {w.get('id')}"
        for k in ("id", "ar", "translit", "fr", "nature", "lecon", "source_sens"):
            if not w.get(k):
                raise VocabError(f"{where} : champ « {k} » absent")
        if w["id"] in ids:
            raise VocabError(f"{where} : identifiant en double")
        ids.add(w["id"])
        if w["nature"] not in NATURES:
            raise VocabError(f"{where} : nature inconnue {w['nature']}")
        if w["lecon"] not in lesson_ids:
            raise VocabError(f"{where} : leçon inconnue {w['lecon']}")
        if w["nature"] in ("nom", "adjectif") and w.get("genre") not in GENRES:
            raise VocabError(f"{where} : genre attendu (m ou f)")
        # Verbe figé (لَيْسَ) : pas d'inaccompli, signalé par « fige ».
        if w["nature"] == "verbe" and not w.get("fige") \
                and not (w.get("passe") and w.get("inaccompli")):
            raise VocabError(f"{where} : passé et inaccompli attendus")
        for k in ("ar", "pluriel", "passe", "inaccompli"):
            if w.get(k):
                check_ar(w[k], where)
        for f in w.get("formes", []):
            check_ar(f, where)
        ex = w.get("exemple")
        if ex:
            if not ex.get("ar") or not ex.get("fr"):
                raise VocabError(f"{where} : exemple incomplet")
            check_ar(ex["ar"], where)
        if w.get("lemme"):
            row = con.execute("SELECT root_id FROM lemma WHERE id = ?", (w["lemme"],)).fetchone()
            if row is None:
                raise VocabError(f"{where} : lemme {w['lemme']} absent du Corpus")
            if w.get("racine") and w["racine"] != row[0]:
                raise VocabError(f"{where} : racine {w['racine']} différente du Corpus ({row[0]})")
        elif w.get("racine"):
            # Mot absent du Corpus dont la racine y existe (décision du
            # conseiller, 25/10/2026) : la racine est montrée, sans fréquence.
            if con.execute("SELECT 1 FROM root WHERE id = ?", (w["racine"],)).fetchone() is None:
                raise VocabError(f"{where} : racine {w['racine']} absente du Corpus")


def write(con: sqlite3.Connection, words: list[dict], lesson_order: dict[str, tuple]) -> int:
    con.execute("""CREATE TABLE word (
        id TEXT NOT NULL PRIMARY KEY,
        ar TEXT NOT NULL,
        translit TEXT NOT NULL,
        fr TEXT NOT NULL,
        nature TEXT NOT NULL,
        gender TEXT,
        plural TEXT,
        past TEXT,
        present TEXT,
        lemma_id TEXT REFERENCES lemma(id),
        root_id TEXT REFERENCES root(id),
        lesson_id TEXT NOT NULL REFERENCES lesson(id),
        lesson_stage INTEGER NOT NULL,
        lesson_ordinal INTEGER NOT NULL,
        example_ar TEXT,
        example_fr TEXT,
        theme TEXT,
        meaning_source TEXT NOT NULL,
        keys_json TEXT NOT NULL,
        remark TEXT
    ) STRICT""")
    con.execute("CREATE INDEX word_lemma ON word(lemma_id)")
    rows = []
    for w in words:
        root = w.get("racine")
        if w.get("lemme"):
            root = con.execute("SELECT root_id FROM lemma WHERE id = ?", (w["lemme"],)).fetchone()[0]
        stage, ordinal = lesson_order[w["lecon"]]
        ex = w.get("exemple") or {}
        rows.append((
            w["id"], w["ar"], w["translit"], w["fr"], w["nature"], w.get("genre"),
            w.get("pluriel"), w.get("passe"), w.get("inaccompli"), w.get("lemme"), root,
            w["lecon"], stage, ordinal, ex.get("ar"), ex.get("fr"), w.get("theme"),
            w["source_sens"], json.dumps(sorted(word_keys(w)), ensure_ascii=False),
            w.get("remarque"),
        ))
    con.executemany(f"INSERT INTO word VALUES ({','.join('?' * 20)})", rows)
    return len(rows)


def quran_pair_warnings(texts: dict[str, str], words: list[dict],
                        pairs: set[tuple[str, ...]]) -> list[str]:
    """Paires qui se suivent dans le Coran (décision du conseiller,
    25/10/2026) : deux mots pleins (noms, adjectifs, verbes, nombres), ou un
    pronom ou démonstratif et un mot plein. Signalées à la construction, sans
    bloquer ; le blocage reste à 3 mots."""
    full, paired = set(), set()
    for w in words:
        if w["nature"] in FULL_NATURES:
            full |= word_keys(w)
        elif w["nature"] in PAIRED_NATURES:
            paired |= word_keys(w)

    def kind(t: str) -> str | None:
        cs = candidates(t)
        if any(c in full for c in cs):
            return "plein"
        if any(c in paired for c in cs):
            return "pronom"
        return None

    out = []
    for where, text in texts.items():
        ws = quran_guard.words_of(text)
        toks = tokens(text)
        if len(ws) != len(toks):
            continue
        for i in range(len(ws) - 1):
            if (ws[i], ws[i + 1]) not in pairs:
                continue
            kinds = [kind(t) for t in toks[i:i + 2]]
            if None not in kinds and "plein" in kinds:
                out.append(f"{where} : « {toks[i]} {toks[i + 1]} » se suit dans le Coran")
    return out
