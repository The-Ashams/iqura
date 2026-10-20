/// Accès en lecture seule à `iqura_content.db`.
///
/// La base est livrée dans les ressources de l'application
/// (`assets/content/`), générée par `tools/build_content/`. Au démarrage,
/// elle est copiée dans le dossier de l'application si sa version a changé,
/// puis ouverte en lecture seule.
library;

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

class ContentDatabase {
  ContentDatabase._(this._db);

  final Database _db;

  static const assetPath = 'assets/content/iqura_content.db';
  static const versionAssetPath = 'assets/content/iqura_content.db.version';

  /// Copie (si besoin) puis ouvre la base dans [directory].
  static Future<ContentDatabase> install(
    String directory, {
    AssetBundle? bundle,
  }) async {
    final assets = bundle ?? rootBundle;
    final version = (await assets.loadString(versionAssetPath)).trim();
    final dbPath = p.join(directory, 'iqura_content.db');
    final versionFile = File('$dbPath.version');
    final installed = versionFile.existsSync()
        ? versionFile.readAsStringSync().trim()
        : null;
    if (installed != version || !File(dbPath).existsSync()) {
      final data = await assets.load(assetPath);
      final tmp = File('$dbPath.tmp');
      await tmp.writeAsBytes(
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
        flush: true,
      );
      await tmp.rename(dbPath);
      await versionFile.writeAsString(version, flush: true);
    }
    return openFile(dbPath);
  }

  /// Ouvre un fichier existant en lecture seule.
  static ContentDatabase openFile(String path) =>
      ContentDatabase._(sqlite3.open(path, mode: OpenMode.readOnly));

  /// Métadonnées (version du contenu, sources…).
  Map<String, String> meta() => {
    for (final row in _db.select('SELECT key, value FROM content_meta'))
      row['key'] as String: row['value'] as String,
  };

  String get contentVersion => meta()['content_version'] ?? 'inconnue';

  void close() => _db.close();
}
