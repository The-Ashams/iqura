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

import 'quran_integrity.dart';

/// La base de contenu est absente, d'une autre version ou altérée.
class ContentIntegrityException implements Exception {
  const ContentIntegrityException(this.message);
  final String message;
  @override
  String toString() => message;
}

/// Source de données citée dans l'application.
class ContentSource {
  const ContentSource({
    required this.id,
    required this.title,
    required this.attribution,
    required this.license,
    required this.link,
    this.notes,
  });

  final String id;
  final String title;
  final String attribution;
  final String license;
  final String link;
  final String? notes;
}

class ContentDatabase {
  ContentDatabase._(this._db);

  final Database _db;

  static const assetPath = 'assets/content/iqura_content.db';
  static const versionAssetPath = 'assets/content/iqura_content.db.version';

  /// Version du schéma de la base de contenu gérée par cette application.
  static const int schemaVersion = 5;

  /// Copie (si besoin) puis ouvre la base dans [directory], et vérifie le
  /// texte coranique. Si la copie est altérée, elle est refaite une fois
  /// depuis les ressources de l'application ; si le contrôle échoue encore,
  /// lève [ContentIntegrityException].
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
      await _copy(assets, dbPath, versionFile, version);
    }
    try {
      return openVerified(dbPath);
    } on ContentIntegrityException {
      await _copy(assets, dbPath, versionFile, version);
      return openVerified(dbPath);
    }
  }

  static Future<void> _copy(
    AssetBundle assets,
    String dbPath,
    File versionFile,
    String version,
  ) async {
    final data = await assets.load(assetPath);
    final tmp = File('$dbPath.tmp');
    await tmp.writeAsBytes(
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
      flush: true,
    );
    await tmp.rename(dbPath);
    await versionFile.writeAsString(version, flush: true);
  }

  /// Ouvre en lecture seule et vérifie schéma et texte coranique.
  static ContentDatabase openVerified(String path) {
    final db = openFile(path);
    try {
      db.verify();
      return db;
    } catch (_) {
      db.close();
      rethrow;
    }
  }

  /// Lève [ContentIntegrityException] si la base n'est pas celle attendue.
  void verify() {
    final int version;
    final String digest;
    try {
      version = _db.select('PRAGMA user_version').first.columnAt(0) as int;
      if (version != schemaVersion) {
        throw ContentIntegrityException(
          'Base de contenu de schéma $version (attendu $schemaVersion).',
        );
      }
      digest = quranTextSha256(_db);
    } on ContentIntegrityException {
      rethrow;
    } on SqliteException catch (e) {
      throw ContentIntegrityException('Base de contenu illisible : $e');
    }
    if (digest != expectedQuranTextSha256) {
      throw const ContentIntegrityException(
        'Le texte coranique de la base de contenu ne correspond pas à '
        'celui de Tanzil (empreinte SHA-256 différente).',
      );
    }
  }

  /// Sources citées (texte, traduction, morphologie…).
  List<ContentSource> sources() => [
    for (final r in _db.select(
      'SELECT id, title, attribution, license, link, notes FROM source '
      'ORDER BY id',
    ))
      ContentSource(
        id: r['id'] as String,
        title: r['title'] as String,
        attribution: r['attribution'] as String,
        license: r['license'] as String,
        link: r['link'] as String,
        notes: r['notes'] as String?,
      ),
  ];

  /// Ouvre un fichier existant en lecture seule.
  static ContentDatabase openFile(String path) =>
      ContentDatabase._(sqlite3.open(path, mode: OpenMode.readOnly));

  /// Métadonnées (version du contenu, sources…).
  Map<String, String> meta() => {
    for (final row in _db.select('SELECT key, value FROM content_meta'))
      row['key'] as String: row['value'] as String,
  };

  String get contentVersion => meta()['content_version'] ?? 'inconnue';

  /// Notices de copyright d'origine, reproduites mot pour mot (conditions du
  /// Quranic Arabic Corpus et de la traduction), par identifiant de source.
  Map<String, String> sourceNotices() {
    final m = meta();
    return {
      for (final e in const {
        'qac-morphology': 'qac_header',
        'tanzil-fr-hamidullah': 'translation_header',
      }.entries)
        if (m[e.value] != null) e.key: m[e.value]!,
    };
  }

  void close() => _db.close();
}
