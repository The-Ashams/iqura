"""Contrôle de la police du jeu modifiée (tools/fonts/build_game_font.py)."""

import os
import unittest

from fontTools.ttLib import TTFont

ROOT = os.path.normpath(os.path.join(os.path.dirname(__file__), "..", ".."))
OUT = os.path.join(ROOT, "assets", "fonts", "DotGothic16-IQURA-Regular.ttf")
SRC = os.path.join(ROOT, "assets", "fonts", "DotGothic16-Regular.ttf")


class GameFontTest(unittest.TestCase):
    def test_sans_diacritiques_combinants(self):
        cmap = TTFont(OUT).getBestCmap()
        self.assertFalse([cp for cp in cmap if 0x0300 <= cp < 0x0370])

    def test_meme_contenu_par_ailleurs(self):
        src = TTFont(SRC).getBestCmap()
        out = TTFont(OUT).getBestCmap()
        attendu = {cp: g for cp, g in src.items() if not 0x0300 <= cp < 0x0370}
        self.assertEqual(out, attendu)

    def test_renommee(self):
        names = {r.toUnicode() for r in TTFont(OUT)["name"].names if r.nameID == 1}
        self.assertIn("DotGothic16 IQURA", names)


if __name__ == "__main__":
    unittest.main()
