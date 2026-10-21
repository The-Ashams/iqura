import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/app_paths.dart';
import 'core/licenses.dart';
import 'core/providers.dart';
import 'data/content_db/content_database.dart';
import 'data/user_db/user_database.dart';
import 'features/backup/backup_service.dart';
import 'features/profile/profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  registerBundledLicenses();
  try {
    final paths = await AppPaths.resolve();
    final content = await ContentDatabase.install(paths.contentDir);
    final userDb = UserDatabase.open(paths.userDatabase);

    // Sauvegarde automatique quotidienne (une fois le profil créé).
    if (ProfileRepository(userDb).load() != null) {
      try {
        BackupService(userDb, paths.backupsDir).dailyBackupIfNeeded();
      } catch (e) {
        debugPrint('Sauvegarde automatique impossible : $e');
      }
    }

    runApp(
      ProviderScope(
        overrides: [
          appPathsProvider.overrideWithValue(paths),
          userDatabaseProvider.overrideWithValue(userDb),
          contentDatabaseProvider.overrideWithValue(content),
        ],
        child: const IquraApp(),
      ),
    );
  } catch (e) {
    runApp(StartupErrorApp(error: e));
  }
}
