import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iqura/data/user_db/schema.dart';
import 'package:iqura/engines/sync/export_archive.dart';

ExportData sample() => ExportData(
  manifest: ExportManifest(
    formatVersion: exportFormatVersion,
    schemaVersion: userSchemaVersion,
    appVersion: '0.1.0',
    createdAt: DateTime.utc(2026, 10, 20, 12),
    deviceId: 'appareil-A',
  ),
  tables: {
    'profile': [
      {
        'id': 'main',
        'pseudo': 'Amina',
        'created_at': 1,
        'updated_hlc': '000000000001000:0000:appareil-A',
        'deleted': 0,
      },
    ],
    'settings': [],
    'review_log': [
      {
        'id': 'r1',
        'card_id': 'c1',
        'rating': 3,
        'reviewed_at': 5,
        'duration_ms': 1200,
        'origin': null,
      },
    ],
    'xp_ledger': [],
  },
);

ExportData decode(Uint8List bytes) => decodeExportArchive(
  bytes,
  userSchema,
  currentSchemaVersion: userSchemaVersion,
);

/// Reconstruit une archive en modifiant ses fichiers.
Uint8List rewrite(
  Uint8List original,
  void Function(Map<String, List<int>> files) change,
) {
  final files = <String, List<int>>{
    for (final f in ZipDecoder().decodeBytes(original).files)
      f.name: f.readBytes()!,
  };
  change(files);
  final a = Archive();
  files.forEach((name, data) => a.add(ArchiveFile.bytes(name, data)));
  return ZipEncoder().encodeBytes(a);
}

Map<String, Object?> manifestOf(Map<String, List<int>> files) =>
    jsonDecode(utf8.decode(files['manifest.json']!)) as Map<String, Object?>;

void setManifest(Map<String, List<int>> files, Map<String, Object?> m) =>
    files['manifest.json'] = utf8.encode(jsonEncode(m));

/// Remplace un fichier de table et met à jour son empreinte.
void setTable(Map<String, List<int>> files, String path, String json) {
  final bytes = utf8.encode(json);
  files[path] = bytes;
  final m = manifestOf(files);
  for (final f in m['files']! as List) {
    final entry = f as Map<String, Object?>;
    if (entry['path'] == path) {
      entry['sha256'] = sha256.convert(bytes).toString();
    }
  }
  setManifest(files, m);
}

Matcher throwsArchiveError(String fragment) => throwsA(
  isA<ExportArchiveException>().having(
    (e) => e.message,
    'message',
    contains(fragment),
  ),
);

void main() {
  late Uint8List bytes;
  setUp(() => bytes = encodeExportArchive(sample(), userSchema));

  test('aller-retour sans perte', () {
    final back = decode(bytes);
    expect(back.manifest.deviceId, 'appareil-A');
    expect(back.manifest.createdAt, DateTime.utc(2026, 10, 20, 12));
    expect(back.tables['profile'], sample().tables['profile']);
    expect(back.tables['review_log'], sample().tables['review_log']);
    expect(back.tables['settings'], isEmpty);
  });

  test("n'exporte jamais les tables propres à l'appareil", () {
    final names = ZipDecoder().decodeBytes(bytes).files.map((f) => f.name);
    expect(names, isNot(contains('tables/local_meta.json')));
    expect(names, contains('manifest.json'));
  });

  test('refuse un fichier qui n’est pas un ZIP', () {
    expect(
      () => decode(Uint8List.fromList(utf8.encode('bonjour'))),
      throwsArchiveError('ZIP'),
    );
  });

  test('refuse un fichier trop gros', () {
    expect(
      () => decodeExportArchive(
        bytes,
        userSchema,
        currentSchemaVersion: userSchemaVersion,
        limits: const ArchiveLimits(maxArchiveBytes: 10),
      ),
      throwsArchiveError('volumineux'),
    );
  });

  test('refuse un contenu décompressé trop gros', () {
    expect(
      () => decodeExportArchive(
        bytes,
        userSchema,
        currentSchemaVersion: userSchemaVersion,
        limits: const ArchiveLimits(maxEntryBytes: 20),
      ),
      throwsArchiveError('volumineux'),
    );
  });

  test('refuse un fichier inconnu ou un chemin piégé', () {
    for (final name in ['../evil.json', 'tables/local_meta.json', 'x.txt']) {
      final bad = rewrite(bytes, (f) => f[name] = utf8.encode('{}'));
      expect(() => decode(bad), throwsArchiveError('inconnu'));
    }
  });

  test('refuse une archive sans en-tête', () {
    final bad = rewrite(bytes, (f) => f.remove('manifest.json'));
    expect(() => decode(bad), throwsArchiveError('manifest.json'));
  });

  test('refuse un fichier modifié (empreinte)', () {
    final bad = rewrite(bytes, (f) {
      f['tables/profile.json'] = utf8.encode(
        utf8.decode(f['tables/profile.json']!).replaceAll('Amina', 'Autre'),
      );
    });
    expect(() => decode(bad), throwsArchiveError('SHA-256'));
  });

  test('refuse un fichier listé mais absent', () {
    final bad = rewrite(bytes, (f) => f.remove('tables/settings.json'));
    expect(() => decode(bad), throwsArchiveError('ne correspondent pas'));
  });

  test('refuse une archive à laquelle il manque une table', () {
    final bad = rewrite(bytes, (f) {
      f.remove('tables/settings.json');
      final m = manifestOf(f);
      (m['files']! as List).removeWhere(
        (e) => (e as Map)['path'] == 'tables/settings.json',
      );
      setManifest(f, m);
    });
    expect(() => decode(bad), throwsArchiveError('incomplète'));
  });

  test('refuse une archive d’une version plus récente', () {
    final bad = rewrite(bytes, (f) {
      final m = manifestOf(f)..['schema_version'] = userSchemaVersion + 1;
      setManifest(f, m);
    });
    expect(() => decode(bad), throwsArchiveError('plus récente'));
  });

  test("refuse un autre format", () {
    final bad = rewrite(bytes, (f) {
      setManifest(f, manifestOf(f)..['format'] = 'autre');
    });
    expect(() => decode(bad), throwsArchiveError("n'est pas une sauvegarde"));
  });

  group('validation des tables', () {
    const path = 'tables/profile.json';
    const cols = '["id","pseudo","created_at","updated_hlc","deleted"]';
    const hlc = '000000000001000:0000:A';

    void expectRejected(String json, String fragment) {
      final bad = rewrite(bytes, (f) => setTable(f, path, json));
      expect(() => decode(bad), throwsArchiveError(fragment));
    }

    test('colonne inconnue', () {
      expectRejected(
        '{"table":"profile","columns":["id","pirate"],"rows":[]}',
        'inconnue',
      );
    });

    test('colonne obligatoire manquante', () {
      expectRejected(
        '{"table":"profile","columns":["id"],"rows":[]}',
        'manquante',
      );
    });

    test('mauvais type', () {
      expectRejected(
        '{"table":"profile","columns":$cols,'
            '"rows":[["main",42,1,"$hlc",0]]}',
        'valeur invalide',
      );
    });

    test('HLC invalide', () {
      expectRejected(
        '{"table":"profile","columns":$cols,'
            '"rows":[["main","A",1,"hier",0]]}',
        'HLC',
      );
    });

    test('identifiant en double', () {
      expectRejected(
        '{"table":"profile","columns":$cols,'
            '"rows":[["main","A",1,"$hlc",0],["main","B",1,"$hlc",0]]}',
        'double',
      );
    });

    test('mauvaise table dans le fichier', () {
      expectRejected(
        '{"table":"settings","columns":[],"rows":[]}',
        'bonne table',
      );
    });
  });
}
