"""Alignement des segments du Corpus sur les mots du texte Tanzil.

Les deux sources découpent parfois les mots différemment (ex. « بَعْدَ مَا »
en deux mots chez Tanzil, un seul dans le Corpus) et n'écrivent pas toujours
les supports de hamza ou l'alif suscrit de la même façon. On compare donc un
« squelette » des lettres :
- seules les lettres (catégorie Unicode Lo) sont gardées, sans hamza isolée
  ni tatwîl ;
- les supports de hamza et l'alif waṣla sont ramenés à la lettre de base
  (أ إ ٱ آ → ا, ؤ → و, ئ ي → ى) ;
- « ى + alif suscrit » est traité comme l'alif suscrit seul (même son).
Ce squelette ne sert qu'à comparer : aucun texte n'est modifié ni stocké.

Chaque segment est rattaché au(x) mot(s) Tanzil dont il couvre les lettres.
Un verset qui ne s'aligne pas exactement est signalé.
"""

from __future__ import annotations

import unicodedata
from dataclasses import dataclass, field

from qac import Segment

_FOLD = {
    "أ": "ا",
    "إ": "ا",
    "ٱ": "ا",
    "آ": "ا",
    "ؤ": "و",
    "ئ": "ى",
    "ي": "ى",
}
_DROP = {"ء", "ـ"}


def skeleton(text: str) -> str:
    text = text.replace("ىٰ", "ٰ")
    return "".join(
        _FOLD.get(c, c)
        for c in text
        if unicodedata.category(c) == "Lo" and c not in _DROP
    )


class AlignmentError(Exception):
    pass


@dataclass
class VerseAlignment:
    # pour chaque segment (dans l'ordre), indices (0-based) des mots Tanzil
    segment_words: list[list[int]] = field(default_factory=list)


def align_verse(words: list[str], segments: list[Segment]) -> VerseAlignment:
    """Lève AlignmentError si les lettres ne correspondent pas exactement."""
    sk = [skeleton(w) for w in words]
    if any(not s for s in sk):
        raise AlignmentError("mot sans lettre")
    wi, pos = 0, 0
    result = VerseAlignment()
    for seg in segments:
        covered: list[int] = []
        for pi, part in enumerate(seg.form.split(" ")):
            s = skeleton(part)
            if pi > 0:
                # une espace dans la forme du Corpus : le mot Tanzil doit finir
                if pos != len(sk[wi]):
                    raise AlignmentError(f"{seg.location} : coupure incohérente")
                wi, pos = wi + 1, 0
            if not s:
                # segment sans lettre (rare) : rattaché au mot courant
                covered.append(wi if pos < len(sk[wi]) or wi == len(sk) - 1 else wi + 1)
                continue
            if pos == len(sk[wi]):
                wi, pos = wi + 1, 0
            if wi >= len(sk) or not sk[wi].startswith(s, pos):
                raise AlignmentError(
                    f"{seg.location} : lettres « {part} » introuvables"
                )
            pos += len(s)
            covered.append(wi)
        result.segment_words.append(sorted(set(covered)))
    if wi != len(sk) - 1 or pos != len(sk[wi]):
        raise AlignmentError("des mots Tanzil restent sans segment")
    return result
