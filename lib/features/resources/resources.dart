/// Ressources du jeu (cahier v3 §8.6) et séries quotidiennes (§8.4).
///
/// Tout gain passe par un journal en ajout seul avec une clé unique : un
/// même gain n'est jamais compté deux fois, même après une fusion entre
/// appareils. Les ressources ne modifient jamais les révisions.
library;

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/providers.dart';
import '../../data/user_db/schema.dart';
import '../../data/user_db/user_database.dart';

enum Currency {
  xp('XP'),
  dinars('dinars'),
  pierres('pierres de savoir'),
  encre('encre de scribe');

  const Currency(this.label);
  final String label;
}

@immutable
class Wallet {
  const Wallet(this.amounts);

  final Map<Currency, int> amounts;

  int operator [](Currency c) => amounts[c] ?? 0;

  /// Niveau du héros : il faut 100 × n XP pour passer du niveau n au
  /// niveau n + 1 (100 XP pour le niveau 2, 300 pour le 3, 600 pour le 4…).
  int get level => levelForXp(this[Currency.xp]);
}

int levelForXp(int xp) {
  var level = 1;
  var need = 100;
  var left = xp;
  while (left >= need) {
    left -= need;
    level++;
    need = 100 * level;
  }
  return level;
}

/// XP totale pour atteindre [level].
int xpForLevel(int level) => 50 * level * (level - 1);

class ResourceRepository {
  ResourceRepository(this._db, {DateTime Function()? now})
    : _now = now ?? DateTime.now;

  final UserDatabase _db;
  final DateTime Function() _now;

  Wallet wallet() {
    final m = <Currency, int>{};
    for (final r in _db.select(
      'SELECT currency, SUM(amount) AS total FROM resource_ledger '
      'GROUP BY currency',
    )) {
      final c = Currency.values.where((c) => c.name == r['currency']);
      if (c.isNotEmpty) m[c.first] = (r['total'] as int?) ?? 0;
    }
    return Wallet(m);
  }

  /// Ajoute un gain. Ignoré (renvoie faux) si [key] a déjà été compté.
  bool grant(
    Currency c,
    int amount, {
    required String key,
    required String source,
  }) {
    if (amount <= 0) return false;
    final before = _db.select(
      'SELECT 1 FROM resource_ledger WHERE unique_key = ?',
      [key],
    ).isNotEmpty;
    if (before) return false;
    _db.append(resourceLedgerTable, {
      'id': const Uuid().v7(),
      'currency': c.name,
      'amount': amount,
      'created_at': _now().millisecondsSinceEpoch,
      'unique_key': key,
      'source': source,
    });
    return true;
  }

  /// Dépense plusieurs ressources d'un coup ; refusée (faux) si l'une manque.
  bool spend(Map<Currency, int> cost, {required String source}) {
    final w = wallet();
    if (cost.entries.any((e) => w[e.key] < e.value)) return false;
    _db.transaction(() {
      for (final e in cost.entries) {
        if (e.value <= 0) continue;
        _db.append(resourceLedgerTable, {
          'id': const Uuid().v7(),
          'currency': e.key.name,
          'amount': -e.value,
          'created_at': _now().millisecondsSinceEpoch,
          'unique_key': 'depense:${const Uuid().v7()}',
          'source': source,
        });
      }
    });
    return true;
  }

  // ---------------------------------------------------------------------
  // Séries quotidiennes

  static String dayId(DateTime t) {
    final l = t.toLocal();
    String two(int v) => v.toString().padLeft(2, '0');
    return '${l.year}-${two(l.month)}-${two(l.day)}';
  }

  /// Note une journée d'activité (leçon ou révision). Le premier jour actif
  /// de la journée rapporte la récompense de série. Renvoie les dinars
  /// gagnés (0 si la journée était déjà comptée).
  int recordActivity() {
    final now = _now();
    final id = dayId(now);
    final known = _db.select('SELECT 1 FROM activity_day WHERE id = ?', [
      id,
    ]).isNotEmpty;
    if (known) return 0;
    _db.append(activityDayTable, {
      'id': id,
      'created_at': now.millisecondsSinceEpoch,
    });
    final int reward = 5 + min<int>(streak(), 7);
    grant(
      Currency.dinars,
      reward,
      key: 'serie:$id',
      source: 'récompense de série',
    );
    return reward;
  }

  /// Série en cours : jours d'activité consécutifs, un jour de repos
  /// isolé ne la casse pas (cahier §8.4) ; deux jours sans activité, si.
  int streak() {
    final days = {
      for (final r in _db.select('SELECT id FROM activity_day')) r['id']!,
    };
    var day = DateTime(_now().year, _now().month, _now().day);
    // La série reste valable si aujourd'hui n'est pas encore joué.
    if (!days.contains(dayId(day))) day = day.subtract(const Duration(days: 1));
    var count = 0;
    var gap = 0;
    while (true) {
      if (days.contains(dayId(day))) {
        count++;
        gap = 0;
      } else {
        gap++;
        if (gap > 1) break;
      }
      day = day.subtract(const Duration(days: 1));
    }
    return count;
  }
}

final resourceRepositoryProvider = Provider<ResourceRepository>(
  (ref) => ResourceRepository(ref.watch(userDatabaseProvider)),
);

/// Ressources, relues après chaque gain ou dépense.
final walletProvider = NotifierProvider<WalletNotifier, Wallet>(
  WalletNotifier.new,
);

class WalletNotifier extends Notifier<Wallet> {
  @override
  Wallet build() => ref.watch(resourceRepositoryProvider).wallet();

  void refresh() => state = ref.read(resourceRepositoryProvider).wallet();
}

/// Gains fixés par le cahier (§8.6) et par les décisions du niveau
/// Débutant 1 (montants des combats, à équilibrer).
abstract final class Rewards {
  static const lessonFirstXp = 50;
  static const lessonReplayXp = 10;
  static const lessonFirstDinars = 20;
  static const lessonFirstInk = 1;
  static const reviewXp = 2;

  /// Rendement décroissant : une carte déjà très stable rapporte moins.
  static const easyReviewXp = 1;
  static const waveXp = 5;
  static const waveDinars = 2;
  static const guardianXp = 15;
  static const guardianDinars = 10;
}
