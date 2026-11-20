import io
import unittest
import wave

import build_sfx


class SfxTest(unittest.TestCase):
    def test_every_sound_renders_short_and_deterministic(self):
        data = build_sfx.load()
        rate = data["frequence"]
        for name, sound in data["sons"].items():
            a = build_sfx.render(sound, rate, name)
            self.assertEqual(a, build_sfx.render(sound, rate, name), name)
            with wave.open(io.BytesIO(a)) as w:
                self.assertEqual((w.getnchannels(), w.getsampwidth()), (1, 2))
                self.assertLessEqual(w.getnframes() / w.getframerate(), 2)

    def test_assets_are_up_to_date(self):
        self.assertEqual(build_sfx.build(check=True), [])

    def test_rejects_bad_notes(self):
        with self.assertRaisesRegex(build_sfx.SfxError, "forme"):
            build_sfx.render({"notes": [{"forme": "voix", "freq": 440, "duree": 0.1,
                                         "volume": 0.2}]}, 22050)
        with self.assertRaisesRegex(build_sfx.SfxError, "volume"):
            build_sfx.render({"notes": [{"forme": "carree", "freq": 440, "duree": 0.1,
                                         "volume": 0.9}]}, 22050)


if __name__ == "__main__":
    unittest.main()
