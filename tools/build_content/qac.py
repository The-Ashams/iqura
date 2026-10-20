"""Lecture des données morphologiques du Quranic Arabic Corpus (v0.4).

Format : une ligne par segment,
`(sourate:verset:mot:segment)<TAB>forme<TAB>étiquette<TAB>traits`.
Les traits sont conservés bruts ; seuls POS, LEM et ROOT sont extraits.
"""

from __future__ import annotations

import re
import zipfile
from collections import defaultdict
from dataclasses import dataclass

import buckwalter

MEMBER = "quranic-corpus-morphology-0.4.txt"
_LINE = re.compile(r"^\((\d+):(\d+):(\d+):(\d+)\)\t([^\t]*)\t([^\t]*)\t([^\t]*)$")


class QacError(Exception):
    pass


@dataclass
class Segment:
    surah: int
    ayah: int
    word: int
    index: int
    form_bw: str
    tag: str
    features: str

    @property
    def location(self) -> str:
        return f"{self.surah}:{self.ayah}:{self.word}:{self.index}"

    @property
    def form(self) -> str:
        return buckwalter.to_arabic(self.form_bw)

    @property
    def kind(self) -> str:
        """PREFIX, STEM ou SUFFIX."""
        return self.features.split("|", 1)[0]

    def feature(self, key: str) -> str | None:
        for part in self.features.split("|")[1:]:
            if part.startswith(key + ":"):
                return part[len(key) + 1:]
        return None

    @property
    def pos(self) -> str | None:
        return self.feature("POS")

    @property
    def lemma(self) -> str | None:
        return self.feature("LEM")

    @property
    def root(self) -> str | None:
        return self.feature("ROOT")


def read_zip(path: str) -> tuple[dict[tuple[int, int], list[Segment]], list[str]]:
    """Segments groupés par verset (dans l'ordre), et en-tête de copyright."""
    with zipfile.ZipFile(path) as z:
        names = z.namelist()
        if names != [MEMBER]:
            raise QacError(f"contenu inattendu de l'archive : {names}")
        text = z.read(MEMBER).decode("utf-8")
    by_verse: dict[tuple[int, int], list[Segment]] = defaultdict(list)
    header: list[str] = []
    seen_columns = False
    for n, line in enumerate(text.splitlines(), 1):
        if line.startswith("#"):
            header.append(line)
            continue
        if not line.strip():
            continue
        if line.startswith("LOCATION\t"):
            seen_columns = True
            continue
        m = _LINE.match(line)
        if not m:
            raise QacError(f"ligne {n} illisible : {line!r}")
        seg = Segment(
            int(m[1]), int(m[2]), int(m[3]), int(m[4]), m[5], m[6], m[7]
        )
        if seg.kind not in ("PREFIX", "STEM", "SUFFIX"):
            raise QacError(f"ligne {n} : type de segment inconnu {seg.kind}")
        by_verse[(seg.surah, seg.ayah)].append(seg)
    if not seen_columns:
        raise QacError("ligne d'en-tête des colonnes absente")
    return dict(by_verse), header


def lemma_display_bw(lemma_bw: str) -> str:
    """Forme d'un lemme sans le chiffre de désambiguïsation du Corpus
    (ex. `kaAna2` → `kaAna`)."""
    return lemma_bw.rstrip("0123456789")
