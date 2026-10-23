/// Accès en lecture seule à `iqura_content.db`.
///
/// La base est livrée dans les ressources de l'application
/// (`assets/content/`), générée par `tools/build_content/`. Au démarrage,
/// elle est copiée dans le dossier de l'application si sa version a changé,
/// puis ouverte en lecture seule.
library;

import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

import '../../game/world.dart';
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
  static const int schemaVersion = 6;

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

  /// Régions du jeu, dans l'ordre.
  List<Region> regions() => [
    for (final r in _db.select('SELECT * FROM region ORDER BY number'))
      Region(
        id: r['id'] as String,
        number: r['number'] as int,
        name: r['name'] as String,
        skill: r['skill'] as String,
        adversary: r['adversary'] as String,
        mapImage: r['map_image'] as String,
      ),
  ];

  /// Lieux d'une région, dans l'ordre.
  List<Place> places(String regionId) => [
    for (final r in _db.select(
      'SELECT * FROM place WHERE region_id = ? ORDER BY number',
      [regionId],
    ))
      Place(
        id: r['id'] as String,
        regionId: r['region_id'] as String,
        number: r['number'] as int,
        name: r['name'] as String,
        description: r['description'] as String,
        mapX: r['map_x'] as int,
        mapY: r['map_y'] as int,
        sceneImage: r['scene_image'] as String?,
        groundY: r['ground_y'] as int?,
        inVerticalSlice: r['in_j1a'] == 1,
        lessons: (jsonDecode(r['lessons_json'] as String) as List).cast<int>(),
        links: (jsonDecode(r['links_json'] as String) as List).cast<String>(),
      ),
  ];

  /// Personnages d'une région.
  List<GameCharacter> characters(String regionId) => [
    for (final r in _db.select(
      'SELECT * FROM character WHERE region_id = ? ORDER BY rowid',
      [regionId],
    ))
      GameCharacter(
        id: r['id'] as String,
        name: r['name'] as String,
        nameAr: r['name_ar'] as String,
        role: r['role'] as String,
        sprite: r['sprite'] as String?,
        places: (jsonDecode(r['places_json'] as String) as List).cast<String>(),
      ),
  ];

  /// Fiches des lettres déjà rédigées, dans l'ordre des leçons.
  List<LetterCard> letters() => [
    for (final r in _db.select(
      'SELECT l.*, z.description AS zone FROM letter l '
      'JOIN articulation_zone z ON z.id = l.zone_id ORDER BY l.rowid',
    ))
      LetterCard(
        letter: r['letter'] as String,
        name: r['name'] as String,
        nameAr: r['name_ar'] as String,
        joinsLeft: r['joins_left'] == 1,
        zone: r['zone'] as String,
        pronunciation: r['pronunciation'] as String,
      ),
  ];

  /// Syllabes et mots à lire des leçons d'une étape, jusqu'à la leçon
  /// [upTo] comprise.
  List<ReadingItem> readingItems({required int stage, required int upTo}) {
    final items = <ReadingItem>[];
    for (final r in _db.select(
      'SELECT ordinal, content FROM lesson WHERE stage = ? AND ordinal <= ? '
      'ORDER BY ordinal',
      [stage, upTo],
    )) {
      final content = jsonDecode(r['content'] as String) as Map;
      for (final section in content['sections'] as List) {
        if (section['type'] != 'syllabes' && section['type'] != 'exemples') {
          continue;
        }
        for (final item in section['items'] as List) {
          items.add(
            ReadingItem(
              arabic: item['ar'] as String,
              translit: item['translit'] as String,
              lessonOrdinal: r['ordinal'] as int,
            ),
          );
        }
      }
    }
    return items;
  }

  /// Fichier audio (chemin sous `assets/`) d'un texte des leçons, s'il existe.
  String? audioFile(String arabic) {
    final rows = _db.select(
      'SELECT file FROM audio_clip WHERE text = ? AND file IS NOT NULL',
      [arabic],
    );
    return rows.isEmpty ? null : rows.first['file'] as String;
  }

  /// Versets d'une sourate (texte Tanzil vérifié et traduction Hamidullah).
  List<VerseText> surahVerses(int surah) => [
    for (final r in _db.select(
      'SELECT v.surah_id, v.ayah, v.text_uthmani, t.text FROM verse v '
      'JOIN verse_translation t ON t.verse_id = v.id '
      'WHERE v.surah_id = ? ORDER BY v.ayah',
      [surah],
    ))
      VerseText(
        surah: r['surah_id'] as int,
        ayah: r['ayah'] as int,
        arabic: r['text_uthmani'] as String,
        translation: r['text'] as String,
      ),
  ];

  void close() => _db.close();
}
