/// Schéma de `iqura_user.db` (progression de l'utilisateur).
///
/// Les tables des phases suivantes (SRS, RPG, listes…) seront ajoutées par
/// migration en augmentant [userSchemaVersion].
library;

import '../../engines/sync/table_def.dart';

/// Version du schéma (stockée dans `PRAGMA user_version`).
const int userSchemaVersion = 2;

const _hlc = ColumnDef(TableDef.hlcColumn, ColumnType.text);
const _deleted = ColumnDef(TableDef.deletedColumn, ColumnType.integer);

/// Profil du joueur. Une seule ligne, d'identifiant [profileSingletonId],
/// pour que deux appareils fusionnent le même profil au lieu d'en créer deux.
const profileTable = TableDef(
  name: 'profile',
  kind: SyncKind.lastWriterWins,
  primaryKey: 'id',
  columns: [
    ColumnDef('id', ColumnType.text),
    ColumnDef('pseudo', ColumnType.text),
    ColumnDef('created_at', ColumnType.integer),
    _hlc,
    _deleted,
  ],
);

const String profileSingletonId = 'main';

/// Réglages, une ligne par clé ; valeur encodée en JSON.
const settingsTable = TableDef(
  name: 'settings',
  kind: SyncKind.lastWriterWins,
  primaryKey: 'key',
  columns: [
    ColumnDef('key', ColumnType.text),
    ColumnDef('value', ColumnType.text),
    _hlc,
    _deleted,
  ],
);

/// Journal des révisions (rempli à partir de la phase 4). Ajout seul.
const reviewLogTable = TableDef(
  name: 'review_log',
  kind: SyncKind.appendOnly,
  primaryKey: 'id',
  columns: [
    ColumnDef('id', ColumnType.text),
    ColumnDef('card_id', ColumnType.text),
    ColumnDef('rating', ColumnType.integer),
    ColumnDef('reviewed_at', ColumnType.integer),
    ColumnDef('duration_ms', ColumnType.integer),
    ColumnDef('origin', ColumnType.text, nullable: true),
  ],
);

/// Journal de l'expérience (rempli à partir de la phase 6). Ajout seul ;
/// `unique_key` empêche de compter deux fois le même gain.
const xpLedgerTable = TableDef(
  name: 'xp_ledger',
  kind: SyncKind.appendOnly,
  primaryKey: 'id',
  uniqueColumns: ['unique_key'],
  columns: [
    ColumnDef('id', ColumnType.text),
    ColumnDef('source', ColumnType.text),
    ColumnDef('amount', ColumnType.integer),
    ColumnDef('created_at', ColumnType.integer),
    ColumnDef('unique_key', ColumnType.text),
  ],
);

/// Progression dans les leçons (mini-donjons), une ligne par leçon
/// (schéma 2). La progression est sauvegardée à chaque écran (cahier v3 §6.2).
const lessonProgressTable = TableDef(
  name: 'lesson_progress',
  kind: SyncKind.lastWriterWins,
  primaryKey: 'lesson_id',
  sinceSchema: 2,
  columns: [
    ColumnDef('lesson_id', ColumnType.text),
    // Écran où reprendre (indice dans la leçon).
    ColumnDef('step', ColumnType.integer),
    // Date de la première réussite du mini-boss (millisecondes), sinon nul.
    ColumnDef('completed_at', ColumnType.integer, nullable: true),
    // Meilleur score au mini-boss (bonnes réponses), et échecs depuis la
    // dernière réussite (après deux, la salle d'entraînement est proposée).
    ColumnDef('best_score', ColumnType.integer),
    ColumnDef('boss_failures', ColumnType.integer),
    _hlc,
    _deleted,
  ],
);

/// Données propres à l'appareil (identifiant, horloge). Jamais exportée.
const localMetaTable = TableDef(
  name: 'local_meta',
  kind: SyncKind.localOnly,
  primaryKey: 'key',
  columns: [
    ColumnDef('key', ColumnType.text),
    ColumnDef('value', ColumnType.text),
  ],
);

const List<TableDef> userSchema = [
  profileTable,
  settingsTable,
  reviewLogTable,
  xpLedgerTable,
  lessonProgressTable,
  localMetaTable,
];

/// Migrations : l'élément `i` fait passer le schéma de la version `i` à
/// `i + 1`. Une migration publiée ne se modifie jamais : on en ajoute une.
/// Un test vérifie que la base obtenue correspond à [userSchema].
const List<List<String>> userMigrations = [
  // 0 → 1
  [
    'CREATE TABLE profile (id TEXT NOT NULL PRIMARY KEY, pseudo TEXT NOT NULL, '
        'created_at INTEGER NOT NULL, updated_hlc TEXT NOT NULL, '
        'deleted INTEGER NOT NULL) STRICT',
    'CREATE TABLE settings (key TEXT NOT NULL PRIMARY KEY, '
        'value TEXT NOT NULL, updated_hlc TEXT NOT NULL, '
        'deleted INTEGER NOT NULL) STRICT',
    'CREATE TABLE review_log (id TEXT NOT NULL PRIMARY KEY, '
        'card_id TEXT NOT NULL, rating INTEGER NOT NULL, '
        'reviewed_at INTEGER NOT NULL, duration_ms INTEGER NOT NULL, '
        'origin TEXT) STRICT',
    'CREATE TABLE xp_ledger (id TEXT NOT NULL PRIMARY KEY, '
        'source TEXT NOT NULL, amount INTEGER NOT NULL, '
        'created_at INTEGER NOT NULL, unique_key TEXT NOT NULL UNIQUE) STRICT',
    'CREATE TABLE local_meta (key TEXT NOT NULL PRIMARY KEY, '
        'value TEXT NOT NULL) STRICT',
  ],
  // 1 → 2
  [
    'CREATE TABLE lesson_progress (lesson_id TEXT NOT NULL PRIMARY KEY, '
        'step INTEGER NOT NULL, completed_at INTEGER, '
        'best_score INTEGER NOT NULL, boss_failures INTEGER NOT NULL, '
        'updated_hlc TEXT NOT NULL, deleted INTEGER NOT NULL) STRICT',
  ],
];
