/// Profil du joueur (une seule ligne, voir `profileSingletonId`).
library;

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/user_db/schema.dart';
import '../../data/user_db/user_database.dart';

@immutable
class Profile {
  const Profile({required this.pseudo, required this.createdAt});

  final String pseudo;
  final DateTime createdAt;
}

/// Règles du pseudo : 2 à 24 caractères, sans espaces aux extrémités.
class PseudoRules {
  static const int minLength = 2;
  static const int maxLength = 24;

  /// Message d'erreur, ou `null` si le pseudo est valide.
  static String? validate(String raw) {
    final v = raw.trim();
    if (v.length < minLength) {
      return 'Au moins $minLength caractères.';
    }
    if (v.length > maxLength) {
      return 'Au plus $maxLength caractères.';
    }
    return null;
  }
}

class ProfileRepository {
  ProfileRepository(this._db, {DateTime Function()? now})
    : _now = now ?? DateTime.now;

  final UserDatabase _db;
  final DateTime Function() _now;

  Profile? load() {
    final rows = _db.select(
      'SELECT pseudo, created_at FROM profile WHERE id = ? AND deleted = 0',
      [profileSingletonId],
    );
    if (rows.isEmpty) return null;
    return Profile(
      pseudo: rows.first['pseudo'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        rows.first['created_at'] as int,
      ),
    );
  }

  /// Crée le profil ou change le pseudo (la date de création est gardée).
  Profile save(String pseudo) {
    final error = PseudoRules.validate(pseudo);
    if (error != null) throw ArgumentError(error);
    final createdAt = load()?.createdAt ?? _now();
    _db.upsert(profileTable, {
      'id': profileSingletonId,
      'pseudo': pseudo.trim(),
      'created_at': createdAt.millisecondsSinceEpoch,
    });
    return load()!;
  }
}

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepository(ref.watch(userDatabaseProvider)),
);

final profileProvider = NotifierProvider<ProfileNotifier, Profile?>(
  ProfileNotifier.new,
);

class ProfileNotifier extends Notifier<Profile?> {
  @override
  Profile? build() => ref.watch(profileRepositoryProvider).load();

  void save(String pseudo) =>
      state = ref.read(profileRepositoryProvider).save(pseudo);

  void reload() => state = ref.read(profileRepositoryProvider).load();
}
