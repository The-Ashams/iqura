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
import world  # noqa: E402

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
            ["dechiffrer-00", "dechiffrer-01", "dechiffrer-02", "dechiffrer-03"],
        )
        refs = self.q("SELECT COUNT(*) FROM lesson_quran_ref WHERE token_id IS NOT NULL")
        self.assertGreater(refs[0][0], 0)
        self.assertEqual(self.q(
            "SELECT COUNT(*) FROM lesson_quran_ref r LEFT JOIN token t ON t.id = r.token_id "
            "WHERE r.token_id IS NOT NULL AND t.id IS NULL"), [(0,)])

    def test_every_lesson_item_has_an_audio_slot(self):
        keys = {r[0] for r in self.q("SELECT key FROM audio_clip")}
        for (content,) in self.q("SELECT content FROM lesson"):
            lesson = json.loads(content)
            if lesson.get("format") == 2:
                groups = [lesson["elements"]["syllabes"], lesson["elements"]["mots"]]
            else:
                groups = [s["items"] for s in lesson["sections"]
                          if s["type"] in ("syllabes", "exemples")]
            for items in groups:
                for item in items:
                    self.assertIn(lessons.audio_key(item["ar"]), keys, item["ar"])
        # Chaque enregistrement est livré, signalé comme synthèse et sourcé.
        self.assertEqual(self.q(
            "SELECT COUNT(*) FROM audio_clip WHERE file IS NULL OR synthetic IS NOT 1 "
            "OR origin IS NULL"), [(0,)])
        for (f,) in self.q("SELECT file FROM audio_clip"):
            self.assertTrue(os.path.exists(os.path.join(lessons.REPO_ROOT, "assets", f)), f)

    def test_audio_manifest_is_checked(self):
        with tempfile.TemporaryDirectory() as root:
            os.makedirs(os.path.join(root, "assets", "audio"))
            with open(os.path.join(root, "assets", "audio", "a.mp3"), "wb") as f:
                f.write(b"son")
            import hashlib
            sha = hashlib.sha256(b"son").hexdigest()
            clips = {"k": ("mot", "بَ")}
            entry = {"texte": "بَ", "fichier": "assets/audio/a.mp3", "sha256": sha}
            m = {"origine": "test", "synthese": True, "clips": {"k": entry}}
            self.assertEqual(lessons.audio_rows(clips, m, root),
                             [("k", "mot", "بَ", "audio/a.mp3", "test", 1)])
            with self.assertRaisesRegex(lessons.LessonError, "SHA-256"):
                lessons.audio_rows(clips, {**m, "clips": {"k": {**entry, "sha256": "0"}}}, root)
            with self.assertRaisesRegex(lessons.LessonError, "texte"):
                lessons.audio_rows(clips, {**m, "clips": {"k": {**entry, "texte": "بِ"}}}, root)
            with self.assertRaisesRegex(lessons.LessonError, "sans leçon"):
                lessons.audio_rows({}, m, root)

    def test_region_1_places_and_characters(self):
        self.assertEqual(self.q("SELECT name, adversary FROM region"),
                         [("Le Désert des Lettres", "L'Oubli")])
        self.assertEqual(self.q("SELECT COUNT(*) FROM place"), [(12,)])
        j1a = {r[0] for r in self.q("SELECT id FROM place WHERE in_j1a = 1")}
        self.assertEqual(len(j1a), 12)
        self.assertEqual(self.q("SELECT COUNT(*) FROM place WHERE in_j1a = 1 AND scene_image IS NULL"), [(0,)])
        self.assertEqual(self.q("SELECT name FROM character WHERE id = 'nura'"), [("Nūra",)])

    def _validate_world(self, mutate):
        data = copy.deepcopy(world.load())
        mutate(data)
        world.validate(data, self.con)

    def test_world_validation_rejects_unknown_link(self):
        def mutate(d):
            d[0]["lieux"][0]["liens"].append("nulle-part")
        with self.assertRaisesRegex(world.WorldError, "lieu inconnu"):
            self._validate_world(mutate)

    def test_world_validation_rejects_missing_lesson_in_j1a(self):
        def mutate(d):
            d[0]["lieux"][0]["lecons"] = [42]
        with self.assertRaisesRegex(world.WorldError, "leçons inexistantes"):
            self._validate_world(mutate)

    def test_world_validation_rejects_position_off_map(self):
        def mutate(d):
            d[0]["lieux"][0]["position"] = [200, 10]
        with self.assertRaisesRegex(world.WorldError, "hors de la carte"):
            self._validate_world(mutate)

    def _validate(self, mutate):
        data = lessons.load()
        data = lessons.LessonData(copy.deepcopy(data.letters), copy.deepcopy(data.lessons))
        mutate(data)
        lessons.validate(data, self.con)

    def test_validation_accepts_current_lessons(self):
        self._validate(lambda d: None)

    def _screen(self, d, kind, lesson=1):
        return next(s for s in d.lessons[lesson]["ecrans"] if s["type"] == kind)

    def test_mini_donjon_rejects_untaught_letter(self):
        def mutate(d):
            d.lessons[1]["elements"]["mots"].append({"ar": "كَتَبَ", "translit": "kataba", "fr": "x"})
        with self.assertRaisesRegex(lessons.LessonError, "pas encore enseigné"):
            self._validate(mutate)

    def test_mini_donjon_rejects_copied_quran_text(self):
        def mutate(d):
            self._screen(d, "coran")["extraits"][0]["texte"] = "recopié"
        with self.assertRaisesRegex(lessons.LessonError, "jamais recopié"):
            self._validate(mutate)

    def test_mini_donjon_rejects_short_boss(self):
        def mutate(d):
            boss = self._screen(d, "mini_boss")
            boss["questions"] = boss["questions"][:9]
        with self.assertRaisesRegex(lessons.LessonError, "10 à 12 questions"):
            self._validate(mutate)

    def test_mini_donjon_requires_revision_share(self):
        def mutate(d):
            for q in self._screen(d, "mini_boss")["questions"]:
                q.pop("revision", None)
        with self.assertRaisesRegex(lessons.LessonError, "révision"):
            self._validate(mutate)

    def test_mini_donjon_rejects_long_text(self):
        def mutate(d):
            self._screen(d, "entree", 0)["repliques"][0]["texte"] = "Un. Deux. Trois."
        with self.assertRaisesRegex(lessons.LessonError, "2 phrases"):
            self._validate(mutate)

    def test_mini_donjon_rejects_wrong_listening_answer(self):
        def mutate(d):
            q = next(q for q in self._screen(d, "entrainement")["exercices"] if q["type"] == "ecouter")
            q["reponse"] = (q["reponse"] + 1) % len(q["choix_ar"])
        with self.assertRaisesRegex(lessons.LessonError, "son entendu"):
            self._validate(mutate)

    def test_mini_donjon_rejects_verse_in_combat(self):
        def mutate(d):
            self._screen(d, "mini_boss")["questions"][0]["type"] = "reperer_mot"
        with self.assertRaisesRegex(lessons.LessonError, "interdit au combat"):
            self._validate(mutate)

    def test_mini_donjon_rejects_wrong_quran_reference(self):
        def mutate(d):
            q = self._screen(d, "coran")["extraits"][0]["question"]
            q["mot"] = q["mot"].rsplit(":", 1)[0] + ":99"
        with self.assertRaisesRegex(lessons.LessonError, "inexistant"):
            self._validate(mutate)

    def test_mini_donjon_requires_warm_up_from_lesson_2(self):
        def mutate(d):
            d.lessons[2]["ecrans"] = [s for s in d.lessons[2]["ecrans"]
                                      if s["type"] != "echauffement"]
        with self.assertRaisesRegex(lessons.LessonError, "échauffement"):
            self._validate(mutate)

    def test_rebuild_replaces_file(self):
        build_content.build(self.out)
        self.assertEqual(sorted(os.listdir(self.dir)), ["c.db", "c.db.version"])


if __name__ == "__main__":
    unittest.main()
