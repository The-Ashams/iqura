/// Équipement et enchantement (cahier v3 §8.6). L'équipement change le
/// combat de l'Expédition, jamais l'apprentissage : il ne touche ni aux
/// questions, ni aux notes de révision, ni aux pierres de savoir, ni au
/// seuil des mini-boss des leçons.
library;

import 'dart:convert';
import 'dart:math';

/// Statistiques de combat.
class Stats {
  const Stats({
    this.pv = 0,
    this.attaque = 0,
    this.defense = 0,
    this.critique = 0,
    this.concentration = 0,
  });

  factory Stats.fromJson(Map<String, dynamic> j) => Stats(
    pv: (j['pv'] as int?) ?? 0,
    attaque: (j['attaque'] as int?) ?? 0,
    defense: (j['defense'] as int?) ?? 0,
    critique: (j['critique'] as int?) ?? 0,
    concentration: (j['concentration'] as int?) ?? 0,
  );

  /// Points de vie.
  final int pv;
  final int attaque;
  final int defense;

  /// Bonus de dégâts d'un coup critique, en pourcentage.
  final int critique;

  /// Secondes de plus pour qu'une réponse juste soit un coup critique.
  final int concentration;

  Stats operator +(Stats o) => Stats(
    pv: pv + o.pv,
    attaque: attaque + o.attaque,
    defense: defense + o.defense,
    critique: critique + o.critique,
    concentration: concentration + o.concentration,
  );

  /// Statistiques augmentées de [percent] %, arrondies au supérieur.
  Stats boosted(int percent) {
    int up(int v) => v == 0 ? 0 : (v * (100 + percent) / 100).ceil();
    return Stats(
      pv: up(pv),
      attaque: up(attaque),
      defense: up(defense),
      critique: up(critique),
      concentration: up(concentration),
    );
  }

  List<(String, int)> get entries => [
    ('PV', pv),
    ('Attaque', attaque),
    ('Défense', defense),
    ('Critique', critique),
    ('Concentration', concentration),
  ];
}

class ItemSet {
  const ItemSet({
    required this.id,
    required this.name,
    required this.pieces,
    required this.bonus,
  });

  final String id;
  final String name;
  final int pieces;
  final Stats bonus;
}

/// Un objet de la boutique (données de contenu).
class Item {
  const Item({
    required this.id,
    required this.name,
    required this.slot,
    required this.rarity,
    required this.price,
    required this.stats,
    required this.description,
    this.set,
  });

  factory Item.fromRow(Map<String, Object?> r) {
    final setJson = r['set_json'] as String?;
    ItemSet? set;
    if (setJson != null) {
      final s = jsonDecode(setJson) as Map<String, dynamic>;
      set = ItemSet(
        id: r['set_id']! as String,
        name: s['nom'] as String,
        pieces: s['pieces'] as int,
        bonus: Stats.fromJson(s['bonus'] as Map<String, dynamic>),
      );
    }
    return Item(
      id: r['id']! as String,
      name: r['name']! as String,
      slot: r['slot']! as String,
      rarity: r['rarity']! as String,
      price: r['price']! as int,
      stats: Stats.fromJson(
        jsonDecode(r['stats_json']! as String) as Map<String, dynamic>,
      ),
      description: r['description']! as String,
      set: set,
    );
  }

  final String id;
  final String name;
  final String slot;
  final String rarity;
  final int price;
  final Stats stats;
  final String description;
  final ItemSet? set;

  String get slotLabel => switch (slot) {
    'arme' => 'Arme',
    'armure' => 'Armure',
    'casque' => 'Casque',
    'cape' => 'Cape',
    'bouclier' => 'Bouclier',
    _ => 'Accessoire',
  };

  String get rarityLabel => switch (rarity) {
    'rare' => 'Rare',
    'epique' => 'Épique',
    'legendaire' => 'Légendaire',
    _ => 'Commun',
  };
}

/// Un objet possédé.
class OwnedItem {
  const OwnedItem({
    required this.id,
    required this.item,
    required this.level,
    required this.fails,
    required this.equipped,
  });

  final String id;
  final Item item;

  /// Niveau d'enchantement, de 0 à [Enchant.maxLevel].
  final int level;

  /// Échecs d'enchantement depuis la dernière réussite.
  final int fails;
  final bool equipped;

  Stats get stats => item.stats.boosted(Enchant.bonusPercent(level));

  /// Effet visuel : lueur à +5, aura colorée à +10, aura légendaire à +15.
  String? get glow => level >= 15
      ? 'aura légendaire'
      : level >= 10
      ? 'aura colorée'
      : level >= 5
      ? 'lueur'
      : null;
}

/// Règles de l'enchantement (cahier §8.6) : taux affichés avant chaque
/// tentative ; un échec ne détruit jamais l'objet ni ne fait perdre de
/// niveau ; chaque échec ajoute 5 points au taux suivant ; après un nombre
/// d'échecs (« pity »), la réussite est garantie.
abstract final class Enchant {
  static const int maxLevel = 15;

  /// Taux de base (en %) pour passer au niveau [target] (1 à 15) :
  /// +1 à +5 : 95 → 75 ; +6 à +10 : 60 → 40 ; +11 à +15 : 30 → 10.
  static int baseRate(int target) {
    if (target <= 5) return 95 - 5 * (target - 1);
    if (target <= 10) return 60 - 5 * (target - 6);
    return 30 - 5 * (target - 11);
  }

  /// Échecs après lesquels la tentative suivante réussit à coup sûr.
  static int pity(int target) => target <= 5
      ? 3
      : target <= 10
      ? 5
      : 8;

  /// Taux réel de la prochaine tentative, compte tenu des échecs.
  static int rate(int target, int fails) =>
      fails >= pity(target) ? 100 : min(100, baseRate(target) + 5 * fails);

  /// Bonus de statistiques total d'un objet au niveau [level] :
  /// +4 % par niveau de 1 à 5, +6 % de 6 à 10, +9 % de 11 à 15.
  static int bonusPercent(int level) {
    var b = 0;
    for (var l = 1; l <= level; l++) {
      b += l <= 5
          ? 4
          : l <= 10
          ? 6
          : 9;
    }
    return b;
  }

  /// Coût (valeurs initiales, à équilibrer) : dinars et pierres de savoir.
  static ({int dinars, int pierres}) cost(int target) =>
      (dinars: 10 * target, pierres: (target + 2) ~/ 3);

  /// Tire une tentative : [roll] entre 0 (inclus) et 100 (exclu).
  static bool succeeds(int target, int fails, double roll) =>
      roll < rate(target, fails);
}

/// Statistiques du voyageur : base, niveau, équipement porté et bonus
/// d'ensemble (3 pièces).
Stats heroStats(int level, List<OwnedItem> equipped) {
  var s = Stats(pv: 50 + 5 * (level - 1), attaque: 10 + (level - 1));
  final bySet = <String, ItemSet>{};
  final count = <String, int>{};
  for (final o in equipped) {
    s = s + o.stats;
    final set = o.item.set;
    if (set != null) {
      bySet[set.id] = set;
      count[set.id] = (count[set.id] ?? 0) + 1;
    }
  }
  for (final e in bySet.entries) {
    if (count[e.key]! >= e.value.pieces) s = s + e.value.bonus;
  }
  return s;
}
