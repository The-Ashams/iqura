/// L'Expédition (cahier v3 §8.3, §8.4, §8.5) : quelques vagues de brumes
/// d'oubli puis un gardien, nourris par les révisions dues. Les statistiques
/// du voyageur (niveau, équipement) changent le combat, jamais les
/// révisions : la note FSRS ne dépend que de la justesse et du temps.
library;

import 'dart:math';

import '../equipment/equipment.dart';

class Foe {
  Foe({required this.name, required this.maxHp, required this.guardian})
    : hp = maxHp;

  final String name;
  final int maxHp;
  final bool guardian;
  int hp;

  bool get defeated => hp <= 0;
}

/// Répartit [questions] entre au plus 3 vagues et un gardien : le gardien
/// reçoit environ un quart des questions (2 au moins), chaque vague 2 au
/// moins. Moins de 4 questions : un seul adversaire, le gardien.
List<int> splitQuestions(int questions) {
  if (questions < 4) return [questions];
  final guardian = max(2, questions ~/ 4);
  final rest = questions - guardian;
  final waves = min(3, rest ~/ 2);
  final shares = List.filled(waves, rest ~/ waves);
  for (var i = 0; i < rest % waves; i++) {
    shares[i]++;
  }
  return [...shares, guardian];
}

/// Un combat d'Expédition. Les points de vie des adversaires sont réglés
/// pour qu'ils tombent quand toutes leurs questions ont reçu une bonne
/// réponse (les coups critiques les font tomber plus tôt) : une session
/// sans repli vient donc à bout de tous les adversaires.
class ExpeditionFight {
  ExpeditionFight({
    required int questions,
    required this.hero,
    int overdue = 0,
    this.timer = true,
  }) : foeStrike = max<int>(2, 8 + min<int>(5, overdue ~/ 10) - hero.defense) {
    heroHp = hero.pv;
    final shares = splitQuestions(questions);
    for (final (i, n) in shares.indexed) {
      final guardian = i == shares.length - 1;
      foes.add(
        Foe(
          name: guardian
              ? 'Grande brume d\'oubli'
              : 'Brume d\'oubli (vague ${i + 1})',
          maxHp: n * hero.attaque,
          guardian: guardian,
        ),
      );
    }
  }

  /// Une réponse juste en moins de 3 s (plus la Concentration) est un
  /// coup critique.
  static const Duration criticalTime = Duration(seconds: 3);

  final Stats hero;

  /// Chronomètre désactivé : pas de coup critique.
  final bool timer;

  /// Dégâts d'une erreur : plus forts quand des révisions sont en retard
  /// (« L'Oubli »), réduits par la Défense, 2 au moins.
  final int foeStrike;
  late int heroHp;
  final List<Foe> foes = [];
  int correct = 0;
  int wrong = 0;

  Foe? get current {
    for (final f in foes) {
      if (!f.defeated) return f;
    }
    return null;
  }

  bool get won => current == null;
  bool get lost => heroHp <= 0;
  bool get over => won || lost;

  /// Les coups critiques peuvent vaincre tous les adversaires avant la
  /// fin des révisions : les dernières questions se jouent alors contre des
  /// « traces de brume », pour que chaque révision due soit faite.
  void addTraces(int questions) => foes.add(
    Foe(
      name: 'Traces de brume',
      maxHp: max(1, questions * hero.attaque),
      guardian: false,
    ),
  );

  bool isCritical(Duration time) =>
      timer && time < criticalTime + Duration(seconds: hero.concentration);

  /// Applique une réponse ; renvoie les dégâts infligés (à l'adversaire si
  /// juste, au voyageur sinon), et l'adversaire vaincu le cas échéant.
  ({int damage, bool critical, Foe? defeated}) answer({
    required bool right,
    required Duration time,
  }) {
    final foe = current;
    if (foe == null || lost) throw StateError('combat terminé');
    if (!right) {
      wrong++;
      heroHp = max(0, heroHp - foeStrike);
      return (damage: foeStrike, critical: false, defeated: null);
    }
    correct++;
    final critical = isCritical(time);
    final damage = critical
        ? (hero.attaque * (150 + hero.critique) / 100).round()
        : hero.attaque;
    foe.hp = max(0, foe.hp - damage);
    return (
      damage: damage,
      critical: critical,
      defeated: foe.defeated ? foe : null,
    );
  }
}
