/// Emplacements des fichiers de l'application sur l'appareil.
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class AppPaths {
  const AppPaths(this.root);

  /// Dossier privé de l'application.
  final String root;

  String get userDatabase => p.join(root, 'iqura_user.db');
  String get backupsDir => p.join(root, 'sauvegardes');
  String get contentDir => p.join(root, 'contenu');

  /// Signalements d'erreur, gardés sur l'appareil (non exportés).
  String get errorReports => p.join(root, 'signalements.jsonl');

  /// Enregistrements de la voix du joueur (« répéter à voix haute ») :
  /// le dernier par élément, sur l'appareil seulement, jamais exportés.
  String get recordingsDir => p.join(root, 'enregistrements');

  static Future<AppPaths> resolve() async {
    final dir = await getApplicationSupportDirectory();
    final paths = AppPaths(dir.path);
    for (final d in [paths.root, paths.backupsDir, paths.contentDir]) {
      Directory(d).createSync(recursive: true);
    }
    return paths;
  }
}
