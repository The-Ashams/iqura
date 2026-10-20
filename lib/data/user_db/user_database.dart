/// Accès à `iqura_user.db` : ouverture, migrations, écritures datées (HLC),
/// sauvegarde, export, restauration complète et fusion.
library;

import 'dart:io';

import 'package:sqlite3/sqlite3.dart';
import 'package:uuid/uuid.dart';

import '../../engines/sync/export_archive.dart';
import '../../engines/sync/hlc.dart';
import '../../engines/sync/merge.dart';
import '../../engines/sync/table_def.dart';
import 'schema.dart';

class UserDatabase {
  UserDatabase._(this._db, this.deviceId, this._clock);

  final Database _db;

  /// Identifiant de cet appareil (UUID v7), créé à la première ouverture.
  final String deviceId;
  final HlcClock _clock;

  static const _deviceIdKey = 'device_id';
  static const _hlcKey = 'hlc_last';

  /// Ouvre (ou crée) la base au chemin [path]. `null` : base en mémoire
  /// (tests).
  static UserDatabase open(String? path, {int Function()? now}) {
    final db = path == null ? sqlite3.openInMemory() : sqlite3.open(path);
    try {
      db.execute('PRAGMA foreign_keys = ON');
      if (path != null) db.execute('PRAGMA journal_mode = WAL');
      migrate(db);
      var deviceId = _readMeta(db, _deviceIdKey);
      if (deviceId == null) {
        deviceId = const Uuid().v7();
        _writeMeta(db, _deviceIdKey, deviceId);
      }
      final lastText = _readMeta(db, _hlcKey);
      final last = lastText == null ? null : Hlc.parse(lastText);
      final clock = HlcClock(
        deviceId,
        last: last == null ? null : Hlc(last.millis, last.counter, deviceId),
        now: now,
      );
      return UserDatabase._(db, deviceId, clock);
    } catch (_) {
      db.close();
      rethrow;
    }
  }

  /// Applique les migrations manquantes. Refuse une base plus récente que
  /// l'application.
  static void migrate(Database db) {
    final version = db.select('PRAGMA user_version').first.columnAt(0) as int;
    if (version > userSchemaVersion) {
      throw StateError(
        'Base de progression créée par une version plus récente d’IQURA '
        '(schéma $version, cette version gère le schéma $userSchemaVersion).',
      );
    }
    for (var v = version; v < userSchemaVersion; v++) {
      db.execute('BEGIN');
      try {
        for (final sql in userMigrations[v]) {
          db.execute(sql);
        }
        db.execute('PRAGMA user_version = ${v + 1}');
        db.execute('COMMIT');
      } catch (_) {
        db.execute('ROLLBACK');
        rethrow;
      }
    }
  }

  static String? _readMeta(Database db, String key) {
    final rows = db.select('SELECT value FROM local_meta WHERE key = ?', [key]);
    return rows.isEmpty ? null : rows.first['value'] as String;
  }

  static void _writeMeta(Database db, String key, String value) {
    db.execute(
      'INSERT INTO local_meta (key, value) VALUES (?, ?) '
      'ON CONFLICT(key) DO UPDATE SET value = excluded.value',
      [key, value],
    );
  }

  void close() => _db.close();

  /// Lecture brute (requête paramétrée).
  List<Map<String, Object?>> select(
    String sql, [
    List<Object?> args = const [],
  ]) {
    return [
      for (final row in _db.select(sql, args)) Map<String, Object?>.of(row),
    ];
  }

  /// Exécute [action] dans une transaction.
  T transaction<T>(T Function() action) {
    _db.execute('BEGIN IMMEDIATE');
    try {
      final result = action();
      _db.execute('COMMIT');
      return result;
    } catch (_) {
      _db.execute('ROLLBACK');
      rethrow;
    }
  }

  void _persistClock() => _writeMeta(_db, _hlcKey, _clock.last.toString());

  /// Écrit (crée ou remplace) une ligne d'une table « dernière modification
  /// gagnante » en la datant.
  void upsert(TableDef table, Map<String, Object?> values) {
    assert(table.kind == SyncKind.lastWriterWins);
    transaction(() {
      final row = {
        ...values,
        TableDef.hlcColumn: _clock.tick().toString(),
        TableDef.deletedColumn: 0,
      };
      _insertOrReplace(table, row);
      _persistClock();
    });
  }

  /// Marque une ligne comme supprimée (le marqueur se propage à la fusion).
  void markDeleted(TableDef table, Object key) {
    assert(table.kind == SyncKind.lastWriterWins);
    transaction(() {
      _db.execute(
        'UPDATE ${table.name} SET ${TableDef.deletedColumn} = 1, '
        '${TableDef.hlcColumn} = ? WHERE ${table.primaryKey} = ?',
        [_clock.tick().toString(), key],
      );
      _persistClock();
    });
  }

  /// Ajoute une ligne à un journal en ajout seul. Ignorée si elle existe.
  void append(TableDef table, Map<String, Object?> row) {
    assert(table.kind == SyncKind.appendOnly);
    _insert(table, row, orIgnore: true);
  }

  void _insertOrReplace(TableDef table, Map<String, Object?> row) =>
      _insert(table, row, orReplace: true);

  void _insert(
    TableDef table,
    Map<String, Object?> row, {
    bool orReplace = false,
    bool orIgnore = false,
  }) {
    final cols = table.columnNames;
    final verb = orReplace
        ? 'INSERT OR REPLACE'
        : orIgnore
        ? 'INSERT OR IGNORE'
        : 'INSERT';
    _db.execute(
      '$verb INTO ${table.name} (${cols.join(', ')}) '
      'VALUES (${List.filled(cols.length, '?').join(', ')})',
      [for (final c in cols) row[c]],
    );
  }

  // ---------------------------------------------------------------------
  // Sauvegarde, export, import

  /// Copie cohérente de toute la base dans [path] (fichier absent).
  void backupTo(String path) {
    _db.execute('VACUUM INTO ?', [path]);
  }

  /// Toutes les lignes des tables exportées.
  ExportData exportData({required String appVersion, DateTime? now}) {
    return ExportData(
      manifest: ExportManifest(
        formatVersion: exportFormatVersion,
        schemaVersion: userSchemaVersion,
        appVersion: appVersion,
        createdAt: now ?? DateTime.now(),
        deviceId: deviceId,
      ),
      tables: {
        for (final t in userSchema.where((t) => t.exported))
          t.name: select(
            'SELECT ${t.columnNames.join(', ')} FROM ${t.name} '
            'ORDER BY ${t.primaryKey}',
          ),
      },
    );
  }

  /// Restauration complète : les tables exportées sont vidées puis
  /// remplacées par le contenu de l'archive.
  void replaceAll(ExportData data) {
    transaction(() {
      for (final t in userSchema.where((t) => t.exported)) {
        _db.execute('DELETE FROM ${t.name}');
        for (final row in data.tables[t.name] ?? const []) {
          _insert(t, row);
        }
      }
      _receiveAll(data);
      _persistClock();
    });
  }

  /// Fusion : journaux unis, autres tables par date de modification.
  MergeReport merge(ExportData data) {
    final report = MergeReport();
    transaction(() {
      for (final t in userSchema.where((t) => t.exported)) {
        final count = report.table(t.name);
        for (final row in data.tables[t.name] ?? const []) {
          switch (t.kind) {
            case SyncKind.appendOnly:
              _insert(t, row, orIgnore: true);
              if (_db.updatedRows > 0) {
                count.inserted++;
              } else {
                count.kept++;
              }
            case SyncKind.lastWriterWins:
              final local = select(
                'SELECT * FROM ${t.name} WHERE ${t.primaryKey} = ?',
                [row[t.primaryKey]],
              );
              switch (decideLastWriterWins(
                local.isEmpty ? null : local.first,
                row,
              )) {
                case MergeAction.insert:
                  _insert(t, row);
                  count.inserted++;
                case MergeAction.replace:
                  _insertOrReplace(t, row);
                  count.replaced++;
                case MergeAction.keepLocal:
                  count.kept++;
              }
            case SyncKind.localOnly:
              break;
          }
        }
      }
      _receiveAll(data);
      _persistClock();
    });
    return report;
  }

  /// Avance l'horloge au-delà de toutes les dates importées.
  void _receiveAll(ExportData data) {
    for (final t in userSchema.where(
      (t) => t.kind == SyncKind.lastWriterWins,
    )) {
      for (final row in data.tables[t.name] ?? const []) {
        _clock.receive(Hlc.parse(row[TableDef.hlcColumn]! as String));
      }
    }
  }

  /// Remplace le contenu des tables exportées par celui d'un fichier de
  /// sauvegarde. `local_meta` (identité de l'appareil, horloge) est conservée.
  void restoreFromBackupFile(String path) {
    if (!File(path).existsSync()) {
      throw StateError('Sauvegarde introuvable : $path');
    }
    // On travaille sur une copie migrée pour ne jamais modifier la
    // sauvegarde elle-même.
    final copy = '$path.restore-tmp';
    File(path).copySync(copy);
    try {
      final src = sqlite3.open(copy);
      try {
        migrate(src);
      } finally {
        src.close();
      }
      _db.execute('ATTACH DATABASE ? AS src', [copy]);
      try {
        transaction(() {
          for (final t in userSchema.where((t) => t.exported)) {
            final cols = t.columnNames.join(', ');
            _db.execute('DELETE FROM main.${t.name}');
            _db.execute(
              'INSERT INTO main.${t.name} ($cols) '
              'SELECT $cols FROM src.${t.name}',
            );
          }
          // L'horloge doit rester plus récente que tout ce qui est restauré.
          for (final t in userSchema.where(
            (t) => t.kind == SyncKind.lastWriterWins,
          )) {
            final rows = _db.select(
              'SELECT MAX(${TableDef.hlcColumn}) AS m FROM main.${t.name}',
            );
            final max = rows.first['m'] as String?;
            if (max != null) _clock.receive(Hlc.parse(max));
          }
          _persistClock();
        });
      } finally {
        _db.execute('DETACH DATABASE src');
      }
    } finally {
      for (final suffix in ['', '-wal', '-shm', '-journal']) {
        final f = File('$copy$suffix');
        if (f.existsSync()) f.deleteSync();
      }
    }
  }
}
