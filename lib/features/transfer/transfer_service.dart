/// Export et import de la progression (archive ZIP versionnée).
library;

import 'dart:typed_data';

import '../../core/app_info.dart';
import '../../data/user_db/schema.dart';
import '../../data/user_db/user_database.dart';
import '../../engines/sync/export_archive.dart';
import '../../engines/sync/merge.dart';
import '../backup/backup_service.dart';

enum ImportMode {
  /// Remplace toute la progression par celle de l'archive.
  replace,

  /// Garde le plus récent de chaque côté et unit les journaux.
  merge,
}

class ImportResult {
  const ImportResult({required this.mode, required this.backup, this.report});

  final ImportMode mode;

  /// Sauvegarde faite juste avant l'import.
  final BackupInfo backup;

  /// Bilan (fusion uniquement).
  final MergeReport? report;
}

class TransferService {
  TransferService(this._db, this._backups, {DateTime Function()? now})
    : _now = now ?? DateTime.now;

  final UserDatabase _db;
  final BackupService _backups;
  final DateTime Function() _now;

  Uint8List buildExport() => encodeExportArchive(
    _db.exportData(appVersion: appVersion, now: _now()),
    userSchema,
  );

  String suggestedFileName() {
    final t = _now();
    String two(int v) => v.toString().padLeft(2, '0');
    return 'iqura-progression-${t.year}${two(t.month)}${two(t.day)}-'
        '${two(t.hour)}${two(t.minute)}.zip';
  }

  /// Lit et valide une archive sans rien modifier.
  /// Lève [ExportArchiveException] si elle est invalide.
  ExportData read(Uint8List bytes) => decodeExportArchive(
    bytes,
    userSchema,
    currentSchemaVersion: userSchemaVersion,
  );

  /// Applique une archive déjà validée, après une sauvegarde automatique.
  ImportResult apply(ExportData data, ImportMode mode) {
    final backup = _backups.create(BackupReason.beforeImport);
    switch (mode) {
      case ImportMode.replace:
        _db.replaceAll(data);
        return ImportResult(mode: mode, backup: backup);
      case ImportMode.merge:
        return ImportResult(
          mode: mode,
          backup: backup,
          report: _db.merge(data),
        );
    }
  }
}
