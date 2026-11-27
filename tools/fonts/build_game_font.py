#!/usr/bin/env python3
"""Police du jeu : copie de DotGothic16 sans ses diacritiques combinants.

DotGothic16 n'a pas les lettres de la translittération (ā, ḥ, ḫ, ǧ, ṯ…),
mais elle a des diacritiques séparés (U+0300 à U+036F). Le moteur de texte
décompose alors « ā » en « a » + macron de DotGothic16, mal placé, au lieu
de prendre la lettre complète dans la police de secours (Amiri) ; ḥ et ḫ
finissent par se ressembler. Sans ces diacritiques dans la table des
caractères, ces lettres viennent d'Amiri, entières et lisibles.

Licence : SIL OFL 1.1 (aucun nom de police réservé) ; la copie modifiée est
renommée « DotGothic16 IQURA » et reste sous OFL.

Usage (outil de développement, nécessite fontTools) :
    python3 tools/fonts/build_game_font.py
"""

from __future__ import annotations

import os

from fontTools.ttLib import TTFont

ROOT = os.path.normpath(os.path.join(os.path.dirname(__file__), "..", ".."))
SRC = os.path.join(ROOT, "assets", "fonts", "DotGothic16-Regular.ttf")
OUT = os.path.join(ROOT, "assets", "fonts", "DotGothic16-IQURA-Regular.ttf")
MARKS = range(0x0300, 0x0370)


def main() -> None:
    font = TTFont(SRC)
    for table in font["cmap"].tables:
        for cp in list(table.cmap):
            if cp in MARKS:
                del table.cmap[cp]
    for rec in font["name"].names:
        if rec.nameID in (1, 3, 4, 6, 16):
            old = rec.toUnicode()
            new = old.replace("DotGothic16", "DotGothic16 IQURA")
            if rec.nameID == 6:
                new = new.replace(" ", "")
            rec.string = new
    font.save(OUT)
    print("écrit", OUT)


if __name__ == "__main__":
    main()
