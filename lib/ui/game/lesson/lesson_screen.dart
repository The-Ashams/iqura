/// Lecteur de leçons au format mini-donjon (cahier v3 §6.1) : les écrans
/// s'enchaînent dans l'ordre des données, la progression est sauvegardée à
/// chaque écran, et la leçon suivante s'ouvre quand le mini-boss est réussi.
library;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../../features/progress/lesson_progress.dart';
import '../../../game/lesson/lesson.dart';
import '../../../game/world.dart';
import '../../../game/world_providers.dart';
import '../../widgets/arabic_text.dart';
import '../grimoire_screen.dart';
import '../pixel.dart';
import '../report_error.dart';
import '../sprites.dart';
import 'boss_view.dart';
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
    if (_scroll.hasClients) _scroll.jumpTo(0);
  }

  void _next() => _goTo(min(_step + 1, _lesson.steps.length - 1));

  String get _stepName => switch (_lesson.steps[_step]) {
    EntryStep() => 'Entrée',
    ExplainStep(kind: ExplainKind.discovery) => 'Découverte',
    ExplainStep(kind: ExplainKind.element) => 'Les éléments',
    ExplainStep(kind: ExplainKind.rule) => 'La règle',
    PracticeStep(warmUp: true) => 'Échauffement',
    PracticeStep() => 'Salle d\'entraînement',
    QuranStep() => 'Salle d\'étude « Dans le Coran »',
    BossStep() => 'Mini-boss',
    EndStep() => 'Fin',
  };

  @override
  Widget build(BuildContext context) {
    final step = _lesson.steps[_step];
    final subject =
        'Leçon ${_lesson.ordinal} « ${_lesson.title} », écran ${_step + 1} '
        '($_stepName)';
    return Scaffold(
      backgroundColor: GameColors.night,
      appBar: AppBar(
        title: Text('Leçon ${_lesson.ordinal} · ${_lesson.title}'),
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
                      style: const TextStyle(
                        color: GameColors.accent,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(
                    'Écran ${_step + 1} / ${_lesson.steps.length}',
                    style: const TextStyle(
                      color: GameColors.muted,
                      fontSize: 14,
                    ),
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
    QuranStep() => _QuranView(step: step, onNext: _next),
    BossStep() => BossView(
      step: step,
      adversary: ref.read(currentRegionProvider).adversary,
      failuresBefore:
          ref.read(lessonProgressProvider)[_lesson.id]?.bossFailures ?? 0,
      random: widget.random,
      onResult: ({required passed, required score}) => ref
          .read(lessonProgressProvider.notifier)
          .recordBoss(_lesson.id, score: score, passed: passed),
      onVictoryContinue: _next,
      onReplayPractice: () {
        final i = _lesson.steps.lastIndexWhere(
          (s) => s is PracticeStep && !s.warmUp,
        );
        if (i >= 0) _goTo(i);
      },
    ),
    EndStep() => _EndView(lesson: _lesson, step: step),
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
  int _line = 0;

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
        if (place?.sceneImage != null)
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
                  style: const TextStyle(
                    color: GameColors.accent,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 6),
                Text(line.text, style: const TextStyle(height: 1.4)),
                const SizedBox(height: 8),
                PixelCommand(
                  label: 'Suite',
                  onPressed: () => setState(() => _line++),
                ),
              ] else ...[
                const Text(
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
                    style: const TextStyle(
                      color: GameColors.accent,
                      fontSize: 22,
                    ),
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
                          size: s.kind == ExplainKind.discovery ? 64 : 44,
                        ),
                    ],
                  ),
                  const ConstructedExampleTag(color: GameColors.muted),
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
            style: const TextStyle(color: GameColors.text),
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
                      style: const TextStyle(color: GameColors.text),
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                        color: GameColors.muted,
                        fontSize: 14,
                      ),
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
            child: Text(
              card.zone,
              style: const TextStyle(color: GameColors.accent),
            ),
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
              style: const TextStyle(fontSize: 20, color: GameColors.accent),
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
          style: const TextStyle(color: GameColors.muted, fontSize: 14),
        ),
        const SizedBox(height: 4),
        QuestionView(
          key: ValueKey('ex-$_index'),
          question: _queue[_index],
          onAnswered: _answered,
          onContinue: () => setState(() => _index++),
          random: widget.random,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// 7. Salle d'étude « Dans le Coran » : lieu calme, sans combat. Le texte vient
// de la base vérifiée (Tanzil) ; rien n'est recopié dans la leçon.

class _QuranView extends ConsumerStatefulWidget {
  const _QuranView({required this.step, required this.onNext});

  final QuranStep step;
  final VoidCallback onNext;

  static const String credit =
      'Texte : Tanzil (copie vérifiée). Traduction : Muhammad Hamidullah, '
      'version diffusée par Tanzil (édition non précisée).';
  static const String recitationNotice =
      "Récitation d'al-Ḥuṣarī : pas encore disponible.";

  @override
  ConsumerState<_QuranView> createState() => _QuranViewState();
}

class _QuranViewState extends ConsumerState<_QuranView> {
  int _extract = 0;
  String? _tapped;
  int? _selected;
  bool? _right;

  QuranExtract get _e => widget.step.extracts[_extract];

  void _nextExtract() {
    if (_extract + 1 >= widget.step.extracts.length) {
      widget.onNext();
      return;
    }
    setState(() {
      _extract++;
      _tapped = null;
      _selected = null;
      _right = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(contentDatabaseProvider);
    final verse = db.verse(_e.surah, _e.ayah);
    final tokens = db.verseTokens(_e.surah, _e.ayah);
    final q = _e.question;
    final cited = _e.tokens.toSet();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: const SceneView(background: 'scene_sanctuaire'),
        ),
        const SizedBox(height: 12),
        PixelWindow(child: Text(widget.step.text)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF6EFDF),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                textDirection: TextDirection.rtl,
                spacing: 10,
                runSpacing: 4,
                children: [
                  for (final t in tokens)
                    _QuranWord(
                      token: t,
                      highlighted: q.kind == QuestionKind.repererMot
                          ? _tapped == t.id ||
                                (_right != null && t.id == q.token)
                          : cited.contains(t.id),
                      onTap: q.kind == QuestionKind.repererMot && _right == null
                          ? () => setState(() => _tapped = t.id)
                          : null,
                    ),
                ],
              ),
              if (verse != null) ...[
                const SizedBox(height: 6),
                Text(
                  '${verse.surah}:${verse.ayah} — ${verse.translation}',
                  style: const TextStyle(
                    color: Color(0xFF4A3F33),
                    fontFamily: 'Amiri',
                    fontSize: 17,
                    height: 1.4,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          '${_QuranView.credit} ${_QuranView.recitationNotice}',
          style: TextStyle(color: GameColors.muted, fontSize: 13),
        ),
        const SizedBox(height: 12),
        if (q.kind == QuestionKind.repererMot)
          _locate(q)
        else if (q.kind == QuestionKind.compter)
          _count(q, db.tokenText(q.token!) ?? ''),
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
            'Touche un mot du verset, puis valide.',
            style: TextStyle(color: PanelColors.muted, fontSize: 13),
          ),
          const SizedBox(height: 8),
          PanelButton(
            label: 'Valider',
            onPressed: _tapped == null
                ? null
                : () => setState(() => _right = _tapped == q.token),
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
            quran: true,
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
                  : () => setState(() => _right = _selected == n),
            ),
          ] else
            ..._feedback(
              'Ce mot contient $n fois la lettre ${q.letter}. D\'autres '
              'petits signes l\'accompagnent : tu les apprendras plus tard.',
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
    PanelButton(label: 'Continuer', onPressed: _nextExtract),
  ];
}

class _QuranWord extends StatelessWidget {
  const _QuranWord({
    required this.token,
    required this.highlighted,
    required this.onTap,
  });

  final QuranToken token;
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
          token.text,
          quran: true,
          baseSize: 30,
          style: const TextStyle(color: Color(0xFF2A1F18)),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// 9. Fin : l'obstacle s'ouvre, ce que le joueur sait lire maintenant.

class _EndView extends ConsumerWidget {
  const _EndView({required this.lesson, required this.step});

  final Lesson lesson;
  final EndStep step;

  static const String rewardsNotice =
      'Récompenses et cartes de révision : arrivent à l\'étape 6 du jalon '
      'J1a.';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          const Text(
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
              'Leçon ${next.ordinal} ouverte : ${next.title}.',
              style: const TextStyle(color: GameColors.good),
            ),
          const Text(
            rewardsNotice,
            style: TextStyle(color: GameColors.muted, fontSize: 14),
          ),
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
