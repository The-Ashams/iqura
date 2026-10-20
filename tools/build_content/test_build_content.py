"""Tests du générateur de la base de contenu (python3 -m unittest)."""

import json
import os
import shutil
import sqlite3
import sys
import tempfile
import unittest

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import align  # noqa: E402
import build_content  # noqa: E402
import buckwalter  # noqa: E402
import copy  # noqa: E402
import lessons  # noqa: E402
import qac  # noqa: E402
import sources  # noqa: E402
import tanzil  # noqa: E402

# Empreinte de référence du texte Tanzil Uthmani 1.1 (définition dans
# tanzil.integrity_sha256). La même valeur est figée dans l'application :
# lib/data/content_db/quran_integrity.dart.
EXPECTED_QURAN_SHA256 = "351c2dcbf6ec6ccebb856bf5cb82f40073767fbd215ea92008e82989fcae189e"


class BuckwalterTest(unittest.TestCase):
    def test_examples(self):
        # k-i-t-a-A-b : kāf, kasra, tāʾ, fatḥa, alif, bāʾ
        self.assertEqual(
            buckwalter.to_arabic("kitaAb"), "\u0643\u0650\u062A\u064E\u0627\u0628"
        )
        # Ordre conservé : shadda puis fatḥa.
        self.assertEqual(buckwalter.to_arabic("~a"), "\u0651\u064E")
        self.assertEqual(buckwalter.to_arabic("bi"), "بِ")

    def test_unknown_character_is_rejected(self):
        with self.assertRaises(ValueError):
            buckwalter.to_arabic("kaAna2")

    def test_table_is_one_to_one(self):
        self.assertEqual(len(set(buckwalter.TABLE.values())), len(buckwalter.TABLE))

    def test_lemma_disambiguation_digit(self):
        self.assertEqual(qac.lemma_display_bw("kaAna2"), "kaAna")


class SkeletonTest(unittest.TestCase):
    def test_hamza_seats_and_tatweel(self):
        # « ٱلْـَٔاخِرَةِ » (Tanzil) et « ءَاخِرَةِ » (Corpus) ont le même squelette.
        self.assertEqual(
            align.skeleton("ٱلْـَٔاخِرَةِ")[2:], align.skeleton("ءَاخِرَةِ")
        )

    def test_alif_maksura_with_dagger_alif(self):
        self.assertEqual(align.skeleton("صَـٰحِبَ"), align.skeleton("صَىٰحِبَ"))


class SourcesTest(unittest.TestCase):
    def test_all_sources_match_their_fingerprint(self):
        sources.verify_all()

    def test_tampered_source_is_rejected(self):
        manifest = sources.load_manifest()
        with tempfile.TemporaryDirectory() as d:
            entry = manifest["tanzil-metadata"]
            target = os.path.join(d, entry["path"])
            os.makedirs(os.path.dirname(target))
            shutil.copy(os.path.join(sources.SOURCES_DIR, entry["path"]), target)
            with open(target, "ab") as f:
                f.write(b" ")
            with self.assertRaises(sources.SourceError):
                sources.verified_path("tanzil-metadata", manifest, base=d)


class BuildTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.dir = tempfile.mkdtemp()
        cls.out = os.path.join(cls.dir, "c.db")
        cls.counts = build_content.build(cls.out)
        cls.con = sqlite3.connect(cls.out)

    @classmethod
    def tearDownClass(cls):
        cls.con.close()
        shutil.rmtree(cls.dir)

    def q(self, sql, *args):
        return self.con.execute(sql, args).fetchall()

    def meta(self):
        return dict(self.q("SELECT key, value FROM content_meta"))

    def test_counts(self):
        self.assertEqual(self.counts["surahs"], 114)
        self.assertEqual(self.counts["verses"], 6236)
        self.assertEqual(self.counts["roots"], 1642)
        self.assertEqual(self.counts["lemmas"], 4832)
        self.assertEqual(self.counts["segments"], 128219)

    def test_quran_text_fingerprint(self):
        self.assertEqual(self.meta()["quran_text_sha256"], EXPECTED_QURAN_SHA256)

    def test_text_is_copied_verbatim(self):
        text = tanzil.read_text_xml(sources.verified_path("tanzil-uthmani"))
        stored = self.q("SELECT surah_id, ayah, text_uthmani FROM verse ORDER BY id")
        self.assertEqual(stored, [(v.surah, v.ayah, v.text) for v in text.verses])
        bism = dict(self.q("SELECT id, bismillah FROM surah WHERE bismillah IS NOT NULL"))
        self.assertEqual(bism, text.bismillah)
        self.assertNotIn(1, bism)
        self.assertNotIn(9, bism)

    def test_tokens_are_exact_substrings_in_order(self):
        for vid, text in self.q("SELECT id, text_uthmani FROM verse"):
            words = [t for (t,) in self.q(
                "SELECT text FROM token WHERE verse_id = ? ORDER BY position", vid)]
            pos = 0
            for w in words:
                found = text.find(w, pos)
                self.assertGreaterEqual(found, 0, (vid, w))
                pos = found + len(w)

    def test_every_token_and_segment_is_linked(self):
        self.assertEqual(self.q(
            "SELECT COUNT(*) FROM token t WHERE NOT EXISTS "
            "(SELECT 1 FROM token_segment ts WHERE ts.token_id = t.id)"), [(0,)])
        self.assertEqual(self.q(
            "SELECT COUNT(*) FROM segment s WHERE NOT EXISTS "
            "(SELECT 1 FROM token_segment ts WHERE ts.segment_id = s.id)"), [(0,)])

    def test_known_alignment_differences(self):
        diffs = json.loads(self.meta()["alignment_word_count_differences"])
        self.assertEqual(diffs, ["2:181", "8:6", "13:37", "37:130"])
        # « بَعْدَ مَا » : deux mots Tanzil, un seul mot du Corpus.
        rows = self.q(
            "SELECT ts.token_id, ts.segment_id FROM token_segment ts "
            "WHERE ts.token_id IN ('2:181:3', '2:181:4') ORDER BY 1")
        self.assertEqual(rows, [("2:181:3", "2:181:3:1"), ("2:181:4", "2:181:3:2")])

    def test_al_fatiha_first_word(self):
        rows = self.q(
            "SELECT s.form, s.lemma_id, s.root_id FROM token_segment ts "
            "JOIN segment s ON s.id = ts.segment_id WHERE ts.token_id = '1:1:1' "
            "ORDER BY s.position")
        self.assertEqual(rows, [("بِ", None, None), ("سْمِ", "{som", "smw")])
        self.assertEqual(self.q("SELECT letters FROM root WHERE id = 'smw'"), [("سمو",)])

    def test_lemma_root_tree_data(self):
        def lemma(lid):
            return self.q(
                "SELECT root_id, pos, pos_all, verb_form, derivation, pattern "
                "FROM lemma WHERE id = ?", lid)[0]
        # Verbe sans marque dans le Corpus = forme I (convention du Corpus).
        self.assertEqual(lemma("r~aHima"), ("rHm", "V", "V", "I", None, None))
        # Forme IV marquée, participe actif de forme VIII.
        self.assertEqual(lemma(">anoEama")[3], "IV")
        self.assertEqual(lemma("mut~aqiyn")[3:5], ("VIII", "ACT_PCPL"))
        # Participe actif sans marque : forme I ; participe passif.
        self.assertEqual(lemma("ma`lik")[3:5], ("I", "ACT_PCPL"))
        self.assertEqual(lemma("magoDuwb")[3:5], ("I", "PASS_PCPL"))
        # Catégorie principale et catégories attestées.
        self.assertEqual(lemma("r~aHoma`n")[1:3], ("N", "ADJ,N"))
        # Nom simple : ni forme verbale ni dérivation.
        self.assertEqual(lemma("raHomap")[3:5], (None, None))
        # Schème : aucune source, jamais rempli.
        self.assertEqual(self.q("SELECT COUNT(*) FROM lemma WHERE pattern IS NOT NULL"), [(0,)])
        self.assertEqual(
            {r[0] for r in self.q("SELECT DISTINCT verb_form FROM lemma WHERE verb_form IS NOT NULL")},
            {"I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII"},
        )

    def test_translation_and_divisions(self):
        self.assertEqual(self.q("SELECT COUNT(*) FROM verse_translation"), [(6236,)])
        self.assertEqual(
            self.q("SELECT juz, hizb_quarter, page FROM verse WHERE surah_id = 2 AND ayah = 142"),
            [(2, 9, 22)],  # le juzʾ 2 commence au 9e quart de hizb
        )
        self.assertEqual(self.q("SELECT MAX(juz), MAX(hizb_quarter), MAX(page) FROM verse"),
                         [(30, 240, 604)])
        self.assertEqual(self.q("SELECT COUNT(*) FROM verse WHERE sajda IS NOT NULL"), [(15,)])

    def test_every_source_is_cited(self):
        ids = {r[0] for r in self.q("SELECT id FROM source")}
        self.assertEqual(ids, set(sources.load_manifest()))

    def test_lessons_are_stored_with_their_quran_references(self):
        self.assertEqual(
            [r[0] for r in self.q("SELECT id FROM lesson ORDER BY stage, ordinal")][:4],
            ["lire-00", "lire-01", "lire-02", "lire-03"],
        )
        refs = self.q("SELECT COUNT(*) FROM lesson_quran_ref WHERE token_id IS NOT NULL")
        self.assertGreater(refs[0][0], 0)
        self.assertEqual(self.q(
            "SELECT COUNT(*) FROM lesson_quran_ref r LEFT JOIN token t ON t.id = r.token_id "
            "WHERE r.token_id IS NOT NULL AND t.id IS NULL"), [(0,)])

    def _validate(self, mutate):
        data = lessons.load()
        data = lessons.LessonData(copy.deepcopy(data.letters), copy.deepcopy(data.lessons))
        mutate(data)
        lessons.validate(data, self.con)

    def test_validation_accepts_current_lessons(self):
        self._validate(lambda d: None)

    def test_validation_rejects_untaught_letter(self):
        def mutate(d):
            ex = next(s for s in d.lessons[1]["sections"] if s["type"] == "exemples")
            ex["items"].append({"ar": "كَتَبَ", "translit": "kataba", "fr": "x"})
        with self.assertRaisesRegex(lessons.LessonError, "pas encore enseigné"):
            self._validate(mutate)

    def test_validation_rejects_copied_quran_text(self):
        def mutate(d):
            sec = next(s for s in d.lessons[1]["sections"] if s["type"] == "coran")
            sec["extraits"][0]["ar"] = "texte recopié"
        with self.assertRaisesRegex(lessons.LessonError, "jamais recopié"):
            self._validate(mutate)

    def test_validation_rejects_wrong_reference_or_letter(self):
        def bad_token(d):
            sec = next(s for s in d.lessons[1]["sections"] if s["type"] == "coran")
            sec["extraits"][0]["mots"] = ["78:7:99"]
        with self.assertRaisesRegex(lessons.LessonError, "inexistant"):
            self._validate(bad_token)

        def bad_letter(d):
            sec = next(s for s in d.lessons[1]["sections"] if s["type"] == "coran")
            sec["extraits"][0]["lettres"] = ["خ"]
        with self.assertRaisesRegex(lessons.LessonError, "aucun mot cité"):
            self._validate(bad_letter)

    def test_rebuild_replaces_file(self):
        build_content.build(self.out)
        self.assertEqual(sorted(os.listdir(self.dir)), ["c.db", "c.db.version"])


if __name__ == "__main__":
    unittest.main()
