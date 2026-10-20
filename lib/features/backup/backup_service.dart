/// Sauvegardes locales de la base de progression (copies complètes de
/// `iqura_user.db` dans le dossier de l'application).
library;

import 'dart:io';

import 'package:path/path.dart' as p;

import '../../data/user_db/user_database.dart';

enum BackupReason {
  automatic('auto', 'Automatique (quotidienne)'),
  manual('manuelle', 'Manuelle'),
  beforeImport('avant-import', 'Avant un import'),
  beforeRestore('avant-restauration', 'Avant une restauration');

  const BackupReason(this.code, this.label);
  final String code;
  final String label;

  static BackupReason? fromCode(String code) {
    for (final r in values) {
      if (r.code == code) return r;
    }
    return null;
  }
}

class BackupInfo {
  const BackupInfo({
    required this.path,
    required this.createdAt,
    required this.reason,
    required this.sizeBytes,
    this.sequence = 1,
  });

  final String path;
  final DateTime createdAt;
  final BackupReason reason;
  final int sizeBytes;

  /// Numéro d'ordre quand plusieurs sauvegardes ont la même seconde.
  final int sequence;

  String get fileName => p.basename(path);
}

class BackupService {
  BackupService(
    this._db,
    this.directory, {
    this.keep = 15,
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now;

  final UserDatabase _db;
  final String directory;

  /// Nombre de sauvegardes conservées ; les plus anciennes sont effacées.
  final int keep;
  final DateTime Function() _now;

  static final RegExp _name = RegExp(
    r'^iqura_user-(\d{8})-(\d{6})(?:-(\d+))?-([a-z-]+)\.db$',
  );

  static String _two(int v) => v.toString().padLeft(2, '0');

  BackupInfo create(BackupReason reason) => _create(reason, prune: true);

  BackupInfo _create(BackupReason reason, {required bool prune}) {
    Directory(directory).createSync(recursive: true);
    final t = _now();
    final stamp =
        '${t.year}${_two(t.month)}${_two(t.day)}-'
        '${_two(t.hour)}${_two(t.minute)}${_two(t.second)}';
    var path = p.join(directory, 'iqura_user-$stamp-${reason.code}.db');
    for (var n = 2; File(path).existsSync(); n++) {
      path = p.join(directory, 'iqura_user-$stamp-$n-${reason.code}.db');
    }
    _db.backupTo(path);
    if (prune) _prune();
    return list().firstWhere((b) => b.path == path);
  }

  /// Sauvegardes existantes, la plus récente en premier.
  List<BackupInfo> list() {
    final dir = Directory(directory);
    if (!dir.existsSync()) return const [];
    final out = <BackupInfo>[];
    for (final f in dir.listSync().whereType<File>()) {
      final m = _name.firstMatch(p.basename(f.path));
      final reason = m == null ? null : BackupReason.fromCode(m[4]!);
      if (m == null || reason == null) continue;
      final d = m[1]!;
      final h = m[2]!;
      final created = DateTime(
        int.parse(d.substring(0, 4)),
        int.parse(d.substring(4, 6)),
        int.parse(d.substring(6, 8)),
        int.parse(h.substring(0, 2)),
        int.parse(h.substring(2, 4)),
        int.parse(h.substring(4, 6)),
      );
      out.add(
        BackupInfo(
          path: f.path,
          createdAt: created,
          reason: reason,
          sizeBytes: f.lengthSync(),
          sequence: m[3] == null ? 1 : int.parse(m[3]!),
        ),
      );
    }
    out.sort((a, b) {
      final byDate = b.createdAt.compareTo(a.createdAt);
      return byDate != 0 ? byDate : b.sequence.compareTo(a.sequence);
    });
    return out;
  }

  /// Crée la sauvegarde automatique du jour si elle n'existe pas encore.
  BackupInfo? dailyBackupIfNeeded() {
    final today = _now();
    final done = list().any(
      (b) =>
          b.reason == BackupReason.automatic &&
          b.createdAt.year == today.year &&
          b.createdAt.month == today.month &&
          b.createdAt.day == today.day,
    );
    return done ? null : create(BackupReason.automatic);
  }

  /// Restaure [backup] après avoir sauvegardé l'état actuel.
  /// Le tri des anciennes sauvegardes n'a lieu qu'après la restauration,
  /// pour ne jamais effacer celle qu'on est en train de restaurer.
  void restore(BackupInfo backup) {
    _create(BackupReason.beforeRestore, prune: false);
    _db.restoreFromBackupFile(backup.path);
    _prune();
  }

  void delete(BackupInfo backup) => File(backup.path).deleteSync();

  void _prune() {
    final all = list();
    for (final b in all.skip(keep)) {
      File(b.path).deleteSync();
    }
  }
}
