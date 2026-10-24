/// Examen de la région 1 : le Gardien de l'Oubli (cahier v3 §5.11).
/// Trois évaluations : lecture, écoute, prononciation (auto-évaluée).
library;

import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../../engines/audio/audio_service.dart';
import '../../../features/progress/lesson_progress.dart';
import '../../../features/resources/resources.dart';
import '../../../features/settings/settings.dart';
import '../../../game/combat/combat_scene.dart';
import '../../../game/exam/region_exam.dart';
import '../../widgets/arabic_text.dart';
import '../lesson/boss_view.dart' show HpWindow;
import '../lesson/question_view.dart';
import '../pixel.dart';

enum _Stage { intro, reading, listening, speaking, result }

class RegionExamScreen extends ConsumerStatefulWidget {
  const RegionExamScreen({super.key, this.random});

  /// Identifiant de progression de l'examen de la région 1.
  static const examId = 'examen-r1';

  /// Dernière leçon de la région 1.
  static const lastLesson = 14;

  final Random? random;

  @override
  ConsumerState<RegionExamScreen> createState() => _RegionExamScreenState();
}

class _RegionExamScreenState extends ConsumerState<RegionExamScreen> {
  late final Random _random = widget.random ?? Random();
  late CombatScene _scene;
  late RegionExamPlan _plan;
  _Stage _stage = _Stage.intro;
  int _index = 0;
  bool _answered = false;
  String? _flash;
  int _reading = 0;
  int _listening = 0;
  int _speakingOk = 0;
  final _readingClock = Stopwatch();
  bool _reported = false;

  @override
  void initState() {
    super.initState();
    _scene = CombatScene(
      animations: ref.read(settingsProvider).animations,
      boss: true,
    );
    _newExam();
  }

  void _newExam() {
    final db = ref.read(contentDatabaseProvider);
    final words = {
      for (final item in db.readingItems(
        stage: 1,
        upTo: RegionExamScreen.lastLesson,
      ))
        if (item.word && db.audioFile(item.arabic) != null)
          item.arabic: item.translit,
    };
    _plan = buildRegionExam(words, _random);
    _stage = _Stage.intro;
    _index = 0;
    _answered = false;
    _flash = null;
    _reading = 0;
    _listening = 0;
    _speakingOk = 0;
    _readingClock.reset();
    _reported = false;
  }

  bool get _calm => ref.read(settingsProvider).learningOnly;

  int get _foeMax =>
      (RegionExamRules.readingCount + RegionExamRules.listeningCount) * 10;
  int get _foeHp => _foeMax - (_reading + _listening) * 10;

  void _start() {
    setState(() => _stage = _Stage.reading);
    _readingClock.start();
  }

  void _onAnswered(bool right, Duration _) {
    if (right) {
      if (_stage == _Stage.reading) _reading++;
      if (_stage == _Stage.listening) _listening++;
      _scene.foeHit();
    } else {
      _scene.heroHit();
    }
    playSfx(ref, right ? Sfx.juste : Sfx.faux);
    setState(() {
      _answered = true;
      _flash = right ? 'Juste !' : 'Pas tout à fait.';
    });
  }

  void _next() {
    final count = switch (_stage) {
      _Stage.reading => _plan.reading.length,
      _Stage.listening => _plan.listening.length,
      _Stage.speaking => _plan.speaking.length,
      _ => 0,
    };
    setState(() {
      _answered = false;
      _flash = null;
      if (_index + 1 < count) {
        _index++;
        return;
      }
      _index = 0;
      switch (_stage) {
        case _Stage.reading:
          _readingClock.stop();
          _stage = _Stage.listening;
        case _Stage.listening:
          _stage = _Stage.speaking;
        case _Stage.speaking:
          _stage = _Stage.result;
          _report();
        case _:
          break;
      }
    });
  }

  void _selfAssess(bool ok) {
    if (ok) _speakingOk++;
    _next();
  }

  void _report() {
    if (_reported) return;
    _reported = true;
    final passed = RegionExamRules.passed(
      reading: _reading,
      listening: _listening,
    );
    ref
        .read(lessonProgressProvider.notifier)
        .recordBoss(
          RegionExamScreen.examId,
          score: _reading + _listening,
          passed: passed,
        );
    playSfx(ref, passed ? Sfx.victoire : Sfx.repli);
    if (passed) {
      final res = ref.read(resourceRepositoryProvider)
        ..grant(
          Currency.xp,
          Rewards.regionExamXp,
          key: 'examen:r1:xp',
          source: 'examen de la région 1',
        );
      res.grant(
        Currency.dinars,
        Rewards.regionExamDinars,
        key: 'examen:r1:dinars',
        source: 'examen de la région 1',
      );
      ref.read(walletProvider.notifier).refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final calm = ref.watch(settingsProvider.select((s) => s.learningOnly));
    return Scaffold(
      backgroundColor: GameColors.night,
      appBar: AppBar(
        title: const Text("Le Gardien de l'Oubli"),
        backgroundColor: GameColors.night,
        foregroundColor: GameColors.text,
      ),
      body: SafeArea(
        child: GameBody(
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              if (!calm) ...[
                CombatSceneBox(child: GameWidget(game: _scene)),
                const SizedBox(height: 12),
                HpWindow(
                  name: "Le Gardien de l'Oubli",
                  hp: max(0, _foeHp),
                  max: _foeMax,
                  color: GameColors.bad,
                ),
                const SizedBox(height: 12),
              ],
              ...switch (_stage) {
                _Stage.intro => _intro(),
                _Stage.reading || _Stage.listening => _question(),
                _Stage.speaking => _speaking(),
                _Stage.result => _result(),
              },
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _intro() => [
    PixelWindow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _calm
                ? 'Examen de la région'
                : 'Le Gardien de l\'Oubli garde la porte de la bibliothèque.',
            style: TextStyle(fontSize: 20, color: GameColors.accent),
          ),
          const SizedBox(height: 8),
          Text(
            'Trois épreuves : lire ${RegionExamRules.readingCount} mots '
            '(${RegionExamRules.readingMark} bonnes réponses nécessaires), '
            'reconnaître ${RegionExamRules.listeningCount} mots entendus '
            '(${RegionExamRules.listeningMark} nécessaires), puis lire '
            '${RegionExamRules.speakingCount} mots à voix haute et '
            't\'évaluer toi-même. Le temps de lecture est affiché, sans '
            'compter pour la réussite.',
          ),
          const SizedBox(height: 10),
          PixelCommand(label: 'Commencer', onPressed: _start),
        ],
      ),
    ),
  ];

  List<Widget> _question() {
    final reading = _stage == _Stage.reading;
    final list = reading ? _plan.reading : _plan.listening;
    return [
      Text(
        reading
            ? 'Épreuve 1 · Lecture · mot ${_index + 1} sur ${list.length}'
            : 'Épreuve 2 · Écoute · mot ${_index + 1} sur ${list.length}',
        style: TextStyle(color: GameColors.muted, fontSize: 14),
      ),
      const SizedBox(height: 4),
      QuestionView(
        key: ValueKey('examen-${_stage.name}-$_index'),
        question: list[_index],
        showExplanation: false,
        feedbackSound: false,
        onAnswered: _onAnswered,
        onContinue: _next,
        continueLabel: 'Suite',
        random: _random,
      ),
      if (_answered && _flash != null)
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            _flash!,
            textAlign: TextAlign.center,
            style: TextStyle(color: GameColors.accent),
          ),
        ),
    ];
  }

  List<Widget> _speaking() {
    final word = _plan.speaking[_index];
    return [
      Text(
        'Épreuve 3 · Prononciation · mot ${_index + 1} sur '
        '${_plan.speaking.length}',
        style: TextStyle(color: GameColors.muted, fontSize: 14),
      ),
      const SizedBox(height: 4),
      QuestionPanel(
        key: ValueKey('parler-$_index'),
        child: Column(
          children: [
            const Text(
              'Lis ce mot à voix haute, enregistre-toi, puis compare avec '
              'la référence.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            ArabicText(
              word,
              baseSize: 52,
              style: const TextStyle(color: PanelColors.ink),
            ),
            const SizedBox(height: 8),
            RepeatAloud(text: word),
            const SizedBox(height: 12),
            const Text(
              'L\'application ne note pas ta prononciation : c\'est toi qui '
              'compares.',
              textAlign: TextAlign.center,
              style: TextStyle(color: PanelColors.muted, fontSize: 13),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                PanelButton(
                  label: 'Je le dis bien',
                  onPressed: () => _selfAssess(true),
                ),
                PanelButton(
                  label: 'À retravailler',
                  onPressed: () => _selfAssess(false),
                ),
              ],
            ),
          ],
        ),
      ),
    ];
  }

  String _time(Duration d) {
    final m = d.inMinutes;
    final s = d.inSeconds % 60;
    return m == 0 ? '$s s' : '$m min $s s';
  }

  List<Widget> _result() {
    final passed = RegionExamRules.passed(
      reading: _reading,
      listening: _listening,
    );
    return [
      PixelWindow(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              passed
                  ? (_calm
                        ? 'Examen réussi !'
                        : 'Le Gardien de l\'Oubli se dissipe ! La porte de la '
                              'bibliothèque s\'ouvre.')
                  : 'Pas encore… Rien n\'est perdu : tu peux recommencer '
                        'quand tu veux.',
              style: TextStyle(fontSize: 20, color: GameColors.accent),
            ),
            const SizedBox(height: 8),
            Text(
              'Lecture : $_reading / ${RegionExamRules.readingCount} '
              '(${RegionExamRules.readingMark} nécessaires).',
            ),
            Text(
              'Temps de lecture : ${_time(_readingClock.elapsed)} (repère : '
              'environ 1 minute ; il ne compte pas pour la réussite).',
            ),
            Text(
              'Écoute : $_listening / ${RegionExamRules.listeningCount} '
              '(${RegionExamRules.listeningMark} nécessaires).',
            ),
            Text(
              'Prononciation : tu t\'es jugé à l\'aise sur $_speakingOk mot(s) '
              'sur ${RegionExamRules.speakingCount} (auto-évaluation, non '
              'notée).',
            ),
            if (passed) ...[
              const SizedBox(height: 6),
              Text(
                '+${Rewards.regionExamXp} XP, +${Rewards.regionExamDinars} '
                'dinars (la première fois).',
                style: TextStyle(color: GameColors.good),
              ),
            ],
            const SizedBox(height: 10),
            if (!passed)
              PixelCommand(
                label: 'Recommencer l\'examen',
                detail: 'De nouveaux mots',
                onPressed: () => setState(_newExam),
              ),
            PixelCommand(
              label: 'Retour',
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    ];
  }
}
