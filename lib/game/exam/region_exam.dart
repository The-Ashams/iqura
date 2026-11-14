/// Examen de fin de région (cahier v3 §5.11) : trois évaluations distinctes.
/// Région 1 : lecture (associer 20 mots vocalisés à leur lecture, 90 %
/// au moins), écoute (reconnaître des mots entendus), prononciation (lire à
/// voix haute, s'enregistrer, comparer et s'auto-évaluer, jamais noté par
/// l'application). Le temps de lecture est affiché, sans bloquer.
library;

import 'dart:math';

import '../lesson/lesson.dart';

abstract final class RegionExamRules {
  static const readingCount = 20;
  static const readingPass = 0.9;
  static const listeningCount = 10;

  /// Seuil d'écoute : celui des mini-boss (décision à valider, cahier §16).
  static const listeningPass = 0.8;
  static const speakingCount = 5;

  /// Repère indicatif du temps de lecture (non bloquant).
  static const referenceReadingTime = Duration(minutes: 1);

  static int mark(int count, double pass) => (count * pass).ceil();
  static int get readingMark => mark(readingCount, readingPass);
  static int get listeningMark => mark(listeningCount, listeningPass);

  static bool passed({required int reading, required int listening}) =>
      reading >= readingMark && listening >= listeningMark;
}

/// Questions d'un examen, tirées des mots vocalisés de la région (ceux qui
/// ont un enregistrement).
class RegionExamPlan {
  const RegionExamPlan({
    required this.reading,
    required this.listening,
    required this.speaking,
  });

  final List<LessonQuestion> reading;
  final List<LessonQuestion> listening;
  final List<String> speaking;
}

/// Construit un examen à partir de [words] (mots vocalisés avec leur
/// translittération). Chaque question a 3 choix ; les autres choix sont
/// d'autres mots de la région.
RegionExamPlan buildRegionExam(Map<String, String> words, Random random) {
  final pool = words.keys.toList()..sort();
  if (pool.length < RegionExamRules.readingCount) {
    throw StateError('pas assez de mots pour un examen (${pool.length})');
  }
  List<String> draw(int n) => ([...pool]..shuffle(random)).take(n).toList();
  (List<String>, int) choicesFor(String target) {
    final others =
        ([...pool]
              ..remove(target)
              ..shuffle(random))
            .take(2);
    final choices = [target, ...others]..shuffle(random);
    return (choices, choices.indexOf(target));
  }

  final reading = [
    for (final w in draw(RegionExamRules.readingCount))
      () {
        final (c, a) = choicesFor(w);
        return LessonQuestion(
          kind: QuestionKind.lire,
          prompt: 'Comment se lit ce mot ? Écoute et choisis.',
          arabic: w,
          choices: c,
          choiceKind: ChoiceKind.audio,
          answer: a,
          explanation: frenchWithArabic('$w se lit « ${words[w]} ».'),
        );
      }(),
  ];
  final listening = [
    for (final w in draw(RegionExamRules.listeningCount))
      () {
        final (c, a) = choicesFor(w);
        return LessonQuestion(
          kind: QuestionKind.ecouter,
          prompt: 'Quel mot entends-tu ?',
          audio: w,
          choices: c,
          choiceKind: ChoiceKind.arabic,
          answer: a,
          explanation: frenchWithArabic('C\'était $w (« ${words[w]} »).'),
        );
      }(),
  ];
  return RegionExamPlan(
    reading: reading,
    listening: listening,
    speaking: draw(RegionExamRules.speakingCount),
  );
}
