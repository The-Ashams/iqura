import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iqura/core/app_paths.dart';
import 'package:iqura/core/providers.dart';
import 'package:iqura/data/content_db/content_database.dart';
import 'package:iqura/data/user_db/user_database.dart';
import 'package:iqura/engines/audio/audio_service.dart';
import 'package:iqura/features/progress/lesson_progress.dart';
import 'package:iqura/features/settings/settings.dart';
import 'package:iqura/game/lesson/lesson.dart';
import 'package:iqura/ui/game/lesson/boss_view.dart';
import 'package:iqura/ui/game/lesson/lesson_screen.dart';
import 'package:iqura/ui/game/lesson/question_view.dart';

class FakeSfx implements SfxPlayer {
  final played = <Sfx>[];
  @override
  Future<void> play(Sfx sound) async => played.add(sound);
  @override
  Future<void> dispose() async {}
}

class FakeAudio implements AudioService {
  final played = <String>[];
  @override
  Future<void> playAsset(String path) async => played.add(path);
  @override
  Future<void> dispose() async {}
}

late Directory tmp;
late UserDatabase userDb;
late ContentDatabase contentDb;
late FakeAudio audio;
late FakeSfx sfx;

Widget app(String lessonId) => ProviderScope(
  overrides: [
    appPathsProvider.overrideWithValue(AppPaths(tmp.path)),
    userDatabaseProvider.overrideWithValue(userDb),
    contentDatabaseProvider.overrideWithValue(contentDb),
    audioServiceProvider.overrideWithValue(audio),
    sfxPlayerProvider.overrideWithValue(sfx),
  ],
  child: MaterialApp(
    home: LessonScreen(lessonId: lessonId, random: Random(7)),
  ),
);

/// Laisse passer le temps sans attendre la fin des animations sans fin de
/// la scène de combat.
Future<void> settle(WidgetTester tester) async {
  for (var i = 0; i < 3; i++) {
    await tester.pump(const Duration(milliseconds: 50));
  }
}

Future<void> tapOn(WidgetTester tester, Finder f) async {
  await tester.ensureVisible(f);
  await settle(tester);
  await tester.tap(f);
  await settle(tester);
}

/// Numéro de l'écran affiché (« Écran k / N »).
int currentStep(WidgetTester tester) {
  final t = tester.widget<Text>(find.textContaining('Écran ')).data!;
  return int.parse(RegExp(r'Écran (\d+)').firstMatch(t)![1]!) - 1;
}

/// Bouton de réponse ouvert qui contient [text].
Finder answerButton(WidgetTester tester, String text) {
  final buttons = find.ancestor(
    of: find.text(text),
    matching: find.byType(AnswerButton),
  );
  for (final e in buttons.evaluate()) {
    final w = e.widget as AnswerButton;
    if (w.state == AnswerState.open || w.state == AnswerState.selected) {
      return find.byWidget(w);
    }
  }
  throw StateError('aucun bouton ouvert pour $text');
}

/// Répond à la question affichée, juste ou non.
Future<void> answer(WidgetTester tester, {bool right = true}) async {
  final view = tester.widget<QuestionView>(find.byType(QuestionView));
  final q = view.question;
  switch (q.kind) {
    case QuestionKind.tracer:
      await tester.ensureVisible(find.byKey(const Key('trace-pad')));
      await tester.drag(
        find.byKey(const Key('trace-pad')),
        const Offset(-60, 20),
      );
      await settle(tester);
      await tapOn(tester, find.text("J'ai tracé"));
      return;
    case QuestionKind.repeter:
      await tapOn(tester, find.text("Je l'ai répété"));
      return;
    case QuestionKind.reconstruire:
      final parts = right ? q.solution : q.solution.reversed.toList();
      for (final t in parts) {
        await tapOn(tester, answerButton(tester, t));
      }
    default:
      final i = right ? q.answer! : (q.answer! + 1) % q.choices.length;
      final label = q.choiceKind == ChoiceKind.audio
          ? 'Son ${i + 1}'
          : q.choices[i];
      await tapOn(tester, answerButton(tester, label));
  }
  await tapOn(tester, find.text('Valider'));
  expect(
    find.text(right ? 'Juste !' : 'Pas tout à fait.'),
    findsOneWidget,
    reason: q.prompt,
  );
  // Le libellé change à la dernière question du mini-boss.
  await tapOn(tester, find.byType(PanelButton).last);
}

/// Joue la leçon jusqu'à l'écran de fin ; [bossErrors] erreurs au début du
/// mini-boss. Renvoie vrai si l'écran de fin est atteint.
Future<bool> playLesson(
  WidgetTester tester,
  Lesson lesson, {
  int bossErrors = 0,
}) async {
  for (var guard = 0; guard < 400; guard++) {
    final step = lesson.steps[currentStep(tester)];
    switch (step) {
      case EntryStep():
        if (find.text('Entrer').evaluate().isNotEmpty) {
          await tapOn(tester, find.text('Entrer'));
        } else {
          await tapOn(tester, find.text('Suite'));
        }
      case ExplainStep():
        await answer(tester);
      case PracticeStep():
        if (find.byType(QuestionView).evaluate().isNotEmpty) {
          await answer(tester);
        } else {
          await tapOn(tester, find.text('Continuer'));
        }
      case QuranStep():
        for (final e in step.extracts) {
          final q = e.question;
          if (q.kind == QuestionKind.repererMot) {
            await tapOn(
              tester,
              find.text(contentDb.tokenText(q.token!)!).first,
            );
          } else {
            final n = countLetter(contentDb.tokenText(q.token!)!, q.letter!);
            await tapOn(tester, answerButton(tester, '$n'));
          }
          await tapOn(tester, find.text('Valider'));
          expect(find.text('Juste !'), findsOneWidget);
          await tapOn(tester, find.text('Continuer'));
        }
      case BossStep():
        if (find.byType(QuestionView).evaluate().isNotEmpty) {
          await answer(tester, right: bossErrors-- <= 0);
        } else if (find.text('Retenter le combat').evaluate().isNotEmpty) {
          return false;
        } else {
          await tapOn(tester, find.text('Continuer'));
        }
      case EndStep():
        return true;
    }
  }
  fail('la leçon ne se termine pas');
}

void main() {
  setUp(() {
    tmp = Directory.systemTemp.createTempSync('iqura-lesson');
    contentDb = ContentDatabase.openVerified(ContentDatabase.assetPath);
    userDb = UserDatabase.open(null);
    audio = FakeAudio();
    sfx = FakeSfx();
  });

  tearDown(() {
    userDb.close();
    contentDb.close();
    tmp.deleteSync(recursive: true);
  });

  Future<void> open(WidgetTester tester, String id) async {
    tester.view.physicalSize = const Size(800, 4000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(app(id));
    await settle(tester);
  }

  for (final id in ['dechiffrer-00', 'dechiffrer-01']) {
    testWidgets('$id : jouée de bout en bout, la leçon suivante s’ouvre', (
      tester,
    ) async {
      final lesson = contentDb.lesson(id)!;
      await open(tester, id);
      expect(await playLesson(tester, lesson), isTrue);
      expect(find.text('Ce que tu sais lire maintenant'), findsOneWidget);
      final p = LessonProgressRepository(userDb).get(id);
      expect(p.completed, isTrue);
      expect(p.step, lesson.steps.length - 1);
      final stage = contentDb.lessons(1);
      final next = stage.firstWhere((l) => l.ordinal == lesson.ordinal + 1);
      expect(
        lessonUnlocked(next, stage, LessonProgressRepository(userDb).loadAll()),
        isTrue,
      );
      // Bruitages : réponses, combat, sceau de fin.
      expect(sfx.played, containsAll([Sfx.juste, Sfx.coup, Sfx.victoire]));
      expect(sfx.played.last, Sfx.sceau);
      // Chaque écran porte la mention IA et le signalement d'erreur.
      expect(find.text('Rédigé par IA'), findsOneWidget);
      expect(find.text('Signaler une erreur'), findsOneWidget);
    });
  }

  testWidgets('mini-boss : trois erreurs, la difficulté s’échappe, rien '
      'n’est perdu', (tester) async {
    const id = 'dechiffrer-01';
    final lesson = contentDb.lesson(id)!;
    await open(tester, id);
    expect(await playLesson(tester, lesson, bossErrors: 3), isFalse);
    expect(find.textContaining("s'échappe"), findsOneWidget);
    expect(sfx.played, containsAll([Sfx.degats, Sfx.repli]));
    expect(find.text('Tes erreurs, expliquées :'), findsOneWidget);
    final p = LessonProgressRepository(userDb).get(id);
    expect(p.completed, isFalse);
    expect(p.bossFailures, 1);
    // Retenter : nouveau combat, points de vie remis à neuf.
    await tapOn(tester, find.text('Retenter le combat'));
    expect(find.byType(QuestionView), findsOneWidget);
    expect(find.text('PV 30 / 30'), findsOneWidget);
  });

  testWidgets('la progression est sauvegardée à chaque écran et reprise', (
    tester,
  ) async {
    const id = 'dechiffrer-00';
    await open(tester, id);
    await tapOn(tester, find.text('Suite'));
    await tapOn(tester, find.text('Suite'));
    await tapOn(tester, find.text('Entrer'));
    expect(currentStep(tester), 1);
    expect(LessonProgressRepository(userDb).get(id).step, 1);
    // Rouvrir la leçon : reprise au même écran.
    await tester.pumpWidget(const SizedBox());
    await tester.pumpWidget(app(id));
    await settle(tester);
    expect(currentStep(tester), 1);
  });

  testWidgets('écran « élément » : le nom de la lettre est joué', (
    tester,
  ) async {
    const id = 'dechiffrer-01';
    final lesson = contentDb.lesson(id)!;
    final element = lesson.steps.indexWhere(
      (s) => s is ExplainStep && s.kind == ExplainKind.element,
    );
    LessonProgressRepository(userDb).saveStep(id, element);
    await open(tester, id);
    final letter = (lesson.steps[element] as ExplainStep).letter!;
    final name = contentDb.letter(letter)!.nameAr;
    expect(audio.played, contains(contentDb.audioFile(name)));
    expect(find.text('synthèse'), findsWidgets);
  });

  testWidgets('PC (2000 × 1125) : au mini-boss, la question est visible sans '
      'défiler', (tester) async {
    const id = 'dechiffrer-00';
    final lesson = contentDb.lesson(id)!;
    LessonProgressRepository(userDb)
        .saveStep(id, lesson.steps.indexWhere((s) => s is BossStep));
    tester.view.physicalSize = const Size(2000, 1125);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(app(id));
    await settle(tester);
    final valider = tester.getRect(find.text('Valider'));
    expect(valider.bottom, lessThan(1125));
    // Contenu centré, pas étiré sur toute la largeur.
    final panel = tester.getRect(find.byType(QuestionPanel));
    expect(panel.width, lessThanOrEqualTo(760));
  });

  testWidgets('bruitages désactivés dans les réglages : aucun son de jeu', (
    tester,
  ) async {
    SettingsRepository(userDb).saveSoundEffects(false);
    await open(tester, 'dechiffrer-00');
    await tapOn(tester, find.text('Suite'));
    await tapOn(tester, find.text('Suite'));
    await tapOn(tester, find.text('Entrer'));
    await answer(tester);
    expect(sfx.played, isEmpty);
  });

  group('règles du mini-boss', () {
    test('le seuil de 80 % est arrondi au supérieur', () {
      expect(bossPassMark(12, 0.8), 10);
      expect(bossPassMark(10, 0.8), 8);
      expect(bossPassMark(11, 0.8), 9);
    });

    test('la difficulté tombe exactement au seuil, le voyageur à la première '
        'erreur de trop', () {
      final win = BossFight(questions: 12, threshold: 0.8);
      for (var i = 0; i < 2; i++) {
        win.answer(false);
      }
      for (var i = 0; i < 9; i++) {
        win.answer(true);
      }
      expect(win.over, isFalse);
      win.answer(true);
      expect(win.won, isTrue);

      final lose = BossFight(questions: 12, threshold: 0.8);
      for (var i = 0; i < 3; i++) {
        lose.answer(false);
      }
      expect(lose.lost, isTrue);
    });
  });

  test('progression : réussite gardée, échecs comptés puis remis à zéro', () {
    final repo = LessonProgressRepository(
      userDb,
      now: () => DateTime.utc(2026, 10, 23),
    );
    repo.recordBoss('x', score: 7, passed: false);
    repo.recordBoss('x', score: 6, passed: false);
    expect(repo.get('x').bossFailures, 2);
    expect(repo.get('x').bestScore, 7);
    repo.recordBoss('x', score: 11, passed: true);
    repo.recordBoss('x', score: 3, passed: false);
    final p = repo.get('x');
    expect(p.completed, isTrue);
    expect(p.completedAt!.isAtSameMomentAs(DateTime.utc(2026, 10, 23)), isTrue);
    expect(p.bestScore, 11);
  });
}
