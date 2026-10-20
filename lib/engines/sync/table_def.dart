/// Description d'une table de la base utilisateur, partagée par le schéma
/// SQLite, l'export, la validation des imports et la fusion.
library;

enum ColumnType { text, integer, real }

class ColumnDef {
  const ColumnDef(this.name, this.type, {this.nullable = false});

  final String name;
  final ColumnType type;
  final bool nullable;

  /// Vrai si [value] peut être stockée dans cette colonne.
  bool accepts(Object? value) {
    if (value == null) return nullable;
    return switch (type) {
      ColumnType.text => value is String,
      ColumnType.integer => value is int,
      ColumnType.real => value is num,
    };
  }

  String get sqlType => switch (type) {
    ColumnType.text => 'TEXT',
    ColumnType.integer => 'INTEGER',
    ColumnType.real => 'REAL',
  };
}

/// Comment une table est traitée à l'export et à la fusion.
enum SyncKind {
  /// Lignes modifiables : la version dont la date HLC est la plus récente
  /// l'emporte. Les suppressions sont des marqueurs (`deleted = 1`).
  lastWriterWins,

  /// Journal en ajout seul : union des lignes par identifiant.
  appendOnly,

  /// Propre à l'appareil : jamais exportée.
  localOnly,
}

class TableDef {
  const TableDef({
    required this.name,
    required this.kind,
    required this.primaryKey,
    required this.columns,
    this.uniqueColumns = const [],
  });

  final String name;
  final SyncKind kind;
  final String primaryKey;
  final List<ColumnDef> columns;

  /// Colonnes avec contrainte d'unicité (en plus de la clé primaire).
  final List<String> uniqueColumns;

  /// Colonne HLC d'une table [SyncKind.lastWriterWins].
  static const String hlcColumn = 'updated_hlc';

  /// Colonne marqueur de suppression d'une table [SyncKind.lastWriterWins].
  static const String deletedColumn = 'deleted';

  bool get exported => kind != SyncKind.localOnly;

  List<String> get columnNames => [for (final c in columns) c.name];

  ColumnDef? column(String name) {
    for (final c in columns) {
      if (c.name == name) return c;
    }
    return null;
  }
}
