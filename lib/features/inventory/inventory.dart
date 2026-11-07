/// Objets possédés : achat, équipement, enchantement (cahier v3 §8.6).
library;

import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/providers.dart';
import '../../data/content_db/content_database.dart';
import '../../data/user_db/schema.dart';
import '../../data/user_db/user_database.dart';
import '../../game/equipment/equipment.dart';
import '../resources/resources.dart';

/// Résultat d'une tentative d'enchantement.
enum EnchantOutcome { success, failure, notEnough, maxed }

class InventoryRepository {
  InventoryRepository(
    this._db,
    this._content,
    this._resources, {
    Random? random,
    DateTime Function()? now,
  }) : _random = random ?? Random(),
       _now = now ?? DateTime.now;

  final UserDatabase _db;
  final ContentDatabase _content;
  final ResourceRepository _resources;
  final Random _random;
  final DateTime Function() _now;

  List<OwnedItem> owned() {
    final items = {for (final i in _content.items()) i.id: i};
    return [
      for (final r in _db.select(
        'SELECT * FROM inventory WHERE deleted = 0 ORDER BY acquired_at, id',
      ))
        if (items[r['item_id']] case final item?)
          OwnedItem(
            id: r['id']! as String,
            item: item,
            level: r['level']! as int,
            fails: r['fails']! as int,
            equipped: r['equipped'] == 1,
          ),
    ];
  }

  List<OwnedItem> equipped() => [
    for (final o in owned())
      if (o.equipped) o,
  ];

  void _save(OwnedItem o, {int? level, int? fails, bool? equipped}) {
    final acquired = _db.select(
      'SELECT acquired_at FROM inventory WHERE id = ?',
      [o.id],
    );
    _db.upsert(inventoryTable, {
      'id': o.id,
      'item_id': o.item.id,
      'level': level ?? o.level,
      'fails': fails ?? o.fails,
      'equipped': (equipped ?? o.equipped) ? 1 : 0,
      'acquired_at': acquired.isEmpty
          ? _now().millisecondsSinceEpoch
          : acquired.first['acquired_at'],
    });
  }

  /// Achète un objet ; faux si les dinars manquent.
  bool buy(Item item) {
    if (!_resources.spend({
      Currency.dinars: item.price,
    }, source: 'achat ${item.id}')) {
      return false;
    }
    _db.upsert(inventoryTable, {
      'id': const Uuid().v7(),
      'item_id': item.id,
      'level': 0,
      'fails': 0,
      'equipped': 0,
      'acquired_at': _now().millisecondsSinceEpoch,
    });
    return true;
  }

  /// Équipe un objet (et retire celui qui occupait le même emplacement).
  void equip(OwnedItem o) {
    for (final other in owned()) {
      if (other.equipped &&
          other.item.slot == o.item.slot &&
          other.id != o.id) {
        _save(other, equipped: false);
      }
    }
    _save(o, equipped: true);
  }

  void unequip(OwnedItem o) => _save(o, equipped: false);

  /// Tente d'enchanter [o] au niveau suivant. Le coût est payé à chaque
  /// tentative ; un échec ne détruit rien et ne fait rien perdre.
  EnchantOutcome enchant(OwnedItem o) {
    if (o.level >= Enchant.maxLevel) return EnchantOutcome.maxed;
    final target = o.level + 1;
    final cost = Enchant.cost(target);
    if (!_resources.spend({
      Currency.dinars: cost.dinars,
      Currency.pierres: cost.pierres,
    }, source: 'enchantement ${o.item.id} +$target')) {
      return EnchantOutcome.notEnough;
    }
    final ok = Enchant.succeeds(target, o.fails, _random.nextDouble() * 100);
    _save(o, level: ok ? target : o.level, fails: ok ? 0 : o.fails + 1);
    return ok ? EnchantOutcome.success : EnchantOutcome.failure;
  }
}

final inventoryRepositoryProvider = Provider<InventoryRepository>(
  (ref) => InventoryRepository(
    ref.watch(userDatabaseProvider),
    ref.watch(contentDatabaseProvider),
    ref.watch(resourceRepositoryProvider),
  ),
);

final inventoryProvider = NotifierProvider<InventoryNotifier, List<OwnedItem>>(
  InventoryNotifier.new,
);

class InventoryNotifier extends Notifier<List<OwnedItem>> {
  @override
  List<OwnedItem> build() => ref.watch(inventoryRepositoryProvider).owned();

  void refresh() => state = ref.read(inventoryRepositoryProvider).owned();
}
