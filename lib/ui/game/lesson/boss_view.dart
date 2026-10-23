/// Mini-boss d'une leçon (cahier v3 §6.1 écran 8, §6.2, §8.5) : combat
/// contre une difficulté, questions dans un panneau neutre, sans
/// translittération ni verset, réussite à 80 %. Les explications viennent
/// après le combat, à la revue des erreurs.
library;

import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/settings/settings.dart';
import '../../../game/combat/combat_scene.dart';
import '../../../game/lesson/lesson.dart';
import '../pixel.dart';
import 'question_view.dart';

/// Points de vie du mini-boss. Chaque bonne réponse retire 10 PV à la
/// difficulté, chaque erreur 10 PV au voyageur. Les PV sont réglés sur le
/// seuil : la difficulté tombe exactement quand le score atteint 80 %, et le
/// voyageur se replie à la première erreur de trop. Le combat se termine donc
/// toujours au plus tard à la dernière question.
class BossFight {
  BossFight({required int questions, required double threshold})
    : passMark = bossPassMark(questions, threshold),
      allowedErrors = questions - bossPassMark(questions, threshold) {
    foeHp = foeMaxHp;
    heroHp = heroMaxHp;
  }

  static const int strike = 10;

  /// Réponse juste en moins de 3 s : « rapide ! » (affiché, sans effet sur
  /// le score : l'apprentissage ne dépend pas de la vitesse).
  static const Duration quick = Duration(seconds: 3);

  final int passMark;
  final int allowedErrors;
  int get foeMaxHp => passMark * strike;
  int get heroMaxHp => (allowedErrors + 1) * strike;
  late int foeHp;
  late int heroHp;
  int correct = 0;
  int wrong = 0;

  bool get won => foeHp <= 0;
  bool get lost => heroHp <= 0;
  bool get over => won || lost;

  void answer(bool right) {
    if (over) throw StateError('combat terminé');
    if (right) {
      correct++;
      foeHp = max(0, foeHp - strike);
    } else {
      wrong++;
      heroHp = max(0, heroHp - strike);
    }
  }
}

class BossView extends ConsumerStatefulWidget {
  const BossView({
    super.key,
    required this.step,
    required this.adversary,
    required this.failuresBefore,
    required this.onResult,
    required this.onVictoryContinue,
    required this.onReplayPractice,
    this.random,
  });

  final BossStep step;

  /// Nom de la difficulté (« L'Oubli »).
  final String adversary;

  /// Échecs déjà comptés pour cette leçon.
  final int failuresBefore;

  /// Fin du combat (appelé une fois par tentative) : réussi ou non, et
  /// nombre de bonnes réponses.
  final void Function({required bool passed, required int score}) onResult;

  /// Après une victoire, vers l'écran de fin.
  final VoidCallback onVictoryContinue;

  /// Revenir à la salle d'entraînement.
  final VoidCallback onReplayPractice;
  final Random? random;

  @override
  ConsumerState<BossView> createState() => _BossViewState();
}

class _BossViewState extends ConsumerState<BossView> {
  late final Random _random = widget.random ?? Random();
  late CombatScene _scene;
  late BossFight _fight;
  late List<LessonQuestion> _order;
  int _index = 0;
  bool _answered = false;
  String? _flash;
  final List<LessonQuestion> _mistakes = [];
  bool _reported = false;
  int _attempt = 0;

  @override
  void initState() {
    super.initState();
    _scene = CombatScene(animations: ref.read(settingsProvider).animations);
    _start();
  }

  void _start() {
    // Nouvelle tentative : questions et ordre mélangés.
    _order = [...widget.step.questions]..shuffle(_random);
    _fight = BossFight(
      questions: _order.length,
      threshold: widget.step.threshold,
    );
    _index = 0;
    _answered = false;
    _flash = null;
    _mistakes.clear();
    _reported = false;
    _attempt++;
  }

  void _onAnswered(bool right, Duration time) {
    _fight.answer(right);
    if (right) {
      _scene.foeHit();
    } else {
      _scene.heroHit();
      _mistakes.add(_order[_index]);
    }
    setState(() {
      _answered = true;
      _flash = right
          ? (time < BossFight.quick ? 'Juste, et rapide !' : 'Juste !')
          : '${widget.adversary} frappe.';
    });
  }

  void _next() {
    if (_fight.over) {
      if (!_reported) {
        _reported = true;
        widget.onResult(passed: _fight.won, score: _fight.correct);
      }
      setState(() {});
      return;
    }
    setState(() {
      _index++;
      _answered = false;
      _flash = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ended = _fight.over && _reported;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
              child: HpWindow(
                name: 'Le voyageur',
                hp: _fight.heroHp,
                max: _fight.heroMaxHp,
                color: GameColors.good,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: HpWindow(
                name: widget.adversary,
                hp: _fight.foeHp,
                max: _fight.foeMaxHp,
                color: GameColors.bad,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (ended)
          _endPanel()
        else ...[
          Text(
            'Question ${_index + 1} sur ${_order.length}',
            style: const TextStyle(color: GameColors.muted, fontSize: 14),
          ),
          const SizedBox(height: 4),
          QuestionView(
            key: ValueKey('boss-$_attempt-$_index'),
            question: _order[_index],
            showExplanation: false,
            onAnswered: _onAnswered,
            onContinue: _next,
            continueLabel: _fight.over ? 'Voir le résultat' : 'Suite',
            random: _random,
          ),
          if (_answered && _flash != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                _flash!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: GameColors.accent),
              ),
            ),
        ],
      ],
    );
  }

  Widget _endPanel() {
    final won = _fight.won;
    final failures = widget.failuresBefore + (won ? 0 : 1);
    return PixelWindow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            won
                ? '${widget.adversary} se dissipe !'
                : '${widget.adversary} s\'échappe… Rien n\'est perdu.',
            style: const TextStyle(fontSize: 22, color: GameColors.accent),
          ),
          const SizedBox(height: 6),
          Text(
            '${_fight.correct} bonne(s) réponse(s), ${_fight.wrong} '
            'erreur(s). Il fallait ${_fight.passMark} bonnes réponses '
            '(80 %).',
          ),
          if (_mistakes.isNotEmpty) ...[
            const SizedBox(height: 10),
            const Text(
              'Tes erreurs, expliquées :',
              style: TextStyle(color: GameColors.accent),
            ),
            for (final m in _mistakes)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text('• ${m.prompt} — ${m.explanation ?? ''}'),
              ),
          ],
          const SizedBox(height: 10),
          if (won)
            PixelCommand(
              label: 'Continuer',
              onPressed: widget.onVictoryContinue,
            )
          else ...[
            if (failures >= 2)
              const Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Text(
                  'Deux essais sans réussite : rejouer la salle '
                  'd\'entraînement t\'aidera.',
                  style: TextStyle(color: GameColors.muted, fontSize: 14),
                ),
              ),
            PixelCommand(
              label: 'Revoir la salle d\'entraînement',
              onPressed: widget.onReplayPractice,
            ),
            PixelCommand(
              label: 'Retenter le combat',
              detail: 'Les mêmes questions, dans un autre ordre',
              onPressed: () => setState(_start),
            ),
          ],
        ],
      ),
    );
  }
}

/// Fenêtre de points de vie.
class HpWindow extends StatelessWidget {
  const HpWindow({
    super.key,
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
              widthFactor: max == 0 ? 0 : hp / max,
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
