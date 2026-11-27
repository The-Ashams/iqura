import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:iqura/data/content_db/content_database.dart';
import 'package:sqlite3/sqlite3.dart';

/// Ces tests lisent la base générée par
/// `python3 tools/build_content/build_content.py`.
void main() {
  const path = ContentDatabase.assetPath;

  setUpAll(() {
    if (!File(path).existsSync()) {
      fail('Base absente : lancer tools/build_content/build_content.py');
    }
  });

  test('la base ne contient aucun texte du Coran (avenant n° 1)', () {
    final db = sqlite3.open(path, mode: OpenMode.readOnly);
    final tables = {
      for (final r in db.select(
        "SELECT name FROM sqlite_master WHERE type = 'table'",
      ))
        r['name'] as String,
    };
    for (final t in ['surah', 'verse', 'verse_translation', 'token']) {
      expect(tables, isNot(contains(t)));
    }
    db.close();
  });

  test('openVerified accepte la base générée et cite ses sources', () {
    final db = ContentDatabase.openVerified(path);
    final ids = db.sources().map((s) => s.id).toSet();
    expect(ids, {'qac-morphology'});
    final notices = db.sourceNotices();
    expect(notices['qac-morphology'], contains('Kais Dukes'));
    expect(notices['qac-morphology'], contains('http://corpus.quran.com'));
    expect(db.contentVersion, isNot('inconnue'));
    db.close();
  });

  test('une base d’une autre version de schéma est refusée', () {
    final tmp = Directory.systemTemp.createTempSync('iqura-content');
    final copy = '${tmp.path}/c.db';
    File(path).copySync(copy);
    final rw = sqlite3.open(copy);
    rw.execute('PRAGMA user_version = ${ContentDatabase.schemaVersion - 1}');
    rw.close();
    expect(
      () => ContentDatabase.openVerified(copy),
      throwsA(isA<ContentIntegrityException>()),
    );
    tmp.deleteSync(recursive: true);
  });

  test('une base sans les tables attendues est refusée proprement', () {
    final tmp = Directory.systemTemp.createTempSync('iqura-content');
    final copy = '${tmp.path}/c.db';
    sqlite3.open(copy)
      ..execute('PRAGMA user_version = ${ContentDatabase.schemaVersion}')
      ..close();
    expect(
      () => ContentDatabase.openVerified(copy),
      throwsA(isA<ContentIntegrityException>()),
    );
    tmp.deleteSync(recursive: true);
  });
}
