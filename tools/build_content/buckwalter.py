"""Translittération Buckwalter étendue du Quranic Arabic Corpus → Unicode.

Table officielle publiée par le Corpus :
https://corpus.quran.com/java/buckwalter.jsp (relevée le 20 octobre 2026).
Conversion caractère par caractère, sans aucune interprétation.
"""

from __future__ import annotations

TABLE: dict[str, str] = {
    "'": "ء",  # Hamza
    ">": "أ",  # Alif + HamzaAbove
    "&": "ؤ",  # Waw + HamzaAbove
    "<": "إ",  # Alif + HamzaBelow
    "}": "ئ",  # Ya + HamzaAbove
    "A": "ا",  # Alif
    "b": "ب",
    "p": "ة",  # TaMarbuta
    "t": "ت",
    "v": "ث",
    "j": "ج",
    "H": "ح",
    "x": "خ",
    "d": "د",
    "*": "ذ",
    "r": "ر",
    "z": "ز",
    "s": "س",
    "$": "ش",
    "S": "ص",
    "D": "ض",
    "T": "ط",
    "Z": "ظ",
    "E": "ع",
    "g": "غ",
    "_": "ـ",  # Tatweel
    "f": "ف",
    "q": "ق",
    "k": "ك",
    "l": "ل",
    "m": "م",
    "n": "ن",
    "h": "ه",
    "w": "و",
    "Y": "ى",  # AlifMaksura
    "y": "ي",
    "F": "ً",  # Fathatan
    "N": "ٌ",  # Dammatan
    "K": "ٍ",  # Kasratan
    "a": "َ",  # Fatha
    "u": "ُ",  # Damma
    "i": "ِ",  # Kasra
    "~": "ّ",  # Shadda
    "o": "ْ",  # Sukun
    "^": "ٓ",  # Maddah
    "#": "ٔ",  # HamzaAbove
    "`": "ٰ",  # AlifKhanjareeya
    "{": "ٱ",  # Alif + HamzatWasl
    ":": "ۜ",  # SmallHighSeen
    "@": "۟",  # SmallHighRoundedZero
    '"': "۠",  # SmallHighUprightRectangularZero
    "[": "ۢ",  # SmallHighMeemIsolatedForm
    ";": "ۣ",  # SmallLowSeen
    ",": "ۥ",  # SmallWaw
    ".": "ۦ",  # SmallYa
    "!": "ۨ",  # SmallHighNoon
    "-": "۪",  # EmptyCentreLowStop
    "+": "۫",  # EmptyCentreHighStop
    "%": "۬",  # RoundedHighStopWithFilledCentre
    "]": "ۭ",  # SmallLowMeem
}


def to_arabic(text: str) -> str:
    """Convertit une forme Buckwalter. Les espaces sont conservés.

    Lève ValueError sur un caractère hors table (rien n'est deviné).
    """
    out = []
    for c in text:
        if c == " ":
            out.append(c)
        elif c in TABLE:
            out.append(TABLE[c])
        else:
            raise ValueError(f"caractère Buckwalter inconnu {c!r} dans {text!r}")
    return "".join(out)
