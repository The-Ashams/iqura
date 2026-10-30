"""Tests du générateur de la base de contenu (python3 -m unittest)."""

import json
import os
import shutil
import sqlite3
import sys
import tempfile
import unittest

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import build_content  # noqa: E402
import buckwalter  # noqa: E402
import copy  # noqa: E402
import exams  # noqa: E402
import lessons  # noqa: E402
import qac  # noqa: E402
import sources  # noqa: E402
import quran_guard  # noqa: E402
import vocab  # noqa: E402
import world  # noqa: E402


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


class QuranGuardTest(unittest.TestCase):
    def test_skeleton_ignores_marks_and_seats(self):
        self.assertEqual(quran_guard.skeleton("ٱلْكِتَابُ"), quran_guard.skeleton("الكتاب"))
        self.assertEqual(quran_guard.skeleton("عَلَىٰ"), quran_guard.skeleton("علي"))

    def test_three_words_in_a_row_are_rejected(self):
        grams = {("ا", "ب", "ج")}
        quran_guard.check({"x": "ا ب"}, grams)
        quran_guard.check({"x": "ا ج ب"}, grams)
        with self.assertRaises(quran_guard.QuranGuardError):
            quran_guard.check({"x": "دَ اَ بِ جُ"}, grams)

    def test_pairs_of_full_words_are_reported(self):
        words = [{"ar": "نَاقَةٌ", "nature": "nom"}, {"ar": "هَٰذِهِ", "nature": "demonstratif"},
                 {"ar": "جَمِيلَةٌ", "nature": "adjectif"}]
        pairs = {("ناقه", "جميله"), ("هذه", "ناقه")}
        words.append({"ar": "هُمْ", "nature": "pronom"})
        pairs |= {("وهم", "ناقه"), ("هذه", "هم")}
        w = vocab.quran_pair_warnings(
            {"x": "النَّاقَةُ نَاقَةٌ جَمِيلَةٌ.", "y": "هَٰذِهِ نَاقَةٌ.", "z": "وَهُمْ نَاقَةٌ.",
             "t": "هَٰذِهِ هُمْ."}, words, pairs)
        # Mot plein + mot plein, démonstratif ou pronom + mot plein : signalés ;
        # deux mots outils seuls : non.
        self.assertEqual(sorted(x[0] for x in w), ["x", "y", "z"])

    def test_inscriptions_are_checked_on_two_words(self):
        # « لَهُۥ بِهِۦ » se suit dans le Coran (relecture du 24/10/2026).
        data = build_content.collect()
        with self.assertRaises(quran_guard.QuranGuardError):
            quran_guard.check({"x": "لَهُۥ بِهِۦ"}, data["quran_pairs"], quran_guard.PAIR)
        quran_guard.check(lessons.inscriptions(lessons.load()), data["quran_pairs"],
                          quran_guard.PAIR)


class VocabTest(unittest.TestCase):
    def test_endings_are_removed_only_once_taught(self):
        known = {vocab.key("ثَوْبٌ"), vocab.key("إِبْرَةٌ"), vocab.key("فِي"),
                 vocab.key("سَلَّةٌ"), vocab.key("خَبَّازٌ"), vocab.key("كَبِيرٌ"),
                 vocab.key("مُعَلِّمٌ")}
        cases = {
            "ثَوْبِي": "pronoms", "إِبْرَتُهَا": "pronoms", "فِيهِ": "pronoms",
            "السَّلَّتَيْنِ": "duel", "الْخَبَّازُونَ": "pluriel",
            "مُعَلِّمَاتٌ": "pluriel", "كَبِيرًا": "accusatif",
        }
        for word, group in cases.items():
            self.assertEqual(vocab.unknown(word, known), [word], word)
            self.assertEqual(vocab.unknown(word, known, {group}), [], word)
        # Verbes réguliers : formes ramenées au passé ou à l'inaccompli de la fiche.
        verb = vocab.word_keys({"ar": "كَتَبَ", "passe": "كَتَبَ", "inaccompli": "يَكْتُبُ"})
        verbs = {"كَتَبْتُ": "passe", "كَتَبُوا": "passe", "تَكْتُبِينَ": "inaccompli",
                 "أَكْتُبُ": "inaccompli", "سَيَكْتُبُ": "futur", "اكْتُبُوا": "imperatif"}
        for word, group in verbs.items():
            self.assertEqual(vocab.unknown(word, verb), [word], word)
            self.assertEqual(vocab.unknown(word, verb, {group}), [], word)
        self.assertEqual(vocab.unknown("كَتَبَهُ", verb, {"passe", "pronoms"}), [])
        # Verbe figé (قَالَ) : seules ses formes écrites sont connues.
        qala = vocab.known_keys({"ar": "قَالَ", "nature": "verbe", "fige": True,
                                 "passe": "قَالَ", "inaccompli": "يَقُولُ", "formes": ["قَالَتْ"]})
        groups = set(vocab.VERB_GROUPS) | {"pronoms", "accusatif"}
        self.assertEqual(vocab.unknown("قَالَ قَالَتْ", qala, groups), [])
        # (قَالْتُ a le même squelette que قَالَتْ : le contrôle ne voit pas les voyelles.)
        for wrong in ("قَالُوا", "سَيَقُولُ", "تَقُولِينَ"):
            self.assertEqual(vocab.unknown(wrong, qala, groups), [wrong], wrong)
        # Une terminaison ne s'enlève pas d'un mot trop court.
        self.assertEqual(vocab.unknown("هِيَ", {vocab.key("هـ")}, {"pronoms"}), ["هِيَ"])


class ExamTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.data = lessons.load()
        regions = world.load()
        cls.places = {p["id"] for r in regions for p in r["lieux"]}
        cls.chars = {c["id"] for r in regions for c in r["personnages"]}

    def check(self, exam):
        exams.validate([exam], self.data.lessons, self.data.words, self.places,
                       self.chars, {"grand_mirage"})

    def test_region2_exam_is_valid(self):
        (exam,) = self.data.exams
        self.check(exam)
        texts = exams.audio_texts([exam])
        self.assertIn(("phrase", exam["lecture"]["phrases"][0]), texts)

    def test_unknown_word_short_story_and_bad_answer_are_refused(self):
        base = self.data.exams[0]
        exam = copy.deepcopy(base)
        exam["lecture"]["phrases"][0] += " سَيَّارَةٌ"
        with self.assertRaisesRegex(exams.ExamError, "mots inconnus"):
            self.check(exam)
        exam = copy.deepcopy(base)
        exam["lecture"]["phrases"] = exam["lecture"]["phrases"][:5]
        with self.assertRaisesRegex(exams.ExamError, "récit de"):
            self.check(exam)
        exam = copy.deepcopy(base)
        exam["ecoute"]["questions"][-1]["reponse"] = 1
        with self.assertRaisesRegex(exams.ExamError, "phrase entendue"):
            self.check(exam)


class SourcesTest(unittest.TestCase):
    def test_all_sources_match_their_fingerprint(self):
        sources.verify_all()

    def test_tampered_source_is_rejected(self):
        manifest = sources.load_manifest()
        with tempfile.TemporaryDirectory() as d:
            entry = manifest["qac-morphology"]
            target = os.path.join(d, entry["path"])
            os.makedirs(os.path.dirname(target))
            shutil.copy(os.path.join(sources.SOURCES_DIR, entry["path"]), target)
            with open(target, "ab") as f:
                f.write(b" ")
            with self.assertRaises(sources.SourceError):
                sources.verified_path("qac-morphology", manifest, base=d)


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
        self.assertEqual(self.counts["roots"], 1642)
        self.assertEqual(self.counts["lemmas"], 4832)

    def test_no_quran_text_is_stored(self):
        # Avenant n° 1 : ni texte, ni traduction, ni découpage du Coran.
        tables = {r[0] for r in self.q("SELECT name FROM sqlite_master WHERE type = 'table'")}
        for t in ("surah", "verse", "translation", "verse_translation", "token",
                  "segment", "token_segment", "lesson_quran_ref"):
            self.assertNotIn(t, tables)
        self.assertNotIn("quran_text_sha256", self.meta())

    def test_no_quran_sequence_in_content(self):
        # Le contenu entier repasse le garde-fou sur les suites de mots.
        data = build_content.collect()
        quran_guard.check(
            {**lessons.arabic_texts(lessons.load()), **world.arabic_texts(world.load())},
            data["quran_ngrams"],
        )
        self.assertGreater(len(data["quran_ngrams"]), 50000)

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

    def test_every_source_is_cited(self):
        ids = {r[0] for r in self.q("SELECT id FROM source")}
        self.assertEqual(ids, set(sources.load_manifest()))

    def test_lessons_are_stored(self):
        self.assertEqual(
            [r[0] for r in self.q("SELECT id FROM lesson ORDER BY stage, ordinal")][:4],
            ["dechiffrer-00", "dechiffrer-01", "dechiffrer-02", "dechiffrer-03"],
        )

    def test_every_lesson_item_has_an_audio_slot(self):
        keys = {r[0] for r in self.q("SELECT key FROM audio_clip")}
        for (content,) in self.q("SELECT content FROM lesson"):
            lesson = json.loads(content)
            elements = lesson.get("elements", {})
            groups = [elements.get("syllabes", []), elements.get("mots", [])]
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
        self.assertEqual(self.q("SELECT name, adversary FROM region ORDER BY number"),
                         [("Le Désert des Lettres", "L'Oubli"),
                          ("L'Oasis des Fondations", "La Confusion")])
        self.assertEqual(self.q("SELECT COUNT(*) FROM place WHERE region_id = 'r1'"), [(12,)])
        j1a = {r[0] for r in self.q("SELECT id FROM place WHERE in_j1a = 1 AND region_id = 'r1'")}
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
        data = lessons.LessonData(copy.deepcopy(data.letters), copy.deepcopy(data.lessons),
                                  copy.deepcopy(data.words))
        mutate(data)
        lessons.validate(data)

    def test_validation_accepts_current_lessons(self):
        self._validate(lambda d: None)

    def _screen(self, d, kind, lesson=1):
        return next(s for s in d.lessons[lesson]["ecrans"] if s["type"] == kind)

    def test_mini_donjon_rejects_untaught_letter(self):
        def mutate(d):
            d.lessons[1]["elements"]["mots"].append({"ar": "كَتَبَ", "translit": "kataba", "fr": "x"})
        with self.assertRaisesRegex(lessons.LessonError, "pas encore enseigné"):
            self._validate(mutate)

    def test_reading_room_rejects_quran_extract(self):
        def mutate(d):
            self._screen(d, "lecture")["extraits"] = [{"verset": "1:1"}]
        with self.assertRaisesRegex(lessons.LessonError, "aucun verset"):
            self._validate(mutate)

    def test_reading_room_rejects_unread_word(self):
        def mutate(d):
            self._screen(d, "lecture", 2)["inscription"].append("بِيت")
        with self.assertRaisesRegex(lessons.LessonError, "pas encore été lu"):
            self._validate(mutate)

    def test_reading_room_checks_letter_count(self):
        def mutate(d):
            q = next(q for q in self._screen(d, "lecture")["questions"] if q["type"] == "compter")
            q["lettre"] = "ث" if q["lettre"] != "ث" else "ب"
            q["mot"] = 0 if q["lettre"] == "ث" else 1
        with self.assertRaisesRegex(lessons.LessonError, "apparaît 0 fois"):
            self._validate(mutate)

    def test_madda_counts_on_alif_madda(self):
        q = next(q for q in self._screen(lessons.load(), "lecture", 14)["questions"]
                 if q["lettre"] == "ٓ")
        self.assertEqual(q["type"], "compter")

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
