import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iqura/data/content_db/content_database.dart';
import 'package:iqura/ui/game/articulation_diagram.dart';

void main() {
  test('chaque lettre a un schéma d\'articulation et une description', () {
    final db = ContentDatabase.openVerified(ContentDatabase.assetPath);
    addTearDown(db.close);
    final letters = db.letters();
    expect(letters.length, 29);
    for (final l in letters) {
      expect(articulationPoints, contains(l.zoneId), reason: l.letter);
      expect(articulationLabels, contains(l.zoneId), reason: l.letter);
      // Description écrite, sans renvoi à l'écoute (audio suspendu).
      expect(l.pronunciation.length, greaterThan(80), reason: l.letter);
      expect(l.pronunciation, isNot(contains('écoute')), reason: l.letter);
    }
    expect(
      emphaticLetters.every((e) => letters.any((l) => l.letter == e)),
      isTrue,
    );
  });

  testWidgets('le schéma s\'affiche avec sa légende', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ArticulationDiagram(zoneId: 'langue_cotes', emphatic: true),
        ),
      ),
    );
    expect(find.byType(CustomPaint), findsWidgets);
    expect(find.textContaining('côté de la langue'), findsOneWidget);
    expect(find.textContaining('arrière de la langue relevé'), findsOneWidget);
  });
}
