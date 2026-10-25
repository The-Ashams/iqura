/// Une question de leçon (cahier v3 §6.4) dans un panneau neutre : choix
/// sélectionné puis validé, correction visible, explication tirée des
/// données de la leçon. Aucune translittération dans les questions (§6.2).
library;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../../engines/audio/audio_service.dart';
import '../../../engines/voice/voice_recorder.dart';
import '../../../game/lesson/lesson.dart';
import '../../../game/lesson/trace.dart';
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

/// Mention de la source d'un exemple construit (§3.2).
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

/// Ordre d'affichage de [count] réponses. Sans [shuffle], l'ordre écrit
/// dans la leçon ; avec, un ordre mélangé où la bonne réponse ([answer])
/// change de place quand c'est possible.
List<int> shuffledChoiceOrder(
  int count,
  int? answer,
  Random random, {
  required bool shuffle,
}) {
  final order = List<int>.generate(count, (i) => i);
  if (!shuffle || count < 2) return order;
  for (var attempt = 0; attempt < 20; attempt++) {
    order.shuffle(random);
    final moved = answer == null
        ? order.indexed.any((e) => e.$1 != e.$2)
        : order.indexOf(answer) != answer;
    if (moved) return order;
  }
  // Tirage malchanceux : on décale tout d'un cran.
  return List<int>.generate(count, (i) => (i + 1) % count);
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
    this.shuffleChoices = false,
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

  /// Vrai quand la question revient après une erreur : les réponses
  /// changent de place, et la bonne réponse n'est plus au même endroit.
  final bool shuffleChoices;

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

  // Ordre d'affichage des réponses (indices dans `q.choices`).
  late final List<int> _order;

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
    final random = widget.random ?? Random();
    _tiles = [...q.tiles]..shuffle(random);
    _order = shuffledChoiceOrder(
      q.choices.length,
      q.answer,
      random,
      shuffle: widget.shuffleChoices,
    );
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
    if (q.kind.tiled) {
      final sep = q.kind == QuestionKind.ordonner ? ' ' : '';
      right =
          [for (final i in _placed) _tiles[i]].join(sep) ==
          q.solution.join(sep);
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
          if (q.reply != null) ...[
            ReplyLine(speaker: q.reply!.speaker, arabic: q.reply!.arabic),
            const SizedBox(height: 8),
          ],
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
    QuestionKind.reconstruire || QuestionKind.ordonner => _rebuild(),
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
          for (final (pos, i) in _order.indexed)
            AnswerButton(
              width: wide
                  ? 260
                  : q.choiceKind == ChoiceKind.audio
                  ? 150
                  : 120,
              state: _stateOf(i),
              semanticLabel: q.choiceKind == ChoiceKind.audio
                  ? 'Son ${pos + 1}'
                  : null,
              onPressed: () {
                if (q.choiceKind == ChoiceKind.audio) {
                  playLessonAudio(ref, q.choices[i]);
                }
                setState(() => _selected = i);
              },
              child: switch (q.choiceKind) {
                ChoiceKind.arabic => ArabicText(q.choices[i], baseSize: 30),
                ChoiceKind.audio => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.volume_up),
                    const SizedBox(width: 6),
                    Text(
                      'Son ${pos + 1}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                _ => Text(
                  q.choices[i],
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
                    q.kind == QuestionKind.ordonner
                        ? '${_tiles[i]} '
                        : _tiles[i],
                    baseSize: q.kind == QuestionKind.ordonner ? 32 : 40,
                    style: const TextStyle(color: PanelColors.ink),
                  ),
                ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        q.kind == QuestionKind.ordonner
            ? 'Touche les mots dans l\'ordre (de droite à gauche). Touche un '
                  'mot placé pour le retirer.'
            : 'Touche les morceaux dans l\'ordre (de droite à gauche). Touche '
                  'un morceau placé pour le retirer.',
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
                width: q.kind == QuestionKind.ordonner ? 110 : 80,
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
    GuidedTrace(letter: q.letter!, onDone: _done ? null : _finishUngraded),
  ];

  List<Widget> _repeat() => [
    RepeatAloud(text: q.arabic!),
    const SizedBox(height: 8),
    if (!_done) PanelButton(label: 'J\'ai répété', onPressed: _finishUngraded),
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
    if (q.kind.tiled && !_right!) ...[
      Text(
        q.kind == QuestionKind.ordonner
            ? 'La phrase était :'
            : 'Le mot était :',
      ),
      ArabicText(
        q.solution.join(q.kind == QuestionKind.ordonner ? ' ' : ''),
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

/// Répéter à voix haute (cahier v3 §10) : écouter le modèle, s'enregistrer,
/// réécouter en alternance. Aucune note : le joueur compare lui-même.
class RepeatAloud extends ConsumerStatefulWidget {
  const RepeatAloud({super.key, required this.text});

  final String text;

  @override
  ConsumerState<RepeatAloud> createState() => _RepeatAloudState();
}

class _RepeatAloudState extends ConsumerState<RepeatAloud> {
  bool _recording = false;
  String? _mine;
  String? _error;

  String get _key => 'repeter:${widget.text}';

  @override
  void initState() {
    super.initState();
    _mine = ref.read(voiceRecorderProvider).last(_key);
  }

  Future<void> _toggle() async {
    final rec = ref.read(voiceRecorderProvider);
    try {
      if (_recording) {
        final path = await rec.stop();
        setState(() {
          _recording = false;
          _mine = path ?? _mine;
        });
        return;
      }
      if (!await rec.allowed()) {
        setState(
          () => _error =
              'Le micro n\'est pas autorisé : tu peux répéter sans '
              't\'enregistrer.',
        );
        return;
      }
      await rec.start(_key);
      setState(() {
        _recording = true;
        _error = null;
      });
    } catch (_) {
      setState(() {
        _recording = false;
        _error = 'Enregistrement impossible sur cet appareil.';
      });
    }
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      const Text(
        'Écoute le modèle, enregistre-toi, puis compare. Pas de note : '
        'c\'est toi qui juges. Ta voix reste sur cet appareil.',
        textAlign: TextAlign.center,
        style: TextStyle(color: PanelColors.muted, fontSize: 13),
      ),
      const SizedBox(height: 8),
      Wrap(
        spacing: 10,
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: [
          FilledButton.icon(
            onPressed: _toggle,
            style: FilledButton.styleFrom(
              backgroundColor: _recording ? PanelColors.wrong : PanelColors.ink,
              foregroundColor: PanelColors.background,
              minimumSize: const Size(150, 48),
              shape: const RoundedRectangleBorder(),
            ),
            icon: Icon(_recording ? Icons.stop : Icons.mic),
            label: Text(
              _recording ? 'Arrêter' : 'M\'enregistrer',
              style: const TextStyle(fontSize: 18),
            ),
          ),
          if (_mine != null && !_recording)
            OutlinedButton.icon(
              onPressed: () => ref.read(audioServiceProvider).playFile(_mine!),
              style: OutlinedButton.styleFrom(
                foregroundColor: PanelColors.ink,
                minimumSize: const Size(150, 48),
                side: const BorderSide(color: PanelColors.ink, width: 2),
                shape: const RoundedRectangleBorder(),
              ),
              icon: const Icon(Icons.record_voice_over),
              label: const Text('Ma voix', style: TextStyle(fontSize: 18)),
            ),
        ],
      ),
      if (_error != null)
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            _error!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: PanelColors.wrong, fontSize: 13),
          ),
        ),
    ],
  );
}

/// Tracé guidé (cahier v3 §6.4) : points numérotés, sens du geste indiqué
/// par une flèche, vérification tolérante et sans sanction.
class GuidedTrace extends ConsumerStatefulWidget {
  const GuidedTrace({super.key, required this.letter, required this.onDone});

  final String letter;

  /// Nul une fois l'exercice terminé.
  final VoidCallback? onDone;

  static const double size = 240;

  @override
  ConsumerState<GuidedTrace> createState() => _GuidedTraceState();
}

class _GuidedTraceState extends ConsumerState<GuidedTrace> {
  final List<List<Offset>> _strokes = [];
  bool? _ok;

  void _check(Strokes guide) {
    setState(() {
      _ok = traceMatches(guide, [
        for (final s in _strokes) toUnit(s, GuidedTrace.size),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final guide = ref.watch(contentDatabaseProvider).letterTrace(widget.letter);
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Modèle : ', style: TextStyle(fontSize: 16)),
            ArabicText(
              widget.letter,
              baseSize: 44,
              style: const TextStyle(color: PanelColors.ink),
            ),
          ],
        ),
        Container(
          key: const Key('trace-pad'),
          width: GuidedTrace.size,
          height: GuidedTrace.size,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: PanelColors.ink, width: 2),
          ),
          child: GestureDetector(
            onPanStart: (d) => setState(() {
              _strokes.add([d.localPosition]);
              _ok = null;
            }),
            onPanUpdate: (d) =>
                setState(() => _strokes.last.add(d.localPosition)),
            onTapUp: (d) => setState(() {
              _strokes.add([d.localPosition]);
              _ok = null;
            }),
            child: CustomPaint(
              size: const Size.square(GuidedTrace.size),
              painter: _TracePainter(guide ?? const [], _strokes),
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Suis les points dans l\'ordre des numéros, dans le sens de la '
          'flèche ; les points de la lettre se posent à la fin.',
          textAlign: TextAlign.center,
          style: TextStyle(color: PanelColors.muted, fontSize: 13),
        ),
        if (_ok != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              _ok!
                  ? 'Bien tracé !'
                  : 'Pas tout à fait : suis les numéros dans l\'ordre. Tu '
                        'peux effacer et recommencer, ou continuer.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _ok! ? PanelColors.right : PanelColors.wrong,
              ),
            ),
          ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            OutlinedButton(
              onPressed: _strokes.isEmpty
                  ? null
                  : () => setState(() {
                      _strokes.clear();
                      _ok = null;
                    }),
              child: const Text('Effacer'),
            ),
            if (guide != null)
              OutlinedButton(
                onPressed: _strokes.isEmpty ? null : () => _check(guide),
                child: const Text('Vérifier'),
              ),
            if (widget.onDone != null)
              PanelButton(
                label: 'J\'ai tracé',
                onPressed: _strokes.isEmpty ? null : widget.onDone,
              ),
          ],
        ),
      ],
    );
  }
}

class _TracePainter extends CustomPainter {
  _TracePainter(this.guide, this.strokes);

  final Strokes guide;
  final List<List<Offset>> strokes;

  @override
  void paint(Canvas canvas, Size size) {
    final k = size.width / 100;
    final guidePaint = Paint()
      ..color = const Color(0x33000000)
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    var n = 1;
    for (final stroke in guide) {
      final pts = [for (final p in stroke) p * k];
      if (pts.length > 1) {
        final path = Path()..moveTo(pts.first.dx, pts.first.dy);
        for (final p in pts.skip(1)) {
          path.lineTo(p.dx, p.dy);
        }
        canvas.drawPath(path, guidePaint);
        // Flèche : sens du geste, au départ du trait.
        final a = pts[0];
        final b = pts[1];
        final dir = (b - a) / (b - a).distance;
        final tip = a + dir * 22;
        final side = Offset(-dir.dy, dir.dx);
        canvas.drawPath(
          Path()
            ..moveTo(tip.dx, tip.dy)
            ..lineTo(
              (tip - dir * 9 + side * 6).dx,
              (tip - dir * 9 + side * 6).dy,
            )
            ..lineTo(
              (tip - dir * 9 - side * 6).dx,
              (tip - dir * 9 - side * 6).dy,
            )
            ..close(),
          Paint()..color = const Color(0xFFB0412E),
        );
      }
      for (final p in pts) {
        canvas.drawCircle(p, 9, Paint()..color = const Color(0xFFF2C45A));
        final tp = TextPainter(
          text: TextSpan(
            text: '$n',
            style: const TextStyle(color: Color(0xFF23202C), fontSize: 11),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        tp.paint(canvas, p - Offset(tp.width / 2, tp.height / 2));
        n++;
      }
    }
    final ink = Paint()
      ..color = const Color(0xFF23202C)
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    for (final s in strokes) {
      if (s.length == 1) {
        canvas.drawCircle(s.first, 4, Paint()..color = ink.color);
        continue;
      }
      final path = Path()..moveTo(s.first.dx, s.first.dy);
      for (final p in s.skip(1)) {
        path.lineTo(p.dx, p.dy);
      }
      canvas.drawPath(path, ink);
    }
  }

  @override
  bool shouldRepaint(_TracePainter old) => true;
}

/// Réplique d'un personnage, dans une question « répondre » (région 2).
class ReplyLine extends ConsumerWidget {
  const ReplyLine({super.key, required this.speaker, required this.arabic});

  final String speaker;
  final String arabic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = [
      for (final c in ref.watch(contentDatabaseProvider).allCharacters())
        if (c.id == speaker) c.name,
    ].firstOrNull;
    return Column(
      children: [
        Text(
          '${name ?? speaker} :',
          style: const TextStyle(color: PanelColors.muted, fontSize: 15),
        ),
        InkWell(
          onTap: () => playLessonAudio(ref, arabic),
          child: ArabicText(
            arabic,
            baseSize: 34,
            style: const TextStyle(color: PanelColors.ink),
          ),
        ),
      ],
    );
  }
}
