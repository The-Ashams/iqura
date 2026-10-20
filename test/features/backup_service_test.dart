import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:iqura/data/user_db/user_database.dart';
import 'package:iqura/features/backup/backup_service.dart';
import 'package:iqura/features/profile/profile.dart';
import 'package:iqura/features/transfer/transfer_service.dart';
import 'package:iqura/engines/sync/export_archive.dart';

void main() {
  late Directory dir;
  late UserDatabase db;
  late DateTime now;
  late BackupService backups;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('iqura-backup');
    db = UserDatabase.open('${dir.path}/u.db');
    now = DateTime(2026, 10, 20, 9, 30, 0);
    backups = BackupService(
      db,
      '${dir.path}/sauvegardes',
      keep: 3,
      now: () => now,
    );
  });

  tearDown(() {
    db.close();
    dir.deleteSync(recursive: true);
  });

  test('création et liste, la plus récente en premier', () {
    backups.create(BackupReason.manual);
    now = now.add(const Duration(minutes: 1));
    backups.create(BackupReason.beforeImport);
    final list = backups.list();
    expect(list.map((b) => b.reason), [
      BackupReason.beforeImport,
      BackupReason.manual,
    ]);
  });

  test('deux sauvegardes dans la même seconde ne se remplacent pas', () {
    final a = backups.create(BackupReason.manual);
    final b = backups.create(BackupReason.manual);
    expect(a.path, isNot(b.path));
    expect(backups.list().first.path, b.path);
  });

  test('ne garde que les plus récentes', () {
    for (var i = 0; i < 5; i++) {
      now = now.add(const Duration(minutes: 1));
      backups.create(BackupReason.manual);
    }
    expect(backups.list(), hasLength(3));
  });

  test('une seule sauvegarde automatique par jour', () {
    expect(backups.dailyBackupIfNeeded(), isNotNull);
    now = now.add(const Duration(hours: 2));
    expect(backups.dailyBackupIfNeeded(), isNull);
    now = now.add(const Duration(days: 1));
    expect(backups.dailyBackupIfNeeded(), isNotNull);
  });

  test('restaurer la plus ancienne ne l’efface pas avant usage', () {
    final profiles = ProfileRepository(db);
    profiles.save('Ancien');
    final oldest = backups.create(BackupReason.manual);
    for (var i = 0; i < 2; i++) {
      now = now.add(const Duration(minutes: 1));
      backups.create(BackupReason.manual);
    }
    profiles.save('Nouveau');
    now = now.add(const Duration(minutes: 1));
    backups.restore(oldest);
    expect(profiles.load()!.pseudo, 'Ancien');
    final reasons = backups.list().map((b) => b.reason).toList();
    expect(reasons.first, BackupReason.beforeRestore);
    expect(reasons, hasLength(3));
  });

  test('un import fait toujours une sauvegarde avant', () {
    final profiles = ProfileRepository(db);
    profiles.save('Local');
    final transfer = TransferService(db, backups, now: () => now);
    final archive = transfer.buildExport();
    profiles.save('Modifié');
    final data = transfer.read(archive);
    expect(data.manifest.formatVersion, exportFormatVersion);
    final result = transfer.apply(data, ImportMode.replace);
    expect(result.backup.reason, BackupReason.beforeImport);
    expect(profiles.load()!.pseudo, 'Local');
    expect(File(result.backup.path).existsSync(), isTrue);
  });
}
