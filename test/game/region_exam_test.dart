import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:iqura/game/exam/region_exam.dart';
import 'package:iqura/game/lesson/lesson.dart';

void main() {
  test('examen de la région 1 : seuils de réussite', () {
    expect(RegionExamRules.readingMark, 18); // 90 % de 20
    expect(RegionExamRules.listeningMark, 8); // 80 % de 10
    expect(RegionExamRules.passed(reading: 18, listening: 8), isTrue);
    expect(RegionExamRules.passed(reading: 17, listening: 10), isFalse);
    expect(RegionExamRules.passed(reading: 20, listening: 7), isFalse);
  });

  test('examen : 20 lectures, 10 écoutes, 5 mots à dire, 3 choix justes', () {
    final words = {for (var i = 0; i < 30; i++) 'كَلِمَة$i': 'kalima$i'};
    final plan = buildRegionExam(words, Random(1));
    expect(plan.reading, hasLength(20));
    expect(plan.listening, hasLength(10));
    expect(plan.speaking, hasLength(5));
    for (final q in plan.reading) {
      expect(q.kind, QuestionKind.lire);
      expect(q.choices, hasLength(3));
      expect(q.choices.toSet(), hasLength(3));
      expect(q.choices[q.answer!], q.arabic);
    }
    for (final q in plan.listening) {
      expect(q.kind, QuestionKind.ecouter);
      expect(q.choices[q.answer!], q.audio);
    }
    expect(plan.reading.map((q) => q.arabic).toSet(), hasLength(20));
  });

  test('examen : refusé s\'il n\'y a pas assez de mots', () {
    expect(() => buildRegionExam({'بَاب': 'bāb'}, Random(1)), throwsStateError);
  });
}
