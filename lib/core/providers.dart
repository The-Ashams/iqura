/// Dépendances partagées, fournies au démarrage par `main.dart` (et
/// remplacées dans les tests).
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/content_db/content_database.dart';
import '../data/user_db/user_database.dart';
import 'app_paths.dart';

final appPathsProvider = Provider<AppPaths>(
  (ref) => throw UnimplementedError('appPathsProvider non fourni'),
);

final userDatabaseProvider = Provider<UserDatabase>(
  (ref) => throw UnimplementedError('userDatabaseProvider non fourni'),
);

final contentDatabaseProvider = Provider<ContentDatabase>(
  (ref) => throw UnimplementedError('contentDatabaseProvider non fourni'),
);
