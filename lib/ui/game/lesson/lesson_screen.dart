/// Lecteur de leçons au format mini-donjon (cahier v3 §6.1) : les écrans
/// s'enchaînent dans l'ordre des données, la progression est sauvegardée à
/// chaque écran, et la leçon suivante s'ouvre quand le mini-boss est réussi.
library;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../../engines/audio/audio_service.dart';
import '../../../features/progress/lesson_progress.dart';
import '../../../features/resources/resources.dart';
import '../../../features/review/review.dart';
import '../../../features/settings/settings.dart';
import '../../../game/lesson/lesson.dart';
import '../../../game/world_providers.dart';
import '../../widgets/arabic_text.dart';
import '../grimoire_screen.dart';
import '../pixel.dart';
import '../report_error.dart';
import '../sprites.dart';
import 'boss_view.dart';
import 'fondations_views.dart';
import 'question_view.dart';

class LessonScreen extends ConsumerStatefulWidget {
  const LessonScreen({super.key, required this.lessonId, this.random});

  final String lessonId;

  /// Pour les tests (ordre des tuiles et du mini-boss).
  final Random? random;

  @override
  ConsumerState<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends ConsumerState<LessonScreen> {
  late final Lesson _lesson;
  late int _step;
  final _scroll = ScrollController();

  /// Récompense du dernier mini-boss réussi, montrée à l'écran de fin.
  LessonReward? _reward;

  void _onBossResult({required bool passed, required int score}) {
    final before = ref.read(lessonProgressProvider)[_lesson.id];
    final first = !(before?.completed ?? false);
    ref
        .read(lessonProgressProvider.notifier)
        .recordBoss(_lesson.id, score: score, passed: passed);
    _recordActivity();
    if (!passed) return;
    _reward = rewardLesson(
      _lesson,
      first: first,
      resources: ref.read(resourceRepositoryProvider),
      reviews: ref.read(reviewRepositoryProvider),
    );
    ref.read(walletProvider.notifier).refresh();
    ref.read(dueCountProvider.notifier).refresh();
  }

  void _recordActivity() {
    ref.read(resourceRepositoryProvider).recordActivity();
    ref.read(walletProvider.notifier).refresh();
  }

  @override
  void initState() {
    super.initState();
    _lesson = ref.read(contentDatabaseProvider).lesson(widget.lessonId)!;
    final saved = ref.read(lessonProgressProvider)[widget.lessonId];
    // Reprise à l'écran sauvegardé ; une leçon terminée se rejoue du début.
    _step = saved == null || saved.completed
        ? 0
        : saved.step.clamp(0, _lesson.steps.length - 1);
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _goTo(int step) {
    setState(() => _step = step);
    ref.read(lessonProgressProvider.notifier).saveStep(_lesson.id, step);
    _recordActivity();
    if (_scroll.hasClients) _scroll.jumpTo(0);
  }

  void _next() => _goTo(min(_step + 1, _lesson.steps.length - 1));

  String get _stepName => switch (_lesson.steps[_step]) {
    EntryStep() => 'Entrée',
    ExplainStep(kind: ExplainKind.discovery) => 'Découverte',
    ExplainStep(kind: ExplainKind.element) => 'Les éléments',
    ExplainStep(kind: ExplainKind.rule) => 'La règle',
    PracticeStep(warmUp: true) => 'Échauffement',
    PracticeStep(atelier: true) => 'L\'Atelier des phrases',
    DialogueStep() => 'Dialogue',
    WordsStep() => 'Les mots',
    PracticeStep() => 'Salle d\'entraînement',
    ReadingStep() => 'Salle de lecture',
    BossStep() => 'Mini-boss',
    EndStep() => 'Fin',
  };

  @override
  Widget build(BuildContext context) {
    final step = _lesson.steps[_step];
    final subject =
        'Leçon ${lessonNumber(_lesson.stage, _lesson.ordinal)} « ${_lesson.title} », écran ${_step + 1} '
        '($_stepName)';
    return Scaffold(
      backgroundColor: GameColors.night,
      appBar: AppBar(
        title: Text(
          'Leçon ${lessonNumber(_lesson.stage, _lesson.ordinal)} · '
          '${_lesson.title}',
        ),
        backgroundColor: GameColors.night,
        foregroundColor: GameColors.text,
      ),
      body: SafeArea(
        child: GameBody(
          child: ListView(
            controller: _scroll,
            padding: const EdgeInsets.all(12),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _stepName,
                      style: TextStyle(color: GameColors.accent, fontSize: 18),
                    ),
                  ),
                  Text(
                    'Écran ${_step + 1} / ${_lesson.steps.length}',
                    style: TextStyle(color: GameColors.muted, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              KeyedSubtree(key: ValueKey(_step), child: _stepView(step)),
              const SizedBox(height: 12),
              Row(
                children: [
                  const AiTag(),
                  const Spacer(),
                  ReportErrorButton(subject: subject),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stepView(LessonStep step) => switch (step) {
    EntryStep() => _EntryView(lesson: _lesson, step: step, onNext: _next),
    ExplainStep() => _ExplainView(
      step: step,
      onNext: _next,
      random: widget.random,
    ),
    PracticeStep() => _PracticeView(
      step: step,
      onNext: _next,
      random: widget.random,
    ),
    DialogueStep() => DialogueView(step: step, onNext: _next),
    WordsStep() => WordsView(step: step, onNext: _next),
    ReadingStep() => _ReadingView(lesson: _lesson, step: step, onNext: _next),
    BossStep() => BossView(
      step: step,
      adversary: ref.read(currentRegionProvider).adversary,
      failuresBefore:
          ref.read(lessonProgressProvider)[_lesson.id]?.bossFailures ?? 0,
      random: widget.random,
      noCombat: _lesson.noCombat,
      onResult: _onBossResult,
      onVictoryContinue: _next,
      onReplayPractice: () {
        final i = _lesson.steps.lastIndexWhere(
          (s) => s is PracticeStep && !s.warmUp,
        );
        if (i >= 0) _goTo(i);
      },
    ),
    EndStep() => _EndView(lesson: _lesson, step: step, reward: _reward),
  };
}

// ---------------------------------------------------------------------------
// 1. Entrée : le maître devant l'obstacle.

class _EntryView extends ConsumerStatefulWidget {
  const _EntryView({
    required this.lesson,
    required this.step,
    required this.onNext,
  });

  final Lesson lesson;
  final EntryStep step;
  final VoidCallback onNext;

  @override
  ConsumerState<_EntryView> createState() => _EntryViewState();
}

class _EntryViewState extends ConsumerState<_EntryView> {
  // Apprentissage seul : pas de scène d'Histoire, directement l'objectif.
  late int _line = ref.read(settingsProvider).learningOnly
      ? widget.step.lines.length
      : 0;

  @override
  Widget build(BuildContext context) {
    final place = ref
        .watch(regionPlacesProvider)
        .where((p) => p.id == widget.lesson.place)
        .firstOrNull;
    final characters = {
      for (final c in ref.watch(regionCharactersProvider)) c.id: c,
    };
    final master = characters[widget.lesson.master];
    final lines = widget.step.lines;
    final finished = _line >= lines.length;
    final line = finished ? null : lines[_line];
    final speaker = line == null ? null : characters[line.speaker];
    final ground = (place?.groundY ?? 62).toDouble();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (place?.sceneImage != null &&
            !ref.watch(settingsProvider.select((s) => s.learningOnly)))
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SceneView(
              background: place!.sceneImage!,
              parts: [
                if (master?.sprite != null)
                  _sprite(master!.sprite!, 40, ground),
                _sprite('voyageur', 112, ground),
              ],
            ),
          ),
        const SizedBox(height: 12),
        PixelWindow(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (line != null) ...[
                Text(
                  speaker?.name ?? line.speaker,
                  style: TextStyle(color: GameColors.accent, fontSize: 20),
                ),
                const SizedBox(height: 6),
                Text(line.text, style: const TextStyle(height: 1.4)),
                const SizedBox(height: 8),
                PixelCommand(
                  label: 'Suite',
                  onPressed: () => setState(() => _line++),
                ),
              ] else ...[
                Text(
                  'Objectif',
                  style: TextStyle(color: GameColors.accent, fontSize: 20),
                ),
                const SizedBox(height: 6),
                Text(widget.step.objective),
                const SizedBox(height: 8),
                PixelCommand(label: 'Entrer', onPressed: widget.onNext),
              ],
            ],
          ),
        ),
      ],
    );
  }

  static ScenePart _sprite(String name, double x, double ground) {
    final (w, h) = spriteSizes[name]!;
    return ScenePart(
      x: x,
      y: ground - h,
      width: w.toDouble(),
      height: h.toDouble(),
      child: PixelImage(name, fit: BoxFit.fill),
    );
  }
}

// ---------------------------------------------------------------------------
// 3 à 5. Découverte, éléments, règle : une explication courte puis sa
// question.

class _ExplainView extends ConsumerStatefulWidget {
  const _ExplainView({required this.step, required this.onNext, this.random});

  final ExplainStep step;
  final VoidCallback onNext;
  final Random? random;

  @override
  ConsumerState<_ExplainView> createState() => _ExplainViewState();
}

class _ExplainViewState extends ConsumerState<_ExplainView> {
  @override
  void initState() {
    super.initState();
    // Chaque nouvel élément est joué automatiquement (§6.2) : le nom de la
    // lettre présentée.
    final letter = widget.step.letter;
    if (widget.step.kind == ExplainKind.element && letter != null) {
      final card = ref.read(contentDatabaseProvider).letter(letter);
      if (card != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) playLessonAudio(ref, card.nameAr);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.step;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (s.kind == ExplainKind.element)
          _LetterCardView(letter: s.letter!)
        else
          PixelWindow(
            child: Column(
              children: [
                if (s.title != null)
                  Text(
                    s.title!,
                    style: TextStyle(color: GameColors.accent, fontSize: 22),
                  ),
                if (s.text != null) ...[
                  const SizedBox(height: 6),
                  Text(s.text!, style: const TextStyle(height: 1.4)),
                ],
                if (s.arabic.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 24,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: [
                      for (final a in s.arabic)
                        SpokenArabic(
                          a,
                          mushaf: s.mushaf,
                          size: s.kind == ExplainKind.discovery ? 64 : 44,
                        ),
                    ],
                  ),
                  ConstructedExampleTag(color: GameColors.muted),
                ],
              ],
            ),
          ),
        const SizedBox(height: 12),
        QuestionView(
          question: s.question,
          onContinue: widget.onNext,
          random: widget.random,
        ),
      ],
    );
  }
}

/// Fiche d'une lettre (écran « élément ») : grande lettre, formes, nom
/// écouté, articulation. Le nom arabe écrit n'est pas affiché : il utilise
/// la hamza, enseignée plus tard (relecture du 23/10/2026).
class _LetterCardView extends ConsumerWidget {
  const _LetterCardView({required this.letter});

  final String letter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final card = ref.watch(contentDatabaseProvider).letter(letter);
    if (card == null) return const SizedBox.shrink();
    return PixelWindow(
      child: Column(
        children: [
          ArabicText(
            card.letter,
            baseSize: 80,
            style: TextStyle(color: GameColors.text),
          ),
          Text(card.name, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 6),
          ListenButton(card.nameAr, label: 'Son nom'),
          const SizedBox(height: 10),
          Wrap(
            spacing: 18,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              for (final (name, glyph) in LetterSheet.formsOf(card))
                Column(
                  children: [
                    ArabicText(
                      glyph,
                      baseSize: 40,
                      style: TextStyle(color: GameColors.text),
                    ),
                    Text(
                      name,
                      style: TextStyle(color: GameColors.muted, fontSize: 14),
                    ),
                  ],
                ),
            ],
          ),
          if (!card.joinsLeft)
            const Padding(
              padding: EdgeInsets.only(top: 6),
              child: Text('Ne se lie pas à la lettre suivante.'),
            ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(card.zone, style: TextStyle(color: GameColors.accent)),
          ),
          const SizedBox(height: 4),
          Text(card.pronunciation, style: const TextStyle(height: 1.4)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 6. Salle d'entraînement (et échauffement) : chaque erreur est expliquée et
// la question revient plus tard.

class _PracticeView extends StatefulWidget {
  const _PracticeView({required this.step, required this.onNext, this.random});

  final PracticeStep step;
  final VoidCallback onNext;
  final Random? random;

  @override
  State<_PracticeView> createState() => _PracticeViewState();
}

class _PracticeViewState extends State<_PracticeView> {
  late final List<LessonQuestion> _queue = [...widget.step.exercises];
  final Set<LessonQuestion> _requeued = {};
  int _index = 0;

  void _answered(bool right, Duration _) {
    final q = _queue[_index];
    // Une erreur : la question revient en fin de salle (une fois).
    if (!right && _requeued.add(q)) _queue.add(q);
  }

  @override
  Widget build(BuildContext context) {
    if (_index >= _queue.length) {
      return PixelWindow(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.step.warmUp
                  ? 'Échauffement terminé.'
                  : 'Salle d\'entraînement terminée.',
              style: TextStyle(fontSize: 20, color: GameColors.accent),
            ),
            const SizedBox(height: 8),
            PixelCommand(label: 'Continuer', onPressed: widget.onNext),
          ],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Exercice ${_index + 1} sur ${_queue.length}',
          style: TextStyle(color: GameColors.muted, fontSize: 14),
        ),
        const SizedBox(height: 4),
        QuestionView(
          key: ValueKey('ex-$_index'),
          question: _queue[_index],
          onAnswered: _answered,
          onContinue: () => setState(() => _index++),
          random: widget.random,
          // Question revenue après une erreur : réponses déplacées.
          shuffleChoices: _queue.indexOf(_queue[_index]) != _index,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// 7. Salle de lecture (avenant n° 1) : lieu calme, sans combat. Une
// inscription d'exemples construits, faite de mots déjà lus ; aucun verset ni
// extrait coranique.

class _ReadingView extends ConsumerStatefulWidget {
  const _ReadingView({
    required this.lesson,
    required this.step,
    required this.onNext,
  });

  final Lesson lesson;
  final ReadingStep step;
  final VoidCallback onNext;

  static const String source = 'Exemple construit';

  @override
  ConsumerState<_ReadingView> createState() => _ReadingViewState();
}

class _ReadingViewState extends ConsumerState<_ReadingView> {
  int _question = 0;
  int? _tapped;
  int? _selected;
  bool? _right;

  LessonQuestion get _q => widget.step.questions[_question];

  void _answer(bool right) {
    playSfx(ref, right ? Sfx.juste : Sfx.faux);
    setState(() => _right = right);
  }

  void _nextQuestion() {
    if (_question + 1 >= widget.step.questions.length) {
      widget.onNext();
      return;
    }
    setState(() {
      _question++;
      _tapped = null;
      _selected = null;
      _right = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final place = ref
        .watch(regionPlacesProvider)
        .where((p) => p.id == widget.lesson.place)
        .firstOrNull;
    final q = _q;
    final words = widget.step.inscription;
    final locate = q.kind == QuestionKind.repererMot;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (place?.sceneImage != null &&
            !ref.watch(settingsProvider.select((s) => s.learningOnly)))
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SceneView(background: place!.sceneImage!),
          ),
        const SizedBox(height: 12),
        PixelWindow(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.step.title != null)
                Text(
                  widget.step.title!,
                  style: TextStyle(color: GameColors.accent, fontSize: 18),
                ),
              Text(widget.step.text),
            ],
          ),
        ),
        const SizedBox(height: 12),
        if (widget.step.sentences.isNotEmpty)
          GradedText(sentences: widget.step.sentences)
        else
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF6EFDF),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Wrap(
              alignment: WrapAlignment.center,
              textDirection: TextDirection.rtl,
              spacing: 14,
              runSpacing: 4,
              children: [
                for (final (i, w) in words.indexed)
                  _InscriptionWord(
                    text: w,
                    mushaf: widget.step.mushaf,
                    highlighted: locate
                        ? _tapped == i || (_right != null && i == q.word)
                        : q.kind == QuestionKind.compter && i == q.word,
                    onTap: locate && _right == null
                        ? () {
                            playSfx(ref, Sfx.choix);
                            setState(() => _tapped = i);
                          }
                        : null,
                  ),
              ],
            ),
          ),
        const SizedBox(height: 6),
        Text(
          '${_ReadingView.source} · rédigé par IA',
          style: TextStyle(color: GameColors.muted, fontSize: 13),
        ),
        const SizedBox(height: 12),
        if (locate)
          _locate(q)
        else if (q.kind == QuestionKind.compter)
          _count(q, words[q.word!])
        else
          QuestionView(
            key: ValueKey('lecture-$_question'),
            question: q,
            onContinue: _nextQuestion,
          ),
      ],
    );
  }

  Widget _locate(LessonQuestion q) => QuestionPanel(
    child: Column(
      children: [
        Text(q.prompt, textAlign: TextAlign.center),
        if (_right == null) ...[
          const SizedBox(height: 8),
          const Text(
            'Touche un mot de l\'inscription, puis valide.',
            style: TextStyle(color: PanelColors.muted, fontSize: 13),
          ),
          const SizedBox(height: 8),
          PanelButton(
            label: 'Valider',
            onPressed: _tapped == null
                ? null
                : () => _answer(_tapped == q.word),
          ),
        ] else
          ..._feedback(q.explanation),
      ],
    ),
  );

  Widget _count(LessonQuestion q, String word) {
    final n = countLetter(word, q.letter!);
    const choices = [1, 2, 3, 4];
    return QuestionPanel(
      child: Column(
        children: [
          Text(q.prompt, textAlign: TextAlign.center),
          const SizedBox(height: 8),
          ArabicText(
            word,
            mushaf: widget.step.mushaf,
            baseSize: 44,
            style: const TextStyle(color: PanelColors.ink),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            children: [
              for (final c in choices)
                AnswerButton(
                  width: 64,
                  state: _right == null
                      ? (c == _selected
                            ? AnswerState.selected
                            : AnswerState.open)
                      : c == n
                      ? AnswerState.right
                      : c == _selected
                      ? AnswerState.wrong
                      : AnswerState.closed,
                  onPressed: () => setState(() => _selected = c),
                  child: Text('$c', style: const TextStyle(fontSize: 22)),
                ),
            ],
          ),
          if (_right == null) ...[
            const SizedBox(height: 12),
            PanelButton(
              label: 'Valider',
              onPressed: _selected == null
                  ? null
                  : () => _answer(_selected == n),
            ),
          ] else
            ..._feedback(
              frenchWithArabic(
                'Ce mot contient $n fois '
                '${isArabicMark(q.letter!) ? 'le signe' : 'la lettre'} '
                '${showMark(q.letter!)}.',
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _feedback(String? explanation) => [
    const SizedBox(height: 8),
    Text(
      _right! ? 'Juste !' : 'Pas tout à fait.',
      style: TextStyle(
        fontSize: 20,
        color: _right! ? PanelColors.right : PanelColors.wrong,
      ),
    ),
    if (explanation != null) Text(explanation, textAlign: TextAlign.center),
    const SizedBox(height: 8),
    PanelButton(label: 'Continuer', onPressed: _nextQuestion),
  ];
}

class _InscriptionWord extends StatelessWidget {
  const _InscriptionWord({
    required this.text,
    required this.highlighted,
    required this.onTap,
    this.mushaf = false,
  });

  final String text;
  final bool mushaf;
  final bool highlighted;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: onTap != null,
    selected: highlighted,
    child: InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: highlighted ? const Color(0x55F2C45A) : null,
          borderRadius: BorderRadius.circular(4),
        ),
        child: ArabicText(
          text,
          mushaf: mushaf,
          baseSize: 32,
          style: const TextStyle(color: Color(0xFF2A1F18)),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// 9. Fin : l'obstacle s'ouvre, ce que le joueur sait lire maintenant.

class _EndView extends ConsumerStatefulWidget {
  const _EndView({required this.lesson, required this.step, this.reward});

  final Lesson lesson;
  final EndStep step;
  final LessonReward? reward;

  @override
  ConsumerState<_EndView> createState() => _EndViewState();
}

class _EndViewState extends ConsumerState<_EndView> {
  Lesson get lesson => widget.lesson;
  EndStep get step => widget.step;

  @override
  void initState() {
    super.initState();
    // L'obstacle s'ouvre : un sceau se brise.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) playSfx(ref, Sfx.sceau);
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = ref.watch(lessonProgressProvider);
    final completed = progress[lesson.id]?.completed ?? false;
    final stage = ref.watch(contentDatabaseProvider).lessons(lesson.stage);
    final next = stage
        .where((l) => l.ordinal == lesson.ordinal + 1)
        .firstOrNull;
    return PixelWindow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ce que tu sais lire maintenant',
            style: TextStyle(color: GameColors.accent, fontSize: 20),
          ),
          const SizedBox(height: 6),
          Text(step.learned, style: const TextStyle(height: 1.4)),
          if (step.next != null) ...[
            const SizedBox(height: 8),
            Text(step.next!, style: const TextStyle(height: 1.4)),
          ],
          const SizedBox(height: 8),
          if (completed && next != null)
            Text(
              'Leçon ${next.number} ouverte : ${next.title}.',
              style: TextStyle(color: GameColors.good),
            ),
          if (widget.reward case final r?) ...[
            const SizedBox(height: 6),
            Text(
              r.first
                  ? 'Récompenses : +${r.xp} XP, +${r.dinars} dinars, '
                        '+${r.ink} encre de scribe.'
                        '${r.newCards > 0 ? ' ${r.newCards} nouvelles cartes à réviser dans l\'Expédition (Faille des Oubliés).' : ''}'
                  : r.xp > 0
                  ? 'Leçon rejouée : +${r.xp} XP.'
                  : 'Leçon rejouée (XP déjà reçue aujourd\'hui).',
              style: TextStyle(color: GameColors.accent),
            ),
          ],
          const SizedBox(height: 8),
          PixelCommand(
            label: 'Reprendre l\'Histoire',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
