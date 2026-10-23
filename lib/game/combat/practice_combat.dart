/// Combat d'entraînement de la Faille des Oubliés (coquille du jalon J1a).
///
/// Les questions portent uniquement sur les syllabes et les mots construits
/// des leçons (jamais un verset ni un extrait coranique, cahier v3 §3.1).
/// Tant que la révision FSRS n'est pas branchée (étape 6), rien n'est
/// enregistré : c'est un entraînement.
library;

import 'dart:math';

import '../world.dart';

class PracticeQuestion {
  const PracticeQuestion({
    required this.target,
    required this.choices,
    required this.answer,
  });

  final ReadingItem target;

  /// Translittérations proposées (3 ou 4, toutes différentes).
  final List<String> choices;
  final int answer;

  /// Explication affichée après une erreur, tirée des données de la leçon.
  String get explanation =>
      '« ${target.arabic} » se lit « ${target.translit} ».';
}

/// Construit une question « Comment se lit… ? » : 4 choix si possible, 3 au
/// moins ; jamais deux bonnes réponses (translittérations toutes distinctes).
PracticeQuestion buildQuestion(List<ReadingItem> items, Random random) {
  final distinct = <String, ReadingItem>{};
  for (final i in items) {
    distinct.putIfAbsent(i.translit, () => i);
  }
  if (distinct.length < 3) {
    throw StateError('pas assez de lectures différentes pour une question');
  }
  final pool = distinct.values.toList();
  final target = pool[random.nextInt(pool.length)];
  // Distracteurs plausibles : d'abord la même leçon et la même longueur.
  int closeness(ReadingItem i) =>
      (i.lessonOrdinal == target.lessonOrdinal ? 0 : 2) +
      ((i.translit.length - target.translit.length).abs() <= 1 ? 0 : 1);
  final others = pool.where((i) => i.translit != target.translit).toList()
    ..shuffle(random)
    ..sort((a, b) => closeness(a).compareTo(closeness(b)));
  final choices = [
    target.translit,
    for (final i in others.take(min(3, others.length))) i.translit,
  ]..shuffle(random);
  return PracticeQuestion(
    target: target,
    choices: choices,
    answer: choices.indexOf(target.translit),
  );
}

enum CombatOutcome { ongoing, victory, retreat }

/// Points de vie et dégâts. Une réponse juste en moins de 3 s est un coup
/// critique (cahier v3 §6.3 et §8.5).
class PracticeCombat {
  PracticeCombat({this.heroMaxHp = 50, this.foeMaxHp = 60})
    : heroHp = heroMaxHp,
      foeHp = foeMaxHp;

  static const int hit = 10;
  static const int criticalHit = 15;
  static const int foeStrike = 10;
  static const Duration criticalTime = Duration(seconds: 3);

  final int heroMaxHp;
  final int foeMaxHp;
  int heroHp;
  int foeHp;
  int correct = 0;
  int wrong = 0;

  CombatOutcome get outcome => foeHp <= 0
      ? CombatOutcome.victory
      : heroHp <= 0
      ? CombatOutcome.retreat
      : CombatOutcome.ongoing;

  /// Applique une réponse ; renvoie les dégâts infligés (au monstre si
  /// juste, au héros sinon).
  int answer({required bool right, required Duration time}) {
    if (outcome != CombatOutcome.ongoing) {
      throw StateError('combat terminé');
    }
    if (right) {
      correct++;
      final dmg = time < criticalTime ? criticalHit : hit;
      foeHp = max(0, foeHp - dmg);
      return dmg;
    }
    wrong++;
    heroHp = max(0, heroHp - foeStrike);
    return foeStrike;
  }
}
