import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:iqura/data/content_db/content_database.dart';
import 'package:iqura/features/reports/error_report.dart';
import 'package:iqura/ui/game/sprites.dart';

void main() {
  late ContentDatabase db;
  setUpAll(() => db = ContentDatabase.openVerified(ContentDatabase.assetPath));
  tearDownAll(() => db.close());

  test('région 1 : 12 lieux, 4 construits pour J1a, personnages', () {
    final region = db.regions().single;
    expect(region.name, 'Le Désert des Lettres');
    final places = db.places(region.id);
    expect(places.length, 12);
    expect(places.where((p) => p.inVerticalSlice).map((p) => p.id), [
      'puits',
      'porte',
      'marche',
      'faille',
    ]);
    for (final p in places.where((p) => p.inVerticalSlice)) {
      expect(File('assets/art/${p.sceneImage}.png').existsSync(), isTrue);
      expect(p.groundY, isNotNull);
    }
    final nura = db.characters(region.id).firstWhere((c) => c.id == 'nura');
    expect(nura.places, contains('puits'));
  });

  test('Al-Fātiḥa : 7 versets avec traduction', () {
    final verses = db.surahVerses(1);
    expect(verses.length, 7);
    expect(verses.every((v) => v.translation.isNotEmpty), isTrue);
  });

  test('audio des leçons : chaque syllabe et mot a son fichier', () {
    for (final i in db.readingItems(stage: 1, upTo: 3)) {
      final f = db.audioFile(i.arabic);
      expect(f, isNotNull, reason: i.arabic);
      expect(File('assets/$f').existsSync(), isTrue);
    }
  });

  test('tailles des personnages conformes aux images', () {
    for (final MapEntry(key: name, value: (w, h)) in spriteSizes.entries) {
      final bytes = File('assets/art/$name.png').readAsBytesSync();
      final header = ByteData.sublistView(bytes, 16, 24);
      expect((header.getUint32(0), header.getUint32(4)), (w, h), reason: name);
    }
  });

  test('signalement : gardé sur l’appareil, mail prérempli', () async {
    final tmp = Directory.systemTemp.createTempSync('iqura-report');
    addTearDown(() => tmp.deleteSync(recursive: true));
    final store = ErrorReportStore('${tmp.path}/s.jsonl');
    final report = ErrorReport(
      subject: 'Fiche de la lettre ب',
      description: 'Le nom est mal écrit & la forme aussi',
      contentVersion: '0.5.0-j1a',
      createdAt: DateTime.utc(2026, 10, 23, 9),
    );
    await store.save(report);
    await store.save(report);
    expect(store.all().length, 2);
    expect(store.all().first['sujet'], 'Fiche de la lettre ب');

    final uri = report.mailto();
    expect(uri.scheme, 'mailto');
    expect(uri.path, errorReportAddress);
    expect(uri.toString(), isNot(contains('+')));
    final body = Uri.decodeComponent(uri.query.split('body=').last);
    expect(body, contains('mal écrit & la forme'));
    expect(body, contains('0.5.0-j1a'));
  });
}
