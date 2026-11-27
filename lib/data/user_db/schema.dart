/// Schéma de `iqura_user.db` (progression de l'utilisateur).
///
/// Les tables des phases suivantes (SRS, RPG, listes…) seront ajoutées par
/// migration en augmentant [userSchemaVersion].
library;

import '../../engines/sync/table_def.dart';

/// Version du schéma (stockée dans `PRAGMA user_version`).
const int userSchemaVersion = 3;

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

/// Cartes de révision (schéma 3) : une ligne par carte, état FSRS en JSON.
/// `best_level` (0 en apprentissage, 1 reconnu, 2 maîtrisé) ne baisse
/// jamais : il sert à n'attribuer qu'une fois les pierres de savoir.
const cardTable = TableDef(
  name: 'card',
  kind: SyncKind.lastWriterWins,
  primaryKey: 'id',
  sinceSchema: 3,
  columns: [
    ColumnDef('id', ColumnType.text),
    ColumnDef('lesson_id', ColumnType.text),
    ColumnDef('kind', ColumnType.text),
    ColumnDef('target', ColumnType.text),
    ColumnDef('fsrs', ColumnType.text),
    ColumnDef('due', ColumnType.integer),
    ColumnDef('best_level', ColumnType.integer),
    ColumnDef('created_at', ColumnType.integer),
    _hlc,
    _deleted,
  ],
);

/// Ressources du jeu (schéma 3) : XP, dinars, pierres de savoir, encre de
/// scribe. Journal en ajout seul ; `unique_key` empêche de compter deux
/// fois le même gain (après une fusion par exemple). Une dépense est une
/// ligne négative.
const resourceLedgerTable = TableDef(
  name: 'resource_ledger',
  kind: SyncKind.appendOnly,
  primaryKey: 'id',
  uniqueColumns: ['unique_key'],
  sinceSchema: 3,
  columns: [
    ColumnDef('id', ColumnType.text),
    ColumnDef('currency', ColumnType.text),
    ColumnDef('amount', ColumnType.integer),
    ColumnDef('created_at', ColumnType.integer),
    ColumnDef('unique_key', ColumnType.text),
    ColumnDef('source', ColumnType.text),
  ],
);

/// Objets possédés (schéma 3) : niveau d'enchantement, échecs depuis la
/// dernière réussite (garantie « pity »), équipé ou non.
const inventoryTable = TableDef(
  name: 'inventory',
  kind: SyncKind.lastWriterWins,
  primaryKey: 'id',
  sinceSchema: 3,
  columns: [
    ColumnDef('id', ColumnType.text),
    ColumnDef('item_id', ColumnType.text),
    ColumnDef('level', ColumnType.integer),
    ColumnDef('fails', ColumnType.integer),
    ColumnDef('equipped', ColumnType.integer),
    ColumnDef('acquired_at', ColumnType.integer),
    _hlc,
    _deleted,
  ],
);

/// Jours d'activité (schéma 3), pour les séries : une ligne par jour
/// (identifiant AAAA-MM-JJ, heure locale).
const activityDayTable = TableDef(
  name: 'activity_day',
  kind: SyncKind.appendOnly,
  primaryKey: 'id',
  sinceSchema: 3,
  columns: [
    ColumnDef('id', ColumnType.text),
    ColumnDef('created_at', ColumnType.integer),
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
  cardTable,
  resourceLedgerTable,
  inventoryTable,
  activityDayTable,
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
  // 2 → 3
  [
    'CREATE TABLE card (id TEXT NOT NULL PRIMARY KEY, '
        'lesson_id TEXT NOT NULL, kind TEXT NOT NULL, target TEXT NOT NULL, '
        'fsrs TEXT NOT NULL, due INTEGER NOT NULL, '
        'best_level INTEGER NOT NULL, created_at INTEGER NOT NULL, '
        'updated_hlc TEXT NOT NULL, deleted INTEGER NOT NULL) STRICT',
    'CREATE INDEX card_due ON card(due)',
    'CREATE TABLE resource_ledger (id TEXT NOT NULL PRIMARY KEY, '
        'currency TEXT NOT NULL, amount INTEGER NOT NULL, '
        'created_at INTEGER NOT NULL, unique_key TEXT NOT NULL UNIQUE, '
        'source TEXT NOT NULL) STRICT',
    'CREATE TABLE inventory (id TEXT NOT NULL PRIMARY KEY, '
        'item_id TEXT NOT NULL, level INTEGER NOT NULL, '
        'fails INTEGER NOT NULL, equipped INTEGER NOT NULL, '
        'acquired_at INTEGER NOT NULL, updated_hlc TEXT NOT NULL, '
        'deleted INTEGER NOT NULL) STRICT',
    'CREATE TABLE activity_day (id TEXT NOT NULL PRIMARY KEY, '
        'created_at INTEGER NOT NULL) STRICT',
  ],
];
