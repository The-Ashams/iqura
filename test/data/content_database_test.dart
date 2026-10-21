import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:iqura/data/content_db/content_database.dart';
import 'package:iqura/data/content_db/quran_integrity.dart';
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

  test('le texte coranique a exactement l’empreinte de Tanzil', () {
    final db = sqlite3.open(path, mode: OpenMode.readOnly);
    expect(quranTextSha256(db), expectedQuranTextSha256);
    expect(db.select('SELECT COUNT(*) AS n FROM verse').first['n'], 6236);
    expect(db.select('SELECT COUNT(*) AS n FROM surah').first['n'], 114);
    db.close();
  });

  test('openVerified accepte la base générée et cite ses sources', () {
    final db = ContentDatabase.openVerified(path);
    final ids = db.sources().map((s) => s.id).toSet();
    expect(ids, containsAll(['tanzil-uthmani', 'qac-morphology']));
    final notices = db.sourceNotices();
    expect(notices['qac-morphology'], contains('Kais Dukes'));
    expect(notices['qac-morphology'], contains('http://corpus.quran.com'));
    expect(db.contentVersion, isNot('inconnue'));
    db.close();
  });

  test('une seule lettre modifiée dans un verset est détectée', () {
    final tmp = Directory.systemTemp.createTempSync('iqura-content');
    final copy = '${tmp.path}/c.db';
    File(path).copySync(copy);
    final rw = sqlite3.open(copy);
    rw.execute(
      "UPDATE verse SET text_uthmani = text_uthmani || 'ا' WHERE id = 6236",
    );
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
