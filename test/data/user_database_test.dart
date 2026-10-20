import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:iqura/data/user_db/schema.dart';
import 'package:iqura/data/user_db/user_database.dart';
import 'package:iqura/engines/sync/export_archive.dart';
import 'package:iqura/engines/sync/table_def.dart';
import 'package:sqlite3/sqlite3.dart';

/// Base en mémoire dont l'horloge murale est pilotée par le test.
class Device {
  Device() {
    db = UserDatabase.open(null, now: () => wall);
  }
  int wall = 1000;
  late final UserDatabase db;

  void setPseudo(String pseudo) => db.upsert(profileTable, {
    'id': profileSingletonId,
    'pseudo': pseudo,
    'created_at': 1,
  });

  String? pseudo() {
    final rows = db.select('SELECT pseudo FROM profile WHERE deleted = 0');
    return rows.isEmpty ? null : rows.first['pseudo'] as String;
  }

  ExportData export() => decodeExportArchive(
    encodeExportArchive(db.exportData(appVersion: 'test'), userSchema),
    userSchema,
    currentSchemaVersion: userSchemaVersion,
  );
}

Map<String, Object?> logRow(String id) => {
  'id': id,
  'card_id': 'carte',
  'rating': 3,
  'reviewed_at': 1,
  'duration_ms': 900,
  'origin': null,
};

void main() {
  test('la base créée correspond exactement au schéma déclaré', () {
    final db = sqlite3.openInMemory();
    UserDatabase.migrate(db);
    expect(
      db.select('PRAGMA user_version').first.columnAt(0),
      userSchemaVersion,
    );
    for (final t in userSchema) {
      final info = db.select('PRAGMA table_info(${t.name})');
      expect([for (final r in info) r['name']], t.columnNames, reason: t.name);
      for (final r in info) {
        final col = t.column(r['name'] as String)!;
        expect(r['type'], col.sqlType, reason: '${t.name}.${col.name}');
        expect(r['notnull'] == 1, !col.nullable, reason: col.name);
        expect(r['pk'] == 1, col.name == t.primaryKey, reason: col.name);
      }
      if (t.kind == SyncKind.lastWriterWins) {
        expect(t.column(TableDef.hlcColumn), isNotNull);
        expect(t.column(TableDef.deletedColumn), isNotNull);
      }
    }
    db.close();
  });

  test('refuse une base créée par une version plus récente', () {
    final db = sqlite3.openInMemory();
    db.execute('PRAGMA user_version = ${userSchemaVersion + 1}');
    expect(() => UserDatabase.migrate(db), throwsStateError);
    db.close();
  });

  test("l'identifiant d'appareil et l'horloge survivent à la réouverture", () {
    final dir = Directory.systemTemp.createTempSync('iqura');
    final path = '${dir.path}/u.db';
    final a = UserDatabase.open(path, now: () => 5000);
    a.upsert(settingsTable, {'key': 'k', 'value': '1'});
    final id = a.deviceId;
    a.close();
    // L'heure système a reculé entre-temps.
    final b = UserDatabase.open(path, now: () => 10);
    expect(b.deviceId, id);
    b.upsert(settingsTable, {'key': 'k', 'value': '2'});
    final hlc = b.select('SELECT updated_hlc FROM settings').first;
    expect(
      (hlc['updated_hlc'] as String).startsWith('000000000005000:0001'),
      isTrue,
    );
    b.close();
    dir.deleteSync(recursive: true);
  });

  group('fusion entre deux appareils', () {
    test('la modification la plus récente gagne, dans les deux sens', () {
      final pc = Device();
      final phone = Device();
      pc.setPseudo('Amina');
      phone.wall = 2000;
      phone.setPseudo('Amina2');

      final r1 = pc.db.merge(phone.export());
      expect(pc.pseudo(), 'Amina2');
      expect(r1.replaced, 1);

      final r2 = phone.db.merge(pc.export());
      expect(phone.pseudo(), 'Amina2');
      expect(r2.kept, greaterThanOrEqualTo(1));
    });

    test("une modification faite après l'import gagne même si l'horloge "
        'de l’appareil retarde', () {
      final pc = Device()..wall = 1000;
      final phone = Device()..wall = 900000;
      phone.setPseudo('Téléphone');
      pc.db.merge(phone.export());
      pc.setPseudo('PC'); // mur = 1000, bien avant le téléphone
      phone.db.merge(pc.export());
      expect(phone.pseudo(), 'PC');
    });

    test('les suppressions se propagent', () {
      final pc = Device();
      final phone = Device();
      pc.db.upsert(settingsTable, {'key': 'x', 'value': '1'});
      phone.db.merge(pc.export());
      pc.wall = 3000;
      pc.db.markDeleted(settingsTable, 'x');
      phone.db.merge(pc.export());
      expect(
        phone.db
            .select("SELECT deleted FROM settings WHERE key = 'x'")
            .first['deleted'],
        1,
      );
    });

    test('les journaux sont unis sans doublons', () {
      final pc = Device();
      final phone = Device();
      pc.db.append(reviewLogTable, logRow('a'));
      pc.db.append(reviewLogTable, logRow('commun'));
      phone.db.append(reviewLogTable, logRow('b'));
      phone.db.append(reviewLogTable, logRow('commun'));

      final r = pc.db.merge(phone.export());
      expect(r.tables['review_log']!.inserted, 1);
      expect(r.tables['review_log']!.kept, 1);
      final ids = pc.db
          .select('SELECT id FROM review_log ORDER BY id')
          .map((r) => r['id']);
      expect(ids, ['a', 'b', 'commun']);
    });

    test("l'XP n'est jamais comptée deux fois (clé d'unicité)", () {
      final pc = Device();
      final phone = Device();
      Map<String, Object?> gain(String id) => {
        'id': id,
        'source': 'lecon',
        'amount': 10,
        'created_at': 1,
        'unique_key': 'lecon:1',
      };
      pc.db.append(xpLedgerTable, gain('x1'));
      phone.db.append(xpLedgerTable, gain('x2'));
      pc.db.merge(phone.export());
      expect(pc.db.select('SELECT * FROM xp_ledger'), hasLength(1));
    });

    test('fusionner deux fois la même archive ne change rien', () {
      final pc = Device();
      final phone = Device();
      phone.setPseudo('A');
      phone.db.append(reviewLogTable, logRow('r'));
      final data = phone.export();
      pc.db.merge(data);
      final before = pc.db.exportData(appVersion: 't').tables;
      final again = pc.db.merge(data);
      expect(again.inserted + again.replaced, 0);
      expect(pc.db.exportData(appVersion: 't').tables, before);
    });
  });

  test('restauration complète : remplace tout, garde l’identité locale', () {
    final pc = Device();
    final phone = Device();
    pc.setPseudo('PC');
    pc.db.append(reviewLogTable, logRow('pc-only'));
    phone.setPseudo('Téléphone');
    final pcId = pc.db.deviceId;
    pc.db.replaceAll(phone.export());
    expect(pc.pseudo(), 'Téléphone');
    expect(pc.db.select('SELECT * FROM review_log'), isEmpty);
    expect(pc.db.deviceId, pcId);
    // L'horloge locale est passée devant les dates importées.
    pc.setPseudo('Après');
    expect(pc.pseudo(), 'Après');
  });

  test('sauvegarde puis restauration depuis un fichier', () {
    final dir = Directory.systemTemp.createTempSync('iqura');
    final d = Device();
    d.setPseudo('Avant');
    d.db.append(reviewLogTable, logRow('r1'));
    final backup = '${dir.path}/b.db';
    d.db.backupTo(backup);
    d.wall = 5000;
    d.setPseudo('Après');
    d.db.append(reviewLogTable, logRow('r2'));

    d.db.restoreFromBackupFile(backup);
    expect(d.pseudo(), 'Avant');
    expect(d.db.select('SELECT id FROM review_log').map((r) => r['id']), [
      'r1',
    ]);
    // La sauvegarde elle-même n'a pas été touchée ni laissée en copie.
    expect(dir.listSync().map((e) => e.uri.pathSegments.last), ['b.db']);
    dir.deleteSync(recursive: true);
  });
}
