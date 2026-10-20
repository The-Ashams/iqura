"""Lecture des fichiers Tanzil (texte, métadonnées, traduction).

Le texte est lu tel quel : aucune modification. Le découpage en mots sépare
le verset sur les espaces et écarte les signes de pause isolés (ils ne sont
pas des mots) ; chaque mot est une sous-chaîne exacte du verset.
"""

from __future__ import annotations

import hashlib
import xml.etree.ElementTree as ET
from dataclasses import dataclass, field

# Signes coraniques qui forment un « mot » à part dans le texte Tanzil :
# signes de pause (U+06D6 à U+06DC), fin d'aya, rub el-hizb, prosternation.
STANDALONE_MARKS = frozenset("ۖۗۘۙۚۛۜ۝۞۩")

EXPECTED_SURAHS = 114
EXPECTED_VERSES = 6236


class TanzilError(Exception):
    pass


@dataclass
class Verse:
    surah: int
    ayah: int
    text: str

    @property
    def key(self) -> tuple[int, int]:
        return (self.surah, self.ayah)

    def words(self) -> list[str]:
        """Mots du verset, sans les signes de pause isolés."""
        return [
            w for w in self.text.split(" ")
            if w and not all(c in STANDALONE_MARKS for c in w)
        ]


@dataclass
class QuranText:
    verses: list[Verse]
    # sourate → basmala placée avant le verset 1 (absente pour 1 et 9)
    bismillah: dict[int, str] = field(default_factory=dict)

    def by_key(self) -> dict[tuple[int, int], Verse]:
        return {v.key: v for v in self.verses}


def read_text_xml(path: str) -> QuranText:
    root = ET.parse(path).getroot()
    if root.tag != "quran":
        raise TanzilError(f"{path} : racine XML inattendue {root.tag}")
    verses: list[Verse] = []
    bismillah: dict[int, str] = {}
    for sura in root.findall("sura"):
        s = int(sura.get("index"))
        for aya in sura.findall("aya"):
            a = int(aya.get("index"))
            verses.append(Verse(s, a, aya.get("text")))
            if a == 1 and aya.get("bismillah") is not None:
                bismillah[s] = aya.get("bismillah")
    if len(verses) != EXPECTED_VERSES:
        raise TanzilError(f"{path} : {len(verses)} versets au lieu de {EXPECTED_VERSES}")
    return QuranText(verses, bismillah)


def integrity_sha256(text: QuranText) -> str:
    """Empreinte de référence du texte coranique.

    SHA-256 (UTF-8) de la suite des lignes `sourate|0|basmala\\n` (si la
    sourate en a une) puis `sourate|verset|texte\\n`, dans l'ordre du Coran.
    La même définition est utilisée par l'application (Dart).
    """
    h = hashlib.sha256()
    for v in text.verses:
        if v.ayah == 1 and v.surah in text.bismillah:
            h.update(f"{v.surah}|0|{text.bismillah[v.surah]}\n".encode("utf-8"))
        h.update(f"{v.surah}|{v.ayah}|{v.text}\n".encode("utf-8"))
    return h.hexdigest()


@dataclass
class SurahMeta:
    index: int
    ayas: int
    start: int  # index global (0-based) du premier verset
    name: str
    tname: str
    ename: str
    type: str  # Meccan / Medinan
    order: int  # ordre de révélation


@dataclass
class Metadata:
    surahs: list[SurahMeta]
    # Débuts de divisions : liste de (index, sourate, verset) triée
    juzs: list[tuple[int, int, int]]
    quarters: list[tuple[int, int, int]]
    pages: list[tuple[int, int, int]]
    sajdas: dict[tuple[int, int], str]


def read_metadata(path: str) -> Metadata:
    root = ET.parse(path).getroot()

    def starts(group: str, item: str) -> list[tuple[int, int, int]]:
        g = root.find(group)
        if g is None:
            raise TanzilError(f"métadonnées : section {group} absente")
        out = [
            (int(e.get("index")), int(e.get("sura")), int(e.get("aya")))
            for e in g.findall(item)
        ]
        return sorted(out)

    surahs = [
        SurahMeta(
            index=int(e.get("index")),
            ayas=int(e.get("ayas")),
            start=int(e.get("start")),
            name=e.get("name"),
            tname=e.get("tname"),
            ename=e.get("ename"),
            type=e.get("type"),
            order=int(e.get("order")),
        )
        for e in root.find("suras").findall("sura")
    ]
    if len(surahs) != EXPECTED_SURAHS:
        raise TanzilError(f"métadonnées : {len(surahs)} sourates")
    sajdas = {
        (int(e.get("sura")), int(e.get("aya"))): e.get("type")
        for e in root.find("sajdas").findall("sajda")
    }
    return Metadata(
        surahs=surahs,
        juzs=starts("juzs", "juz"),
        quarters=starts("hizbs", "quarter"),
        pages=starts("pages", "page"),
        sajdas=sajdas,
    )


def division_of(starts: list[tuple[int, int, int]], key: tuple[int, int]) -> int:
    """Numéro de la division (juzʾ, quart de hizb, page) contenant le verset."""
    current = None
    for index, s, a in starts:
        if (s, a) <= key:
            current = index
        else:
            break
    if current is None:
        raise TanzilError(f"aucune division pour le verset {key}")
    return current


def read_translation_txt(path: str) -> tuple[dict[tuple[int, int], str], list[str]]:
    """Traduction au format `sourate|verset|texte`. Retourne aussi l'en-tête."""
    verses: dict[tuple[int, int], str] = {}
    header: list[str] = []
    with open(path, encoding="utf-8") as f:
        for line in f:
            line = line.rstrip("\n")
            if line.startswith("#"):
                header.append(line)
                continue
            if not line.strip():
                continue
            s, a, t = line.split("|", 2)
            key = (int(s), int(a))
            if key in verses:
                raise TanzilError(f"traduction : verset {key} en double")
            verses[key] = t
    if len(verses) != EXPECTED_VERSES:
        raise TanzilError(f"traduction : {len(verses)} versets")
    return verses, header
