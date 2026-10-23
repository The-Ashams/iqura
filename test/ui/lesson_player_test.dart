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
import 'package:iqura/engines/voice/voice_recorder.dart';
import 'package:iqura/features/progress/lesson_progress.dart';
import 'package:iqura/features/resources/resources.dart';
import 'package:iqura/features/review/review.dart';
import 'package:iqura/features/settings/settings.dart';
import 'package:iqura/game/lesson/lesson.dart';
import 'package:iqura/ui/game/expedition_screen.dart';
import 'package:iqura/ui/game/lesson/boss_view.dart';
import 'package:iqura/ui/game/lesson/lesson_screen.dart';
import 'package:iqura/ui/game/lesson/question_view.dart';
import 'package:iqura/ui/game/pixel.dart';

class FakeSfx implements SfxPlayer {
  final played = <Sfx>[];
  @override
  Future<void> play(Sfx sound) async => played.add(sound);
  @override
  Future<void> dispose() async {}
}

class FakeRecorder implements VoiceRecorder {
  final saved = <String, String>{};
  String? _current;
  @override
  Future<bool> allowed() async => true;
  @override
  Future<void> start(String key) async => _current = key;
  @override
  Future<String?> stop() async {
    final k = _current!;
    return saved[k] = '/enregistrements/${saved.length}.m4a';
  }

  @override
  String? last(String key) => saved[key];
  @override
  Future<void> dispose() async {}
}

class FakeAudio implements AudioService {
  final played = <String>[];
  @override
  Future<void> playAsset(String path) async => played.add(path);
  @override
  Future<void> playFile(String path) async => played.add(path);
  @override
  Future<void> dispose() async {}
}

late Directory tmp;
late UserDatabase userDb;
late ContentDatabase contentDb;
late FakeAudio audio;
late FakeSfx sfx;
late FakeRecorder recorder;

Widget app(String lessonId) =>
    appWith(LessonScreen(lessonId: lessonId, random: Random(7)));

Widget appWith(Widget home) => ProviderScope(
  overrides: [
    appPathsProvider.overrideWithValue(AppPaths(tmp.path)),
    userDatabaseProvider.overrideWithValue(userDb),
    contentDatabaseProvider.overrideWithValue(contentDb),
    audioServiceProvider.overrideWithValue(audio),
    sfxPlayerProvider.overrideWithValue(sfx),
    voiceRecorderProvider.overrideWithValue(recorder),
  ],
  child: MaterialApp(home: home),
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
      // S'enregistrer, s'arrêter, réécouter sa voix, puis continuer.
      await tapOn(tester, find.text("M'enregistrer"));
      await tapOn(tester, find.text('Arrêter'));
      await tapOn(tester, find.text('Ma voix'));
      await tapOn(tester, find.text("J'ai répété"));
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
    recorder = FakeRecorder();
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

  for (final id in [
    'dechiffrer-00',
    'dechiffrer-01',
    'dechiffrer-02',
    'dechiffrer-03',
    'dechiffrer-04',
  ]) {
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
      final next = stage.where((l) => l.ordinal == lesson.ordinal + 1);
      if (next.isNotEmpty) {
        expect(
          lessonUnlocked(
            next.first,
            stage,
            LessonProgressRepository(userDb).loadAll(),
          ),
          isTrue,
        );
      }
      // Première réussite : récompenses et cartes de révision (§6.3).
      final wallet = ResourceRepository(userDb).wallet();
      expect(wallet[Currency.xp], greaterThanOrEqualTo(Rewards.lessonFirstXp));
      expect(wallet[Currency.encre], 1);
      final cards = ReviewRepository(userDb, ResourceRepository(userDb)).all();
      expect(
        cards.length,
        lesson.letters.length * 2 +
            lesson.signs.length +
            lesson.readings.length,
      );
      expect(
        find.textContaining('nouvelles cartes'),
        cards.isEmpty ? findsNothing : findsOneWidget,
      );
      // Répéter à voix haute : la voix enregistrée est réécoutée.
      if (lesson.ordinal > 0) {
        expect(recorder.saved, isNotEmpty);
        expect(audio.played.any((p) => p.endsWith('.m4a')), isTrue);
      }
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

  testWidgets('Expédition : les cartes de la leçon 1 sont révisées, la '
      'brume tombe, les gains sont comptés', (tester) async {
    final res = ResourceRepository(userDb);
    final reviews = ReviewRepository(userDb, res);
    rewardLesson(
      contentDb.lesson('dechiffrer-01')!,
      first: true,
      resources: res,
      reviews: reviews,
    );
    final due = reviews.due().length;
    expect(due, greaterThan(10));
    tester.view.physicalSize = const Size(800, 4000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(appWith(ExpeditionScreen(random: Random(3))));
    await settle(tester);
    var guard = 0;
    while (find.byType(QuestionView).evaluate().isNotEmpty && guard++ < 60) {
      await answer(tester);
    }
    expect(find.text("Les brumes d'oubli se dissipent !"), findsOneWidget);
    // Chaque révision est notée et replanifiée par FSRS.
    expect(userDb.select('SELECT * FROM review_log'), hasLength(due));
    expect(reviews.due(), isEmpty);
    expect(res.wallet()[Currency.xp], greaterThan(Rewards.lessonFirstXp));
    expect(sfx.played, contains(Sfx.victoire));
    // Les cartes ne sont plus dues : l'Expédition propose l'entraînement.
    await tester.pumpWidget(const SizedBox());
    await tester.pumpWidget(appWith(ExpeditionScreen(random: Random(3))));
    await settle(tester);
    expect(find.textContaining('Rien à réviser'), findsOneWidget);
    expect(find.text('Entraînement libre'), findsOneWidget);
  });

  testWidgets('tracé guidé : suivre les points dans l’ordre réussit, à '
      'l’envers non (sans sanction)', (tester) async {
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      appWith(
        Scaffold(
          body: Center(
            child: GuidedTrace(letter: 'ب', onDone: () {}),
          ),
        ),
      ),
    );
    final guide = contentDb.letterTrace('ب')!;
    final pad = tester.getTopLeft(find.byKey(const Key('trace-pad')));
    const k = GuidedTrace.size / 100;
    Future<void> draw(List<Offset> pts) async {
      final g = await tester.startGesture(
        pad + pts.first * k + const Offset(2, 2),
      );
      for (final p in pts.skip(1)) {
        await g.moveTo(pad + p * k + const Offset(2, 2));
      }
      await g.up();
      await tester.pump();
    }

    Future<void> tapAt(Offset p) async {
      await tester.tapAt(pad + p * k + const Offset(2, 2));
      await tester.pump();
    }

    // Dans l'ordre : le corps de la lettre, puis le point.
    await draw(guide[0]);
    await tapAt(guide[1].first);
    await tester.tap(find.text('Vérifier'));
    await tester.pump();
    expect(find.text('Bien tracé !'), findsOneWidget);
    // À l'envers : refusé, mais on peut toujours continuer.
    await tester.tap(find.text('Effacer'));
    await tester.pump();
    await draw(guide[0].reversed.toList());
    await tapAt(guide[1].first);
    await tester.tap(find.text('Vérifier'));
    await tester.pump();
    expect(find.textContaining('Pas tout à fait'), findsOneWidget);
    expect(
      tester.widget<PanelButton>(find.byType(PanelButton)).onPressed,
      isNotNull,
    );
  });

  test('tracés : chaque lettre enseignée au niveau a son tracé guidé', () {
    for (final l in [
      'ا',
      'ب',
      'ت',
      'ث',
      'ن',
      'ي',
      'ج',
      'ح',
      'خ',
      'د',
      'ذ',
      'ر',
      'ز',
    ]) {
      expect(contentDb.letterTrace(l), isNotNull, reason: l);
    }
  });

  testWidgets('apprentissage seul : leçon sans scène ni combat, même '
      'progression', (tester) async {
    SettingsRepository(userDb).saveLearningOnly(true);
    const id = 'dechiffrer-01';
    final lesson = contentDb.lesson(id)!;
    await open(tester, id);
    // Pas de scène d'Histoire : l'objectif tout de suite.
    expect(find.text('Entrer'), findsOneWidget);
    expect(find.byType(SceneView), findsNothing);
    expect(await playLesson(tester, lesson), isTrue);
    expect(find.byType(CombatSceneBox), findsNothing);
    expect(LessonProgressRepository(userDb).get(id).completed, isTrue);
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
