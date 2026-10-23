"""Tests des graphismes (python3 -m unittest discover -s tools/build_art)."""

import os
import struct
import sys
import unittest
import zlib

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import build_art  # noqa: E402


class BuildArtTest(unittest.TestCase):
    def test_rectangles_are_painted_in_order_with_opacity(self):
        w, h, px = build_art.render({"largeur": 2, "hauteur": 1, "rectangles": [
            [0, 0, 2, 1, "#ff0000"], [1, 0, 1, 1, "#0000ff", 0.5]]})
        self.assertEqual(list(px[0:4]), [255, 0, 0, 255])
        self.assertEqual(list(px[4:8]), [128, 0, 128, 255])

    def test_transparent_background_for_sprites(self):
        _, _, px = build_art.render({"largeur": 2, "hauteur": 1,
                                     "rectangles": [[0, 0, 1, 1, "#00ff00", 0.5]]})
        self.assertEqual(px[3], 128)
        self.assertEqual(px[7], 0)

    def test_out_of_bounds_rectangle_is_refused(self):
        with self.assertRaises(build_art.ArtError):
            build_art.render({"largeur": 4, "hauteur": 4, "rectangles": [[3, 3, 2, 1, "#000000"]]})

    def test_png_is_valid_and_deterministic(self):
        data = build_art.png(*build_art.render(
            {"largeur": 3, "hauteur": 2, "rectangles": [[0, 0, 3, 2, "#123456"]]}))
        self.assertTrue(data.startswith(b"\x89PNG\r\n\x1a\n"))
        w, h = struct.unpack(">II", data[16:24])
        self.assertEqual((w, h), (3, 2))
        idat = data[data.index(b"IDAT") + 4:data.index(b"IEND") - 8]
        self.assertEqual(len(zlib.decompress(idat)), 2 * (1 + 3 * 4))
        self.assertEqual(data, build_art.png(*build_art.render(
            {"largeur": 3, "hauteur": 2, "rectangles": [[0, 0, 3, 2, "#123456"]]})))

    def test_all_sources_render_and_committed_images_are_up_to_date(self):
        images = build_art.build_all()
        self.assertGreater(len(images), 0)
        for name, data in images.items():
            path = os.path.join(build_art.OUT, f"{name}.png")
            self.assertTrue(os.path.exists(path), f"{name}.png absent : lancer build_art.py")
            with open(path, "rb") as f:
                self.assertEqual(f.read(), data, f"{name}.png pas à jour : lancer build_art.py")


if __name__ == "__main__":
    unittest.main()
