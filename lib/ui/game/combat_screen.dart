import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../features/settings/settings.dart';
import '../../game/combat/combat_scene.dart';
import '../../game/combat/practice_combat.dart';
import '../../game/world.dart';
import 'pixel.dart';

/// Combat d'entraînement contre une brume d'oubli. Les questions sont des
/// syllabes et des mots construits des leçons 0 à 3, dans un panneau neutre.
class CombatScreen extends ConsumerStatefulWidget {
  const CombatScreen({super.key, this.random});

  /// Pour les tests (tirage reproductible).
  final Random? random;

  static const String practiceNotice =
      "Entraînement : les révisions seront enregistrées à l'étape 6 du jalon "
      'J1a.';

  @override
  ConsumerState<CombatScreen> createState() => _CombatScreenState();
}

class _CombatScreenState extends ConsumerState<CombatScreen> {
  late final Random _random = widget.random ?? Random();
  late final List<ReadingItem> _items;
  late final CombatScene _scene;
  late PracticeCombat _combat;
  late PracticeQuestion _question;
  final _clock = Stopwatch();

  /// Choix sélectionné, pas encore validé.
  int? _selected;

  /// Choix validé.
  int? _picked;
  String? _feedback;

  @override
  void initState() {
    super.initState();
    _items = ref.read(contentDatabaseProvider).readingItems(stage: 1, upTo: 3);
    _scene = CombatScene(animations: ref.read(settingsProvider).animations);
    _restart();
  }

  void _restart() {
    _combat = PracticeCombat();
    _next();
  }

  void _next() {
    _question = buildQuestion(_items, _random);
    _selected = null;
    _picked = null;
    _feedback = null;
    _clock
      ..reset()
      ..start();
  }

  void _validate() {
    final i = _selected;
    if (i == null || _picked != null) return;
    _clock.stop();
    final right = i == _question.answer;
    final dmg = _combat.answer(right: right, time: _clock.elapsed);
    if (right) {
      _scene.foeHit();
    } else {
      _scene.heroHit();
    }
    setState(() {
      _picked = i;
      _feedback = right
          ? (dmg == PracticeCombat.criticalHit
                ? 'Juste, et rapide : coup critique ! (−$dmg PV)'
                : 'Juste ! (−$dmg PV)')
          : "Pas tout à fait. ${_question.explanation} La brume d'oubli "
                'frappe (−$dmg PV).';
    });
  }

  @override
  Widget build(BuildContext context) {
    final outcome = _combat.outcome;
    return Scaffold(
      backgroundColor: GameColors.night,
      appBar: AppBar(
        title: const Text('La Faille des Oubliés'),
        backgroundColor: GameColors.night,
        foregroundColor: GameColors.text,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: GameWidget(game: _scene),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _HpWindow(
                    name: 'Le voyageur',
                    hp: _combat.heroHp,
                    max: _combat.heroMaxHp,
                    color: GameColors.good,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _HpWindow(
                    name: "Brume d'oubli",
                    hp: _combat.foeHp,
                    max: _combat.foeMaxHp,
                    color: GameColors.bad,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (outcome == CombatOutcome.ongoing)
              _questionPanel()
            else
              _endPanel(outcome),
            const SizedBox(height: 12),
            PixelWindow(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                    child: Row(
                      children: [
                        SizedBox(width: 22, child: MenuCursor()),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: 'Attaque',
                              style: TextStyle(fontSize: 18),
                              children: [
                                TextSpan(
                                  text: '   lire une syllabe ou un mot',
                                  style: TextStyle(
                                    color: GameColors.muted,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PixelCommand(
                    label: 'Bouclier',
                    detail: 'Une règle : arrive avec les leçons en mini-donjon',
                    onPressed: null,
                  ),
                  const PixelCommand(
                    label: 'Ultime',
                    detail: 'Reconstruire un mot : arrive avec les leçons',
                    onPressed: null,
                  ),
                  const PixelCommand(
                    label: 'Objet',
                    detail: "Aucun objet avant l'étape 6",
                    onPressed: null,
                  ),
                  const PixelCommand(
                    label: 'Sort de racine',
                    detail: 'Débloqué à la leçon 7',
                    onPressed: null,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(26, 4, 4, 4),
                    child: Text(
                      'Seule l\'Attaque est disponible pour l\'instant. '
                      '${CombatScreen.practiceNotice}',
                      style: const TextStyle(
                        color: GameColors.muted,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _questionPanel() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFF1EDE4),
      border: Border.all(color: const Color(0xFF0D0B16), width: 3),
    ),
    child: DefaultTextStyle.merge(
      style: const TextStyle(color: Color(0xFF23202C), fontSize: 18),
      child: Column(
        children: [
          const Text('Comment se lit… ?', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          SpokenArabic(
            _question.target.arabic,
            size: 52,
            color: const Color(0xFF23202C),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              for (final (i, c) in _question.choices.indexed)
                _ChoiceButton(
                  label: c,
                  state: _picked == null
                      ? (i == _selected ? _Choice.selected : _Choice.open)
                      : i == _question.answer
                      ? _Choice.right
                      : i == _picked
                      ? _Choice.wrong
                      : _Choice.closed,
                  onPressed: () => setState(() => _selected = i),
                ),
            ],
          ),
          if (_picked == null) ...[
            const SizedBox(height: 12),
            FilledButton(
              onPressed: _selected == null ? null : _validate,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF23202C),
                foregroundColor: const Color(0xFFF1EDE4),
                disabledBackgroundColor: const Color(0xFFD6D1C4),
                disabledForegroundColor: const Color(0xFF6B6577),
                minimumSize: const Size(160, 48),
                shape: const RoundedRectangleBorder(),
              ),
              child: const Text('Valider', style: TextStyle(fontSize: 20)),
            ),
          ],
          if (_feedback != null) ...[
            const SizedBox(height: 12),
            Text(_feedback!, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () => setState(_next),
              child: Text(
                _combat.outcome == CombatOutcome.ongoing
                    ? 'Question suivante'
                    : 'Voir le résultat',
              ),
            ),
          ],
        ],
      ),
    ),
  );

  Widget _endPanel(CombatOutcome outcome) => PixelWindow(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          outcome == CombatOutcome.victory
              ? "La brume d'oubli se dissipe !"
              : 'Tu te replies, sans rien perdre.',
          style: const TextStyle(fontSize: 22, color: GameColors.accent),
        ),
        const SizedBox(height: 8),
        Text(
          '${_combat.correct} bonne(s) réponse(s), '
          '${_combat.wrong} erreur(s).',
        ),
        const SizedBox(height: 4),
        const Text(
          CombatScreen.practiceNotice,
          style: TextStyle(color: GameColors.muted, fontSize: 14),
        ),
        const SizedBox(height: 8),
        PixelCommand(label: 'Recommencer', onPressed: () => setState(_restart)),
        PixelCommand(
          label: 'Quitter la Faille',
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}

enum _Choice { open, selected, right, wrong, closed }

class _ChoiceButton extends StatelessWidget {
  const _ChoiceButton({
    required this.label,
    required this.state,
    required this.onPressed,
  });

  final String label;
  final _Choice state;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (state) {
      _Choice.right => (const Color(0xFF2E7D4F), Colors.white),
      _Choice.wrong => (const Color(0xFFB0412E), Colors.white),
      _Choice.selected => (const Color(0xFFF2C45A), const Color(0xFF23202C)),
      _ => (Colors.white, const Color(0xFF23202C)),
    };
    return SizedBox(
      width: 120,
      height: 52,
      child: OutlinedButton(
        onPressed: state == _Choice.open || state == _Choice.selected
            ? onPressed
            : null,
        style: OutlinedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          disabledForegroundColor: fg,
          side: const BorderSide(color: Color(0xFF23202C), width: 3),
          shape: const RoundedRectangleBorder(),
        ),
        child: Text(label, style: const TextStyle(fontSize: 22)),
      ),
    );
  }
}

class _HpWindow extends StatelessWidget {
  const _HpWindow({
    required this.name,
    required this.hp,
    required this.max,
    required this.color,
  });

  final String name;
  final int hp;
  final int max;
  final Color color;

  @override
  Widget build(BuildContext context) => PixelWindow(
    padding: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 4),
        Semantics(
          label: '$name : $hp points de vie sur $max',
          child: Container(
            height: 12,
            decoration: BoxDecoration(
              color: const Color(0xFF2F2848),
              border: Border.all(color: const Color(0xFF0D0B16), width: 2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: hp / max,
              child: ColoredBox(color: color),
            ),
          ),
        ),
        Text(
          'PV $hp / $max',
          style: const TextStyle(color: GameColors.muted, fontSize: 14),
        ),
      ],
    ),
  );
}
