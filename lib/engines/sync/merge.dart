/// Règles de fusion entre la base locale et une archive importée.
///
/// - Tables « dernière modification gagnante » : on garde la ligne dont la
///   date HLC est la plus récente. Une suppression est une ligne marquée
///   `deleted = 1`, elle gagne ou perd comme une modification.
/// - Journaux en ajout seul : union des lignes, sans jamais en retirer.
library;

import 'hlc.dart';
import 'table_def.dart';

enum MergeAction {
  /// La ligne n'existe pas localement : on l'ajoute.
  insert,

  /// La ligne importée est plus récente : elle remplace la ligne locale.
  replace,

  /// La ligne locale est aussi récente ou plus récente : on la garde.
  keepLocal,
}

/// Décide quoi faire d'une ligne importée d'une table
/// [SyncKind.lastWriterWins], connaissant la ligne locale (ou `null`).
MergeAction decideLastWriterWins(
  Map<String, Object?>? local,
  Map<String, Object?> incoming,
) {
  if (local == null) return MergeAction.insert;
  final localHlc = Hlc.parse(local[TableDef.hlcColumn]! as String);
  final incomingHlc = Hlc.parse(incoming[TableDef.hlcColumn]! as String);
  return incomingHlc.compareTo(localHlc) > 0
      ? MergeAction.replace
      : MergeAction.keepLocal;
}

/// Bilan d'une fusion, par table.
class MergeReport {
  final Map<String, TableMergeCount> tables = {};

  TableMergeCount table(String name) =>
      tables.putIfAbsent(name, TableMergeCount.new);

  int get inserted => tables.values.fold(0, (s, t) => s + t.inserted);
  int get replaced => tables.values.fold(0, (s, t) => s + t.replaced);
  int get kept => tables.values.fold(0, (s, t) => s + t.kept);
}

class TableMergeCount {
  int inserted = 0;
  int replaced = 0;
  int kept = 0;
}
