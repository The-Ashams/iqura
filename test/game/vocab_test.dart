import 'package:flutter_test/flutter_test.dart';
import 'package:iqura/data/content_db/content_database.dart';
import 'package:iqura/game/vocab/word.dart';

void main() {
  late ContentDatabase db;
  setUpAll(() => db = ContentDatabase.openVerified(ContentDatabase.assetPath));
  tearDownAll(() => db.close());

  test('la forme de base calculée en Dart est celle du pipeline Python', () {
    final words = db.words();
    expect(words, isNotEmpty);
    for (final w in words) {
      expect(w.keys, contains(arabicKey(w.arabic)), reason: w.arabic);
    }
  });

  test('un mot touché dans une phrase retrouve sa fiche', () {
    expect(db.wordForToken('الْجَمَلُ')?.id, 'jamal');
    expect(db.wordForToken('وَالْمَاءُ')?.id, 'ma');
    expect(db.wordForToken('كَبِيرَةٌ')?.id, 'kabir');
    expect(db.wordForToken('؟')?.id, isNull);
  });

  test('terminaisons : pronom collé, duel, pluriel, alif du tanwīn', () {
    expect(keyCandidates('إِبْرَتُهَا'), contains(arabicKey('إِبْرَةٌ')));
    expect(keyCandidates('ثَوْبِي'), contains(arabicKey('ثَوْبٌ')));
    expect(keyCandidates('فِيهِ'), contains(arabicKey('فِي')));
    expect(keyCandidates('السَّلَّتَيْنِ'), contains(arabicKey('سَلَّةٌ')));
    expect(keyCandidates('مُعَلِّمَاتٌ'), contains(arabicKey('مُعَلِّمَةٌ')));
    expect(keyCandidates('كَبِيرًا'), contains(arabicKey('كَبِيرٌ')));
    expect(db.wordForToken('خَيْمَتُنَا')?.id, 'khayma');
    // Verbes réguliers.
    expect(db.wordForToken('ذَهَبْتُ')?.id, 'dhahaba');
    expect(db.wordForToken('تَخْرُجُونَ')?.id, 'kharaja');
    expect(db.wordForToken('سَيَدْخُلُ')?.id, 'dakhala');
    // هِيَ n'est pas « ه + ي ».
    expect(keyCandidates('هِيَ'), isNot(contains('ه')));
  });

  test('dictionnaire : arabe avec ou sans voyelles, français, racine', () {
    final words = db.words();
    expect(searchWords(words, 'جمل').first.id, 'jamal');
    expect(searchWords(words, 'جَمَلٌ').first.id, 'jamal');
    expect(searchWords(words, 'chameau').map((w) => w.id), contains('jamal'));
    expect(searchWords(words, 'eleve'), isEmpty);
    expect(searchWords(words, 'enseignant').single.id, 'muallim');
    // Par racine : ج م ل donne chameau et beau.
    expect(
      searchWords(words, 'جمل').map((w) => w.id),
      containsAll(['jamal', 'jamil']),
    );
    expect(searchWords(words, ''), isEmpty);
  });

  test('chaque fiche est sourcée ; la racine vient du Corpus', () {
    for (final w in db.words()) {
      expect(w.meaningSource, 'rédigé par IA');
      if (w.lemmaId != null) expect(w.occurrences, isNotNull);
    }
    expect(db.word('jamal')!.rootLetters, 'جمل');
    expect(db.word('tamr')!.rootLetters, isNull);
  });
}
