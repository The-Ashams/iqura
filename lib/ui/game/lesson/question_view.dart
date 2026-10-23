/// Une question de leçon (cahier v3 §6.4) dans un panneau neutre : choix
/// sélectionné puis validé, correction visible, explication tirée des
/// données de la leçon. Aucune translittération dans les questions (§6.2).
library;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../../engines/audio/audio_service.dart';
import '../../../game/lesson/lesson.dart';
import '../../widgets/arabic_text.dart';

/// Couleurs du panneau de question (clair, neutre).
abstract final class PanelColors {
  static const background = Color(0xFFF1EDE4);
  static const ink = Color(0xFF23202C);
  static const border = Color(0xFF0D0B16);
  static const right = Color(0xFF2E7D4F);
  static const wrong = Color(0xFFB0412E);
  static const selected = Color(0xFFF2C45A);
  static const muted = Color(0xFF5E5869);
}

/// Mention de la source d'un exemple qui ne vient pas du Coran (§3.2).
class ConstructedExampleTag extends StatelessWidget {
  const ConstructedExampleTag({super.key, this.color = PanelColors.muted});

  static const String label = 'exemple construit';
  final Color color;

  @override
  Widget build(BuildContext context) =>
      Text(label, style: TextStyle(color: color, fontSize: 12));
}

/// Joue un texte arabe des leçons (voix de synthèse), s'il est enregistré.
void playLessonAudio(WidgetRef ref, String text) {
  final file = ref.read(contentDatabaseProvider).audioFile(text);
  if (file != null) ref.read(audioServiceProvider).playAsset(file);
}

/// Bouton « Écouter » avec la mention « synthèse ».
class ListenButton extends ConsumerWidget {
  const ListenButton(this.text, {super.key, this.label = 'Écouter'});

  final String text;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final available =
        ref.watch(contentDatabaseProvider).audioFile(text) != null;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FilledButton.icon(
          onPressed: available ? () => playLessonAudio(ref, text) : null,
          style: FilledButton.styleFrom(
            backgroundColor: PanelColors.ink,
            foregroundColor: PanelColors.background,
            minimumSize: const Size(150, 48),
            shape: const RoundedRectangleBorder(),
          ),
          icon: const Icon(Icons.volume_up),
          label: Text(label, style: const TextStyle(fontSize: 18)),
        ),
        Text(
          available ? 'synthèse' : 'enregistrement absent',
          style: const TextStyle(color: PanelColors.muted, fontSize: 12),
        ),
      ],
    );
  }
}

enum AnswerState { open, selected, right, wrong, closed }

class AnswerButton extends ConsumerWidget {
  const AnswerButton({
    super.key,
    required this.child,
    required this.state,
    required this.onPressed,
    this.width = 120,
    this.semanticLabel,
  });

  final Widget child;
  final AnswerState state;
  final VoidCallback onPressed;
  final double width;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (bg, fg) = switch (state) {
      AnswerState.right => (PanelColors.right, Colors.white),
      AnswerState.wrong => (PanelColors.wrong, Colors.white),
      AnswerState.selected => (PanelColors.selected, PanelColors.ink),
      _ => (Colors.white, PanelColors.ink),
    };
    final open = state == AnswerState.open || state == AnswerState.selected;
    return Semantics(
      button: true,
      selected: state == AnswerState.selected,
      label: semanticLabel,
      child: SizedBox(
        width: width,
        child: OutlinedButton(
          onPressed: open
              ? () {
                  playSfx(ref, Sfx.choix);
                  onPressed();
                }
              : null,
          style: OutlinedButton.styleFrom(
            backgroundColor: bg,
            foregroundColor: fg,
            disabledForegroundColor: fg,
            minimumSize: const Size(0, 52),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            side: const BorderSide(color: PanelColors.ink, width: 3),
            shape: const RoundedRectangleBorder(),
          ),
          child: DefaultTextStyle.merge(
            style: TextStyle(color: fg),
            child: IconTheme.merge(
              data: IconThemeData(color: fg),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

/// Bouton principal du panneau (« Valider », « Continuer »).
class PanelButton extends StatelessWidget {
  const PanelButton({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => FilledButton(
    onPressed: onPressed,
    style: FilledButton.styleFrom(
      backgroundColor: PanelColors.ink,
      foregroundColor: PanelColors.background,
      disabledBackgroundColor: const Color(0xFFD6D1C4),
      disabledForegroundColor: const Color(0xFF6B6577),
      minimumSize: const Size(160, 48),
      shape: const RoundedRectangleBorder(),
    ),
    child: Text(label, style: const TextStyle(fontSize: 20)),
  );
}

/// Panneau clair, neutre, des questions.
class QuestionPanel extends StatelessWidget {
  const QuestionPanel({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: PanelColors.background,
      border: Border.all(color: PanelColors.border, width: 3),
    ),
    child: DefaultTextStyle.merge(
      style: const TextStyle(color: PanelColors.ink, fontSize: 18),
      child: child,
    ),
  );
}

/// Une question de leçon. [onAnswered] est appelé à la validation (nul
/// pour un exercice non noté : tracer, répéter) ; [onContinue] quand le
/// joueur passe à la suite.
class QuestionView extends ConsumerStatefulWidget {
  const QuestionView({
    super.key,
    required this.question,
    required this.onContinue,
    this.onAnswered,
    this.showExplanation = true,
    this.continueLabel = 'Continuer',
    this.random,
    this.feedbackSound = true,
  });

  final LessonQuestion question;
  final void Function(bool right, Duration time)? onAnswered;
  final VoidCallback onContinue;

  /// Faux au mini-boss : les explications viennent à la revue des erreurs.
  final bool showExplanation;
  final String continueLabel;

  /// Bruitage « juste » ou « faux » à la validation (faux au mini-boss, qui
  /// joue ses propres bruitages de combat).
  final bool feedbackSound;

  /// Ordre des tuiles à reconstruire (tests : tirage reproductible).
  final Random? random;

  @override
  ConsumerState<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends ConsumerState<QuestionView> {
  final _clock = Stopwatch()..start();
  int? _selected;
  bool? _right;
  bool _done = false;

  // Reconstruire : tuiles placées (indices dans [_tiles]).
  late final List<String> _tiles;
  final List<int> _placed = [];

  // Tracer : traits dessinés.
  final List<List<Offset>> _strokes = [];

  LessonQuestion get q => widget.question;

  /// Texte joué par la question, s'il y en a un.
  String? get _spoken => switch (q.kind) {
    QuestionKind.ecouterLettre =>
      ref.read(contentDatabaseProvider).letter(q.choices[q.answer!])?.nameAr,
    QuestionKind.repeter => q.arabic,
    _ => q.audio,
  };

  @override
  void initState() {
    super.initState();
    _tiles = [...q.tiles]..shuffle(widget.random ?? Random());
    // Le son de la question est joué dès qu'elle s'affiche (§6.2).
    final spoken = _spoken;
    if (spoken != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) playLessonAudio(ref, spoken);
      });
    }
  }

  void _validate() {
    if (_right != null) return;
    _clock.stop();
    final bool right;
    if (q.kind == QuestionKind.reconstruire) {
      right = [for (final i in _placed) _tiles[i]].join() == q.solution.join();
    } else {
      right = _selected == q.answer;
    }
    if (widget.feedbackSound) playSfx(ref, right ? Sfx.juste : Sfx.faux);
    setState(() => _right = right);
    widget.onAnswered?.call(right, _clock.elapsed);
  }

  void _finishUngraded() {
    setState(() => _done = true);
    widget.onContinue();
  }

  AnswerState _stateOf(int i) {
    if (_right == null) {
      return i == _selected ? AnswerState.selected : AnswerState.open;
    }
    if (i == q.answer) return AnswerState.right;
    if (i == _selected) return AnswerState.wrong;
    return AnswerState.closed;
  }

  @override
  Widget build(BuildContext context) {
    final spoken = _spoken;
    return QuestionPanel(
      child: Column(
        children: [
          Text(
            q.prompt,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          if (q.arabic != null && q.kind != QuestionKind.repeter) ...[
            // Jamais touchable ici : le son donnerait la réponse.
            ArabicText(
              q.arabic!,
              baseSize: 52,
              style: const TextStyle(color: PanelColors.ink),
            ),
            if (q.kind == QuestionKind.lire) const ConstructedExampleTag(),
            const SizedBox(height: 8),
          ],
          if (spoken != null) ...[
            if (q.kind == QuestionKind.repeter) ...[
              ArabicText(
                q.arabic!,
                baseSize: 52,
                style: const TextStyle(color: PanelColors.ink),
              ),
              const SizedBox(height: 6),
            ],
            ListenButton(spoken, label: 'Réécouter'),
            const SizedBox(height: 12),
          ],
          ..._body(),
          if (_right != null) ..._feedback(),
        ],
      ),
    );
  }

  List<Widget> _body() => switch (q.kind) {
    QuestionKind.reconstruire => _rebuild(),
    QuestionKind.tracer => _trace(),
    QuestionKind.repeter => _repeat(),
    _ => _choices(),
  };

  List<Widget> _choices() {
    final wide = q.choiceKind == ChoiceKind.text;
    return [
      Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: [
          for (final (i, c) in q.choices.indexed)
            AnswerButton(
              width: wide
                  ? 260
                  : q.choiceKind == ChoiceKind.audio
                  ? 150
                  : 120,
              state: _stateOf(i),
              semanticLabel: q.choiceKind == ChoiceKind.audio
                  ? 'Son ${i + 1}'
                  : null,
              onPressed: () {
                if (q.choiceKind == ChoiceKind.audio) playLessonAudio(ref, c);
                setState(() => _selected = i);
              },
              child: switch (q.choiceKind) {
                ChoiceKind.arabic => ArabicText(c, baseSize: 30),
                ChoiceKind.audio => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.volume_up),
                    const SizedBox(width: 6),
                    Text('Son ${i + 1}', style: const TextStyle(fontSize: 18)),
                  ],
                ),
                _ => Text(
                  c,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
              },
            ),
        ],
      ),
      if (q.choiceKind == ChoiceKind.audio)
        const Padding(
          padding: EdgeInsets.only(top: 4),
          child: Text(
            'Touche un son pour l\'écouter et le choisir (synthèse).',
            style: TextStyle(color: PanelColors.muted, fontSize: 13),
          ),
        ),
      if (_right == null) ...[
        const SizedBox(height: 12),
        PanelButton(
          label: 'Valider',
          onPressed: _selected == null ? null : _validate,
        ),
      ],
    ];
  }

  List<Widget> _rebuild() {
    final open = _right == null;
    return [
      Container(
        constraints: const BoxConstraints(minHeight: 72, minWidth: 220),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border.all(color: PanelColors.ink, width: 2),
          color: Colors.white,
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Wrap(
            spacing: 4,
            children: [
              for (final (k, i) in _placed.indexed)
                InkWell(
                  onTap: open
                      ? () => setState(() => _placed.removeAt(k))
                      : null,
                  child: ArabicText(
                    _tiles[i],
                    baseSize: 40,
                    style: const TextStyle(color: PanelColors.ink),
                  ),
                ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 4),
      const Text(
        'Touche les morceaux dans l\'ordre (de droite à gauche). Touche un '
        'morceau placé pour le retirer.',
        textAlign: TextAlign.center,
        style: TextStyle(color: PanelColors.muted, fontSize: 13),
      ),
      const SizedBox(height: 8),
      Directionality(
        textDirection: TextDirection.rtl,
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: [
            for (final (i, t) in _tiles.indexed)
              AnswerButton(
                width: 80,
                state: _placed.contains(i) || !open
                    ? AnswerState.closed
                    : AnswerState.open,
                onPressed: () => setState(() => _placed.add(i)),
                child: ArabicText(t, baseSize: 30),
              ),
          ],
        ),
      ),
      if (open) ...[
        const SizedBox(height: 12),
        PanelButton(
          label: 'Valider',
          onPressed: _placed.isEmpty ? null : _validate,
        ),
      ],
    ];
  }

  List<Widget> _trace() => [
    SizedBox(
      width: 240,
      height: 240,
      child: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: ArabicText(
                q.letter!,
                baseSize: 150,
                style: const TextStyle(color: Color(0x33000000)),
              ),
            ),
          ),
          Positioned.fill(
            child: GestureDetector(
              key: const Key('trace-pad'),
              onPanStart: (d) =>
                  setState(() => _strokes.add([d.localPosition])),
              onPanUpdate: (d) =>
                  setState(() => _strokes.last.add(d.localPosition)),
              child: CustomPaint(painter: _StrokePainter(_strokes)),
            ),
          ),
        ],
      ),
    ),
    const Text(
      'Repasse la lettre avec le doigt, dans le sens de l\'écriture. Tracé '
      'libre, sans vérification : les points numérotés arriveront plus tard.',
      textAlign: TextAlign.center,
      style: TextStyle(color: PanelColors.muted, fontSize: 13),
    ),
    const SizedBox(height: 8),
    if (!_done)
      Wrap(
        spacing: 10,
        children: [
          OutlinedButton(
            onPressed: _strokes.isEmpty ? null : () => setState(_strokes.clear),
            child: const Text('Effacer'),
          ),
          PanelButton(
            label: 'J\'ai tracé',
            onPressed: _strokes.isEmpty ? null : _finishUngraded,
          ),
        ],
      ),
  ];

  List<Widget> _repeat() => [
    const Text(
      'Écoute, puis répète à voix haute. Il n\'y a pas de note : '
      'l\'enregistrement de ta voix pour comparer arrivera plus tard.',
      textAlign: TextAlign.center,
      style: TextStyle(color: PanelColors.muted, fontSize: 13),
    ),
    const SizedBox(height: 8),
    if (!_done)
      PanelButton(label: 'Je l\'ai répété', onPressed: _finishUngraded),
  ];

  List<Widget> _feedback() => [
    const SizedBox(height: 12),
    Text(
      _right! ? 'Juste !' : 'Pas tout à fait.',
      style: TextStyle(
        fontSize: 20,
        color: _right! ? PanelColors.right : PanelColors.wrong,
      ),
    ),
    if (q.kind == QuestionKind.reconstruire && !_right!) ...[
      const Text('Le mot était :'),
      ArabicText(
        q.solution.join(),
        baseSize: 40,
        style: const TextStyle(color: PanelColors.ink),
      ),
    ],
    if (widget.showExplanation && q.explanation != null) ...[
      const SizedBox(height: 6),
      Text(q.explanation!, textAlign: TextAlign.center),
    ],
    const SizedBox(height: 10),
    PanelButton(label: widget.continueLabel, onPressed: widget.onContinue),
  ];
}

class _StrokePainter extends CustomPainter {
  _StrokePainter(this.strokes);

  final List<List<Offset>> strokes;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = PanelColors.ink
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    for (final s in strokes) {
      if (s.length == 1) {
        canvas.drawCircle(s.first, 4, paint..style = PaintingStyle.fill);
        paint.style = PaintingStyle.stroke;
        continue;
      }
      final path = Path()..moveTo(s.first.dx, s.first.dy);
      for (final p in s.skip(1)) {
        path.lineTo(p.dx, p.dy);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_StrokePainter old) => true;
}
