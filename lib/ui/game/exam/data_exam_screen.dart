/// Examen de fin de région écrit en données (région 2 : le Grand Mirage,
/// cahier v3 §5.11). Trois épreuves : comprendre un récit, écouter,
/// répondre à des personnages. Les phrases à remettre en ordre sont notées ;
/// les réponses libres sont comparées à des modèles et auto-évaluées, jamais
/// notées par l'application (décision du conseiller, 26/10/2026).
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
import '../../../game/exam/data_exam.dart';
import '../../../game/lesson/lesson.dart';
import '../../widgets/arabic_text.dart';
import '../lesson/boss_view.dart' show HpWindow;
import '../lesson/fondations_views.dart' show GradedText;
import '../lesson/question_view.dart';
import '../pixel.dart';

enum _Stage { intro, reading, listening, replies, result }

class DataExamScreen extends ConsumerStatefulWidget {
  const DataExamScreen({super.key, required this.region, this.random});

  final int region;
  final Random? random;

  @override
  ConsumerState<DataExamScreen> createState() => _DataExamScreenState();
}

class _DataExamScreenState extends ConsumerState<DataExamScreen> {
  late final Random _random = widget.random ?? Random();
  late final DataExam _exam;
  late CombatScene _scene;
  _Stage _stage = _Stage.intro;
  int _index = 0;
  bool _answered = false;
  String? _flash;
  int _reading = 0;
  int _listening = 0;
  int _replies = 0;
  int _freeOk = 0;
  bool _showModels = false;
  bool _reported = false;
  final _draft = TextEditingController();

  @override
  void initState() {
    super.initState();
    _exam = ref.read(contentDatabaseProvider).regionExam(widget.region)!;
    _scene = CombatScene(
      animations: ref.read(settingsProvider).animations,
      boss: true,
      region: widget.region,
    );
  }

  @override
  void dispose() {
    _draft.dispose();
    super.dispose();
  }

  bool get _calm => ref.read(settingsProvider).learningOnly;

  int get _foeMax =>
      (_exam.reading.length + _exam.listening.length + _exam.gradedReplies) *
      10;
  int get _foeHp => _foeMax - (_reading + _listening + _replies) * 10;

  void _restart() {
    _stage = _Stage.intro;
    _index = 0;
    _answered = false;
    _flash = null;
    _reading = 0;
    _listening = 0;
    _replies = 0;
    _freeOk = 0;
    _showModels = false;
    _reported = false;
    _draft.clear();
  }

  void _onAnswered(bool right, Duration _) {
    if (right) {
      switch (_stage) {
        case _Stage.reading:
          _reading++;
        case _Stage.listening:
          _listening++;
        case _Stage.replies:
          _replies++;
        case _:
          break;
      }
      _scene.foeHit();
    } else {
      _scene.heroHit();
    }
    playSfx(ref, right ? Sfx.juste : Sfx.faux);
    setState(() {
      _answered = true;
      _flash = _calm
          ? null
          : right
          ? 'Le mirage se trouble !'
          : 'Le mirage brouille la vue.';
    });
  }

  int get _count => switch (_stage) {
    _Stage.reading => _exam.reading.length,
    _Stage.listening => _exam.listening.length,
    _Stage.replies => _exam.replies.length,
    _ => 0,
  };

  void _next() {
    setState(() {
      _answered = false;
      _flash = null;
      _showModels = false;
      _draft.clear();
      if (_index + 1 < _count) {
        _index++;
        return;
      }
      _index = 0;
      switch (_stage) {
        case _Stage.reading:
          _stage = _Stage.listening;
        case _Stage.listening:
          _stage = _Stage.replies;
        case _Stage.replies:
          _stage = _Stage.result;
          _report();
        case _:
          break;
      }
    });
  }

  bool get _passed =>
      _exam.passed(reading: _reading, listening: _listening, replies: _replies);

  void _report() {
    if (_reported) return;
    _reported = true;
    final passed = _passed;
    ref
        .read(lessonProgressProvider.notifier)
        .recordBoss(
          _exam.id,
          score: _reading + _listening + _replies,
          passed: passed,
        );
    playSfx(ref, passed ? Sfx.victoire : Sfx.repli);
    if (passed) {
      final r = widget.region;
      final res = ref.read(resourceRepositoryProvider)
        ..grant(
          Currency.xp,
          Rewards.regionExamXp,
          key: 'examen:r$r:xp',
          source: 'examen de la région $r',
        );
      res.grant(
        Currency.dinars,
        Rewards.regionExamDinars,
        key: 'examen:r$r:dinars',
        source: 'examen de la région $r',
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
        title: Text(_exam.title),
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
                  name: _exam.title,
                  hp: max(0, _foeHp),
                  max: _foeMax,
                  color: GameColors.bad,
                ),
                const SizedBox(height: 12),
              ],
              ...switch (_stage) {
                _Stage.intro => _intro(),
                _Stage.reading => _readingStage(),
                _Stage.listening => _question(
                  'Épreuve 2 · Écoute',
                  _exam.listening[_index],
                  _exam.listening.length,
                ),
                _Stage.replies => _replyStage(),
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
            _calm ? 'Examen de la région' : _exam.intro,
            style: TextStyle(fontSize: 20, color: GameColors.accent),
          ),
          const SizedBox(height: 8),
          Text(
            'Trois épreuves : lire un récit et répondre à '
            '${_exam.reading.length} questions (${_exam.readingMark} bonnes '
            'réponses nécessaires) ; écouter ${_exam.listening.length} '
            'phrases (${_exam.listeningMark} nécessaires) ; répondre à des '
            'personnages : ${_exam.gradedReplies} phrases à remettre en ordre '
            '(${_exam.repliesMark} nécessaires)'
            '${_exam.replies.length > _exam.gradedReplies ? ' et des réponses '
                      'libres, que tu compares toi-même à un modèle (elles ne '
                      'comptent pas pour la réussite)' : ''}.',
          ),
          const SizedBox(height: 10),
          PixelCommand(
            label: 'Commencer',
            onPressed: () => setState(() => _stage = _Stage.reading),
          ),
        ],
      ),
    ),
  ];

  List<Widget> _readingStage() => [
    if (_exam.storyTitle != null)
      Text(
        _exam.storyTitle!,
        style: TextStyle(color: GameColors.accent, fontSize: 18),
      ),
    const Text(
      'Lis le récit ; touche un mot pour voir son sens. Le récit reste '
      'affiché pendant les questions.',
    ),
    const SizedBox(height: 8),
    GradedText(sentences: _exam.story),
    const SizedBox(height: 6),
    Text(
      'Récit construit · rédigé par IA',
      style: TextStyle(color: GameColors.muted, fontSize: 13),
    ),
    const SizedBox(height: 12),
    ..._question(
      'Épreuve 1 · Lecture',
      _exam.reading[_index],
      _exam.reading.length,
    ),
  ];

  List<Widget> _question(String label, LessonQuestion q, int total) => [
    Text(
      '$label · question ${_index + 1} sur $total',
      style: TextStyle(color: GameColors.muted, fontSize: 14),
    ),
    const SizedBox(height: 4),
    QuestionView(
      key: ValueKey('examen-${_stage.name}-$_index'),
      question: q,
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

  List<Widget> _replyStage() {
    final reply = _exam.replies[_index];
    const label = 'Épreuve 3 · Répondre';
    if (reply.question != null) {
      return _question(label, reply.question!, _exam.replies.length);
    }
    final free = reply.free!;
    return [
      Text(
        '$label · réplique ${_index + 1} sur ${_exam.replies.length}',
        style: TextStyle(color: GameColors.muted, fontSize: 14),
      ),
      const SizedBox(height: 4),
      QuestionPanel(
        key: ValueKey('libre-$_index'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              free.prompt,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            ReplyLine(speaker: free.speaker, arabic: free.arabic),
            const SizedBox(height: 8),
            TextField(
              controller: _draft,
              textDirection: TextDirection.rtl,
              minLines: 1,
              maxLines: 3,
              style: const TextStyle(color: PanelColors.ink, fontSize: 22),
              decoration: const InputDecoration(
                hintText: 'Ta réponse (facultatif : tu peux aussi la dire)',
                hintTextDirection: TextDirection.ltr,
              ),
            ),
            const SizedBox(height: 8),
            if (!_showModels)
              PanelButton(
                label: 'Voir le modèle',
                onPressed: () => setState(() => _showModels = true),
              )
            else ...[
              const Text(
                'Réponse modèle :',
                style: TextStyle(color: PanelColors.muted, fontSize: 13),
              ),
              for (final m in free.models) ...[
                ArabicText(
                  m,
                  baseSize: 30,
                  style: const TextStyle(color: PanelColors.ink),
                ),
                RepeatAloud(text: m),
              ],
              if (free.explanation != null) ...[
                const SizedBox(height: 6),
                Text(free.explanation!, textAlign: TextAlign.center),
              ],
              const SizedBox(height: 8),
              const Text(
                'L\'application ne note pas ta réponse : c\'est toi qui '
                'compares avec le modèle.',
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
                    label: 'Ma réponse convient',
                    onPressed: () {
                      _freeOk++;
                      _next();
                    },
                  ),
                  PanelButton(label: 'À retravailler', onPressed: _next),
                ],
              ),
            ],
          ],
        ),
      ),
    ];
  }

  List<Widget> _result() {
    final passed = _passed;
    final free = _exam.replies.length - _exam.gradedReplies;
    return [
      PixelWindow(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              passed
                  ? (_calm
                        ? 'Examen réussi !'
                        : 'Le ${_exam.title} se dissipe : la région suivante '
                              's\'ouvre.')
                  : 'Pas encore… Rien n\'est perdu : tu peux recommencer '
                        'quand tu veux.',
              style: TextStyle(fontSize: 20, color: GameColors.accent),
            ),
            const SizedBox(height: 8),
            Text(
              'Lecture : $_reading / ${_exam.reading.length} '
              '(${_exam.readingMark} nécessaires).',
            ),
            Text(
              'Écoute : $_listening / ${_exam.listening.length} '
              '(${_exam.listeningMark} nécessaires).',
            ),
            Text(
              'Phrases remises en ordre : $_replies / ${_exam.gradedReplies} '
              '(${_exam.repliesMark} nécessaires).',
            ),
            if (free > 0)
              Text(
                'Réponses libres : tu as jugé $_freeOk réponse(s) sur $free '
                'conforme(s) au modèle (auto-évaluation, non notée).',
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
                onPressed: () => setState(_restart),
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
