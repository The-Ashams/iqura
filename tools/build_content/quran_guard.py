"""Garde-fou : aucun verset, extrait ni citation coranique dans le contenu.

Avenant n° 1 au cahier des charges (24/10/2026) : l'application n'affiche
aucun verset ni extrait coranique. Le contenu du jeu (leçons, mondes,
fiches) est comparé, au moment de la construction seulement, aux suites de
mots du Quranic Arabic Corpus : toute suite de `N` mots consécutifs qui
apparaît dans le Coran est refusée. Un mot isolé (forme de dictionnaire)
reste permis. Rien du texte coranique n'est écrit dans la base.

La comparaison se fait sur un squelette normalisé : sans voyelles ni signes,
alifs, hamzas et fins de mots unifiés.
"""

from __future__ import annotations

import re
import unicodedata
from collections import defaultdict

N = 3

_MARKS = re.compile(r"[ً-ٰٟۖ-ۭـ]")
_MAP = str.maketrans({
    "ٱ": "ا", "أ": "ا", "إ": "ا", "آ": "ا",
    "ى": "ي", "ئ": "ي", "ؤ": "و", "ة": "ه", "ء": "",
})
_ARABIC_WORD = re.compile(r"[؀-ۿ]+")


class QuranGuardError(Exception):
    pass


def skeleton(word: str) -> str:
    w = unicodedata.normalize("NFC", word)
    return _MARKS.sub("", w).translate(_MAP)


def words_of(text: str) -> list[str]:
    return [s for s in (skeleton(w) for w in _ARABIC_WORD.findall(text)) if s]


def ngrams_from_segments(segments: dict) -> set[tuple[str, ...]]:
    """Suites de N mots du corpus. `segments` : verset → liste de segments
    (qac.Segment), dans l'ordre."""
    grams: set[tuple[str, ...]] = set()
    for segs in segments.values():
        words: dict[int, list] = defaultdict(list)
        for s in segs:
            words[s.word].append(s)
        seq = [
            skeleton("".join(x.form for x in sorted(words[k], key=lambda x: x.index)))
            for k in sorted(words)
        ]
        seq = [w for w in seq if w]
        for i in range(len(seq) - N + 1):
            grams.add(tuple(seq[i:i + N]))
    return grams


def check(texts: dict[str, str], grams: set[tuple[str, ...]]) -> None:
    """Lève QuranGuardError si un texte contient N mots consécutifs du
    Coran. `texts` : emplacement lisible → texte."""
    for where, text in texts.items():
        ws = words_of(text)
        for i in range(len(ws) - N + 1):
            if tuple(ws[i:i + N]) in grams:
                raise QuranGuardError(
                    f"{where} : « {text} » reprend une suite de mots du Coran "
                    "(avenant n° 1 : aucun verset ni extrait dans l'application)"
                )
