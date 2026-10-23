import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:iqura/data/content_db/content_database.dart';
import 'package:iqura/game/combat/practice_combat.dart';
import 'package:iqura/game/world.dart';

void main() {
  late ContentDatabase db;
  late List<ReadingItem> items;

  setUpAll(() {
    db = ContentDatabase.openVerified(ContentDatabase.assetPath);
    items = db.readingItems(stage: 1, upTo: 3);
  });
  tearDownAll(() => db.close());

  test(
    'questions : 3 ou 4 choix, tous différents, une seule bonne réponse',
    () {
      final random = Random(1);
      for (var n = 0; n < 500; n++) {
        final q = buildQuestion(items, random);
        expect(q.choices.length, inInclusiveRange(3, 4));
        expect(q.choices.toSet().length, q.choices.length);
        expect(q.choices[q.answer], q.target.translit);
        // Jamais deux bonnes réponses : aucune autre lecture de la cible
        // parmi les choix.
        final readings = items
            .where((i) => i.arabic == q.target.arabic)
            .map((i) => i.translit)
            .toSet();
        expect(q.choices.where(readings.contains).length, 1);
      }
    },
  );

  test('les questions viennent seulement des syllabes et mots construits', () {
    // Les extraits coraniques des leçons ne sont que des références : aucun
    // ne peut devenir une question de combat.
    final quranTokens = db.surahVerses(1).map((v) => v.arabic).toSet();
    expect(items, isNotEmpty);
    for (final i in items) {
      expect(i.lessonOrdinal, inInclusiveRange(0, 3));
      expect(
        quranTokens.any((t) => t.contains(i.arabic) && i.arabic.length > 4),
        isFalse,
      );
    }
  });

  test('trop peu de lectures différentes : refus explicite', () {
    const one = ReadingItem(arabic: 'بَ', translit: 'ba', lessonOrdinal: 1);
    expect(() => buildQuestion([one, one], Random(1)), throwsStateError);
  });

  test('dégâts : coup critique si rapide, repli à 0 PV, combat terminé', () {
    final c = PracticeCombat(heroMaxHp: 20, foeMaxHp: 30);
    expect(
      c.answer(right: true, time: const Duration(seconds: 1)),
      PracticeCombat.criticalHit,
    );
    expect(
      c.answer(right: true, time: const Duration(seconds: 5)),
      PracticeCombat.hit,
    );
    expect(c.foeHp, 5);
    c.answer(right: false, time: Duration.zero);
    c.answer(right: false, time: Duration.zero);
    expect(c.heroHp, 0);
    expect(c.outcome, CombatOutcome.retreat);
    expect(() => c.answer(right: true, time: Duration.zero), throwsStateError);
    expect((c.correct, c.wrong), (2, 2));
  });

  test('victoire quand la brume tombe à 0 PV', () {
    final c = PracticeCombat(foeMaxHp: 10);
    c.answer(right: true, time: const Duration(seconds: 9));
    expect(c.outcome, CombatOutcome.victory);
  });
}
