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
      final elements = (lesson['elements'] as Map?) ?? const {};
      for (final kind in ['syllabes', 'mots']) {
        for (final item
            in ((elements[kind] as List?) ?? const []).cast<Map>()) {
          expect(
            t.transliterate(item['ar'] as String),
            item['translit'],
            reason: '${lesson['id']} : ${item['ar']}',
          );
          checked++;
        }
      }
    }
    // Fiches de mots (région 2).
    for (final r in db.select('SELECT ar, translit FROM word')) {
      expect(
        t.transliterate(r['ar'] as String),
        r['translit'],
        reason: r['ar'] as String,
      );
      checked++;
    }
    expect(checked, greaterThan(20));
  });

  test('aucun verset ni extrait coranique dans les leçons (avenant n° 1)', () {
    for (final lesson in lessons()) {
      for (final part in (lesson['ecrans'] as List).cast<Map>()) {
        expect(part['type'], isNot('coran'), reason: lesson['id'] as String);
        expect(part.containsKey('extraits'), isFalse);
        expect(part.containsKey('verset'), isFalse);
        for (final q in [
          ...((part['questions'] as List?) ?? const []),
          ...((part['exercices'] as List?) ?? const []),
        ].cast<Map>()) {
          expect(q['mot'], anyOf(isNull, isA<int>()));
        }
      }
    }
  });

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
