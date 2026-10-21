"""Tests du nettoyage audio (python3 -m unittest discover -s tools/build_audio)."""

import os
import sys
import unittest

import numpy as np

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import trim  # noqa: E402

SR = 24000


def tone(seconds, amp=0.5, f=220):
    t = np.arange(int(seconds * SR)) / SR
    return (amp * np.sin(2 * np.pi * f * t)).astype(np.float32)


def silence(seconds):
    return np.zeros(int(seconds * SR), dtype=np.float32)


class TrimTest(unittest.TestCase):
    def test_keeps_first_utterance_and_drops_trailing_noise(self):
        x = np.concatenate([silence(0.1), tone(0.4), silence(0.6), tone(1.5, 0.3)])
        r = trim.trim_first_utterance(x, SR)
        self.assertAlmostEqual(r.speech_start, 0.1, delta=0.03)
        self.assertAlmostEqual(r.speech_end, 0.5, delta=0.03)
        self.assertAlmostEqual(r.dropped_seconds, 1.5, delta=0.05)
        self.assertLess(len(r.audio) / SR, 0.75)

    def test_short_pauses_inside_a_phrase_are_kept(self):
        x = np.concatenate([tone(0.4), silence(0.15), tone(0.4), silence(0.8), tone(0.3)])
        r = trim.trim_first_utterance(x, SR)
        self.assertAlmostEqual(r.speech_end, 0.95, delta=0.03)

    def test_ends_with_a_fade(self):
        r = trim.trim_first_utterance(np.concatenate([tone(0.5), silence(0.5)]), SR)
        self.assertLess(abs(float(r.audio[-1])), 1e-3)

    def test_silence_is_rejected(self):
        with self.assertRaises(ValueError):
            trim.trim_first_utterance(silence(1.0), SR)

    def test_expected_min_duration(self):
        self.assertAlmostEqual(trim.expected_min_duration("بَ"), 0.12)
        self.assertAlmostEqual(trim.expected_min_duration("كِتَابٌ"), 0.18, places=2)


if __name__ == "__main__":
    unittest.main()
