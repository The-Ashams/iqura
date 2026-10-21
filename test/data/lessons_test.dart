import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:iqura/data/content_db/content_database.dart';
import 'package:iqura/engines/transliteration/transliterator.dart';
import 'package:sqlite3/sqlite3.dart';

/// Leçons de la base générée par tools/build_content/.
void main() {
  late Database db;
  setUpAll(() {
    db = sqlite3.open(ContentDatabase.assetPath, mode: OpenMode.readOnly);
  });
  tearDownAll(() => db.close());

  List<Map<String, dynamic>> lessons() => [
    for (final r in db.select(
      'SELECT content FROM lesson ORDER BY stage, ordinal',
    ))
      jsonDecode(r['content'] as String) as Map<String, dynamic>,
  ];

  test('chaque translittération rédigée correspond au moteur', () {
    const t = Transliterator();
    var checked = 0;
    for (final lesson in lessons()) {
      for (final section in (lesson['sections'] as List).cast<Map>()) {
        final items = switch (section['type']) {
          'syllabes' || 'exemples' => (section['items'] as List).cast<Map>(),
          'decomposition' => [section],
          _ => const <Map>[],
        };
        for (final item in items) {
          expect(
            t.transliterate(item['ar'] as String),
            item['translit'],
            reason: '${lesson['id']} : ${item['ar']}',
          );
          checked++;
        }
      }
    }
    expect(checked, greaterThan(20));
  });

  test(
    'les leçons ne contiennent aucun texte coranique, seulement des références',
    () {
      for (final lesson in lessons()) {
        for (final section in (lesson['sections'] as List).cast<Map>()) {
          if (section['type'] != 'coran') continue;
          for (final e in (section['extraits'] as List).cast<Map>()) {
            expect(
              e.keys.toSet().difference({'verset', 'mots', 'lettres'}),
              isEmpty,
            );
          }
        }
      }
    },
  );

  test('toute leçon est marquée « rédigé par IA »', () {
    for (final lesson in lessons()) {
      expect(
        lesson['statut'],
        'ia_non_verifie',
        reason: lesson['id'] as String,
      );
    }
    final statuses = db.select('SELECT DISTINCT status FROM letter');
    expect(statuses.map((r) => r['status']), ['ia_non_verifie']);
  });
}
