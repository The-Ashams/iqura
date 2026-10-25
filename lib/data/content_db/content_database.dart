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

import '../../game/equipment/equipment.dart';
import '../../game/lesson/lesson.dart';
import '../../game/vocab/word.dart';
import '../../game/world.dart';

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
  static const int schemaVersion = 9;

  /// Tables indispensables au jeu.
  static const requiredTables = [
    'content_meta',
    'source',
    'root',
    'lemma',
    'letter',
    'lesson',
    'word',
    'audio_clip',
    'region',
    'place',
    'character',
    'item',
  ];

  /// Copie (si besoin) puis ouvre la base dans [directory], et la vérifie
  /// (schéma, intégrité SQLite). Si la copie est altérée, elle est refaite une fois
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

  /// Ouvre en lecture seule et vérifie le schéma et l'intégrité.
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
    try {
      final version = _db.select('PRAGMA user_version').first.columnAt(0);
      if (version != schemaVersion) {
        throw ContentIntegrityException(
          'Base de contenu de schéma $version (attendu $schemaVersion).',
        );
      }
      final check = _db.select('PRAGMA quick_check').first.columnAt(0);
      if (check != 'ok') {
        throw ContentIntegrityException('Base de contenu altérée : $check');
      }
      final tables = {
        for (final r in _db.select(
          "SELECT name FROM sqlite_master WHERE type = 'table'",
        ))
          r['name'] as String,
      };
      final missing = requiredTables.where((t) => !tables.contains(t));
      if (missing.isNotEmpty) {
        throw ContentIntegrityException(
          'Base de contenu incomplète (tables absentes : ${missing.join(', ')}).',
        );
      }
    } on SqliteException catch (e) {
      throw ContentIntegrityException('Base de contenu illisible : $e');
    }
  }

  /// Sources citées (morphologie du Quranic Arabic Corpus…).
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
  /// Quranic Arabic Corpus), par identifiant de source.
  Map<String, String> sourceNotices() {
    final header = meta()['qac_header'];
    return {'qac-morphology': ?header};
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

  /// Tous les personnages, toutes régions confondues.
  List<GameCharacter> allCharacters() => [
    for (final region in regions()) ...characters(region.id),
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

  /// Tracé guidé d'une lettre (traits de points 0 à 100), s'il existe.
  List<List<Offset>>? letterTrace(String letter) {
    final rows = _db.select(
      'SELECT strokes_json FROM letter_trace WHERE letter = ?',
      [letter],
    );
    if (rows.isEmpty) return null;
    return [
      for (final stroke
          in jsonDecode(rows.first['strokes_json'] as String) as List)
        [
          for (final pt in stroke as List)
            Offset(
              ((pt as List)[0] as num).toDouble(),
              (pt[1] as num).toDouble(),
            ),
        ],
    ];
  }

  /// Objets de la boutique.
  List<Item> items() => [
    for (final r in _db.select('SELECT * FROM item ORDER BY price, id'))
      Item.fromRow(r),
  ];

  /// Leçons d'une étape, dans l'ordre.
  List<LessonSummary> lessons(int stage) => [
    for (final r in _db.select(
      'SELECT id, stage, ordinal, title, content FROM lesson WHERE stage = ? '
      'ORDER BY ordinal',
      [stage],
    ))
      LessonSummary(
        id: r['id'] as String,
        stage: r['stage'] as int,
        ordinal: r['ordinal'] as int,
        title: r['title'] as String,
        playable: const {
          2,
          3,
        }.contains((jsonDecode(r['content'] as String) as Map)['format']),
      ),
  ];

  /// Une leçon au format mini-donjon ; `null` si absente ou d'un autre
  /// format.
  Lesson? lesson(String id) {
    final rows = _db.select('SELECT content FROM lesson WHERE id = ?', [id]);
    if (rows.isEmpty) return null;
    return Lesson.fromJson(
      jsonDecode(rows.first['content'] as String) as Map<String, dynamic>,
    );
  }

  /// Fiches de mots (vocabulaire), dans l'ordre des leçons.
  List<Word> words() => [
    for (final r in _db.select(
      'SELECT w.*, l.occurrence_count AS occ, '
      'ro.letters AS root_letters FROM word w '
      'LEFT JOIN lemma l ON l.id = w.lemma_id '
      'LEFT JOIN root ro ON ro.id = w.root_id '
      'ORDER BY w.lesson_stage, w.lesson_ordinal, w.rowid',
    ))
      Word(
        id: r['id'] as String,
        arabic: r['ar'] as String,
        translit: r['translit'] as String,
        french: r['fr'] as String,
        nature: r['nature'] as String,
        gender: r['gender'] as String?,
        plural: r['plural'] as String?,
        past: r['past'] as String?,
        present: r['present'] as String?,
        lemmaId: r['lemma_id'] as String?,
        rootId: r['root_id'] as String?,
        rootLetters: r['root_letters'] as String?,
        occurrences: r['occ'] as int?,
        exampleArabic: r['example_ar'] as String?,
        exampleFrench: r['example_fr'] as String?,
        theme: r['theme'] as String?,
        remark: r['remark'] as String?,
        lessonId: r['lesson_id'] as String,
        lessonStage: r['lesson_stage'] as int,
        lessonOrdinal: r['lesson_ordinal'] as int,
        meaningSource: r['meaning_source'] as String,
        keys: (jsonDecode(r['keys_json'] as String) as List).cast<String>(),
      ),
  ];

  /// Nombre total d'occurrences lemmatisées du Quranic Arabic Corpus (base de
  /// l'indicateur « X % des mots du Coran », sans aucun texte).
  int lemmaOccurrencesTotal() =>
      _db.select('SELECT SUM(occurrence_count) AS n FROM lemma').first['n']
          as int;

  /// Fiche d'un mot par son identifiant.
  Word? word(String id) {
    for (final w in words()) {
      if (w.id == id) return w;
    }
    return null;
  }

  /// Fiche du mot touché dans une phrase (article et préfixes d'une lettre
  /// retirés), s'il est au vocabulaire.
  Word? wordForToken(String token) {
    final all = words();
    for (final k in keyCandidates(token)) {
      for (final w in all) {
        if (w.keys.contains(k)) return w;
      }
    }
    return null;
  }

  /// Fiche d'une lettre.
  LetterCard? letter(String letter) {
    for (final l in letters()) {
      if (l.letter == letter) return l;
    }
    return null;
  }

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
      if (content['format'] != 2) continue;
      final elements = content['elements'] as Map;
      for (final (kind, word) in [('syllabes', false), ('mots', true)]) {
        for (final item in (elements[kind] as List).cast<Map>()) {
          items.add(
            ReadingItem(
              arabic: item['ar'] as String,
              translit: item['translit'] as String,
              lessonOrdinal: r['ordinal'] as int,
              word: word,
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

  void close() => _db.close();
}
