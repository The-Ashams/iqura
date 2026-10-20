import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../transfer/transfer_service.dart';
import 'backup_service.dart';

final backupServiceProvider = Provider<BackupService>(
  (ref) => BackupService(
    ref.watch(userDatabaseProvider),
    ref.watch(appPathsProvider).backupsDir,
  ),
);

final transferServiceProvider = Provider<TransferService>(
  (ref) => TransferService(
    ref.watch(userDatabaseProvider),
    ref.watch(backupServiceProvider),
  ),
);
