"""Garde-fou : aucun verset, extrait ni citation coranique dans le contenu.

Avenant n° 1 au cahier des charges (24/10/2026) : l'application n'affiche
aucun verset ni extrait coranique. Le contenu du jeu (leçons, mondes,
fiches) est comparé, au moment de la construction seulement, aux suites de
mots du Quranic Arabic Corpus : toute suite de `N` mots consécutifs qui
apparaît dans le Coran est refusée. Un mot isolé (forme de dictionnaire)
reste permis. Rien du texte coranique n'est écrit dans la base.

Les inscriptions des salles de lecture sont des listes de mots isolés :
elles sont contrôlées plus strictement, sur 2 mots voisins (`PAIR`).

La comparaison se fait sur un squelette normalisé : sans voyelles ni signes,
alifs, hamzas et fins de mots unifiés.
"""

from __future__ import annotations

import re
import unicodedata
from collections import defaultdict

N = 3
PAIR = 2

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


def ngrams_from_segments(segments: dict, n: int = N) -> set[tuple[str, ...]]:
    """Suites de `n` mots du corpus. `segments` : verset → liste de segments
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
        for i in range(len(seq) - n + 1):
            grams.add(tuple(seq[i:i + n]))
    return grams


def check(texts: dict[str, str], grams: set[tuple[str, ...]], n: int = N) -> None:
    """Lève QuranGuardError si un texte contient `n` mots consécutifs du
    Coran (`grams` : suites de `n` mots). `texts` : emplacement → texte."""
    for where, text in texts.items():
        ws = words_of(text)
        for i in range(len(ws) - n + 1):
            if tuple(ws[i:i + n]) in grams:
                raise QuranGuardError(
                    f"{where} : « {text} » reprend une suite de mots du Coran "
                    "(avenant n° 1 : aucun verset ni extrait dans l'application)"
                )
