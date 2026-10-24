/// Questions de révision (Expédition) tirées des cartes FSRS : jamais de
/// translittération ni de nom de lettre en lettres latines dans la question
/// (cahier v3 §6.2), jamais de verset (§3.1), 3 choix distincts et une seule
/// bonne réponse, distracteurs pris parmi ce que le joueur a déjà appris.
library;

import 'dart:math';

import '../../features/review/review.dart';
import '../lesson/lesson.dart';
import '../world.dart';

class ReviewPools {
  const ReviewPools({
    required this.letters,
    required this.readings,
    required this.translit,
    required this.syllables,
  });

  /// Fiches des lettres apprises (cartes « reconnaître » ou « écouter »).
  final List<LetterCard> letters;

  /// Syllabes et mots appris (cartes « lire »), et syllabes connues.
  final List<String> readings;

  /// Translittération de chaque lecture (pour l'explication, montrée
  /// après le combat).
  final Map<String, String> translit;

  /// Lectures qui sont des syllabes (les autres sont des mots).
  final Set<String> syllables;

  bool _isSyllable(String s) => syllables.contains(s);
}

/// Prend [n] éléments distincts de [pool] différents de [answer], au
/// hasard, en préférant ceux pour lesquels [close] est vrai.
List<T> _distractors<T>(
  List<T> pool,
  T answer,
  int n,
  Random r, {
  bool Function(T)? close,
}) {
  final others = pool.where((e) => e != answer).toSet().toList()..shuffle(r);
  if (close != null) {
    others.sort((a, b) => (close(a) ? 0 : 1).compareTo(close(b) ? 0 : 1));
  }
  return others.take(n).toList();
}

LessonQuestion _withChoices(
  LessonQuestion Function(List<String> choices, int answer) make,
  String answer,
  List<String> others,
  Random r,
) {
  final choices = [answer, ...others]..shuffle(r);
  return make(choices, choices.indexOf(answer));
}

/// Question d'une carte ; `null` s'il n'y a pas assez d'éléments appris
/// pour proposer 3 choix (la carte attend alors la session suivante).
LessonQuestion? questionFor(ReviewCard card, ReviewPools p, Random r) {
  switch (card.kind) {
    case CardKind.reconnaitre:
    case CardKind.ecouter:
      final letter = p.letters.where((l) => l.letter == card.target);
      if (letter.isEmpty || p.letters.length < 3) return null;
      final l = letter.first;
      final others = _distractors(p.letters, l, 2, r);
      if (others.length < 2) return null;
      if (card.kind == CardKind.ecouter) {
        return _withChoices(
          (c, a) => LessonQuestion(
            kind: QuestionKind.ecouterLettre,
            prompt: 'Écoute et choisis la lettre.',
            choices: c,
            choiceKind: ChoiceKind.arabic,
            answer: a,
            explanation: frenchWithArabic('C\'était ${l.letter} (${l.name}).'),
          ),
          l.letter,
          [for (final o in others) o.letter],
          r,
        );
      }
      return _withChoices(
        (c, a) => LessonQuestion(
          kind: QuestionKind.lire,
          prompt: 'Comment s\'appelle cette lettre ? Écoute et choisis.',
          arabic: l.letter,
          choices: c,
          choiceKind: ChoiceKind.audio,
          answer: a,
          explanation: frenchWithArabic('C\'est ${l.letter}, ${l.name}.'),
        ),
        l.nameAr,
        [for (final o in others) o.nameAr],
        r,
      );
    case CardKind.signe:
      final mark = signMarks[card.target];
      if (mark == null) return null;
      final syllables = p.readings.where(p._isSyllable).toList();
      final withSign = syllables.where((s) => s.contains(mark)).toList()
        ..shuffle(r);
      if (withSign.isEmpty) return null;
      final answer = withSign.first;
      final consonant = answer.runes.first;
      // Distracteurs : de préférence la même consonne avec un autre signe.
      final others = _distractors(
        syllables,
        answer,
        2,
        r,
        close: (s) => s.runes.first == consonant && !s.contains(mark),
      );
      if (others.length < 2) return null;
      return _withChoices(
        (c, a) => LessonQuestion(
          kind: QuestionKind.ecouter,
          prompt: 'Quelle syllabe entends-tu ?',
          audio: answer,
          choices: c,
          choiceKind: ChoiceKind.arabic,
          answer: a,
          explanation: frenchWithArabic(
            'C\'était $answer (${p.translit[answer] ?? ''}).',
          ),
        ),
        answer,
        others,
        r,
      );
    case CardKind.lire:
      final target = card.target;
      final sameType = p.readings
          .where((s) => p._isSyllable(s) == p._isSyllable(target))
          .toList();
      final others = _distractors(
        sameType.length >= 3 ? sameType : p.readings,
        target,
        2,
        r,
      );
      if (others.length < 2) return null;
      return _withChoices(
        (c, a) => LessonQuestion(
          kind: QuestionKind.lire,
          prompt: 'Comment se lit-il ? Écoute et choisis.',
          arabic: target,
          choices: c,
          choiceKind: ChoiceKind.audio,
          answer: a,
          explanation: frenchWithArabic(
            '$target se lit « ${p.translit[target] ?? ''} ».',
          ),
        ),
        target,
        others,
        r,
      );
  }
}
