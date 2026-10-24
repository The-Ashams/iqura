/// L'Expédition dans la Faille des Oubliés : vagues de brumes d'oubli puis
/// un gardien, nourris par les révisions FSRS dues (cahier v3 §8.3 à §8.5).
/// Questions dans un panneau neutre, sans translittération ni verset ; les
/// explications des erreurs viennent après le combat.
library;

import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/providers.dart';
import '../../engines/audio/audio_service.dart';
import '../../features/inventory/inventory.dart';
import '../../features/resources/resources.dart';
import '../../features/review/review.dart';
import '../../features/settings/settings.dart';
import '../../game/combat/combat_scene.dart';
import '../../game/equipment/equipment.dart';
import '../../game/expedition/expedition.dart';
import '../../game/lesson/lesson.dart';
import '../../game/review/review_question.dart';
import 'lesson/boss_view.dart' show HpWindow;
import 'lesson/question_view.dart';
import 'pixel.dart';

/// Révisions par Expédition, au plus (le reste attend la suivante).
const int expeditionSize = 20;

class ExpeditionScreen extends ConsumerStatefulWidget {
  const ExpeditionScreen({super.key, this.random, this.practice = false});

  final Random? random;

  /// Entraînement libre : cartes déjà apprises, rien n'est enregistré.
  final bool practice;

  static const String practiceNotice =
      'Entraînement libre : rien n\'est enregistré, aucune récompense.';

  @override
  ConsumerState<ExpeditionScreen> createState() => _ExpeditionScreenState();
}

class _Entry {
  _Entry(this.card, this.question);

  final ReviewCard card;
  final LessonQuestion question;
}

class _ExpeditionScreenState extends ConsumerState<ExpeditionScreen> {
  late final Random _random = widget.random ?? Random();
  late final CombatScene _scene;
  final _session = const Uuid().v7();
  final List<_Entry> _queue = [];
  final Set<String> _requeued = {};
  final List<_Entry> _mistakes = [];
  ExpeditionFight? _fight;
  int _index = 0;
  bool _answered = false;
  String? _flash;
  bool _ended = false;
  int _xp = 0;
  int _dinars = 0;
  int _stones = 0;
  int _reviews = 0;

  @override
  void initState() {
    super.initState();
    _scene = CombatScene(animations: ref.read(settingsProvider).animations);
    _prepare();
  }

  ReviewPools _pools(List<ReviewCard> learned) {
    final content = ref.read(contentDatabaseProvider);
    final items = content.readingItems(stage: 1, upTo: 1000);
    final letters = {
      for (final c in learned)
        if (c.kind == CardKind.reconnaitre || c.kind == CardKind.ecouter)
          c.target,
    };
    final readings = {
      for (final c in learned)
        if (c.kind == CardKind.lire) c.target,
    };
    return ReviewPools(
      letters: [
        for (final l in content.letters())
          if (letters.contains(l.letter)) l,
      ],
      readings: readings.toList(),
      translit: {for (final i in items) i.arabic: i.translit},
      syllables: {
        for (final i in items)
          if (!i.word) i.arabic,
      },
    );
  }

  void _prepare() {
    final repo = ref.read(reviewRepositoryProvider);
    final learned = repo.all();
    final pools = _pools(learned);
    final cards = widget.practice
        ? (learned.toList()..shuffle(_random)).take(expeditionSize).toList()
        : (repo.due().take(expeditionSize).toList()..shuffle(_random));
    for (final c in cards) {
      final q = questionFor(c, pools, _random);
      if (q != null) _queue.add(_Entry(c, q));
    }
    if (_queue.isEmpty) return;
    final now = DateTime.now();
    final overdue = widget.practice
        ? 0
        : repo.due(at: now.subtract(const Duration(days: 1))).length;
    final level = ref.read(walletProvider).level;
    _fight = ExpeditionFight(
      questions: _queue.length,
      hero: heroStats(level, ref.read(inventoryRepositoryProvider).equipped()),
      overdue: overdue,
      timer: ref.read(settingsProvider).timer,
    );
  }

  void _onAnswered(bool right, Duration time) {
    final fight = _fight!;
    final entry = _queue[_index];
    final hit = fight.answer(right: right, time: time);
    playSfx(ref, right ? Sfx.coup : Sfx.degats);
    if (right) {
      _scene.foeHit();
    } else {
      _scene.heroHit();
      _mistakes.add(entry);
      // Une erreur : la carte revient en fin d'Expédition (une fois).
      if (_requeued.add(entry.card.id)) _queue.add(entry);
    }
    if (!widget.practice) _record(entry, right, time, hit.defeated);
    setState(() {
      _answered = true;
      _flash = right
          ? (hit.critical
                ? 'Coup critique ! (−${hit.damage} PV)'
                : 'Touché ! (−${hit.damage} PV)')
          : 'La brume t\'enveloppe (−${hit.damage} PV).';
      if (hit.defeated != null) {
        _flash = '${_flash!} ${hit.defeated!.name} se dissipe !';
      }
    });
  }

  void _record(_Entry entry, bool right, Duration time, Foe? defeated) {
    final reviews = ref.read(reviewRepositoryProvider);
    final res = ref.read(resourceRepositoryProvider);
    final timer = ref.read(settingsProvider).timer;
    final before = entry.card.state.stability ?? 0;
    final result = reviews.review(
      entry.card.id,
      right: right,
      time: time,
      timer: timer,
    );
    _reviews++;
    _stones += result.stones;
    res.recordActivity();
    if (right) {
      // Rendement décroissant : une carte déjà très stable rapporte moins.
      final xp = before > 30 ? Rewards.easyReviewXp : Rewards.reviewXp;
      if (res.grant(
        Currency.xp,
        xp,
        key: 'revision:$_session:${entry.card.id}:$_index',
        source: 'révision',
      )) {
        _xp += xp;
      }
    }
    if (defeated != null) {
      final i = _fight!.foes.indexOf(defeated);
      final xp = defeated.guardian ? Rewards.guardianXp : Rewards.waveXp;
      final dinars = defeated.guardian
          ? Rewards.guardianDinars
          : Rewards.waveDinars;
      res
        ..grant(
          Currency.xp,
          xp,
          key: 'expedition:$_session:$i:xp',
          source: defeated.name,
        )
        ..grant(
          Currency.dinars,
          dinars,
          key: 'expedition:$_session:$i:dinars',
          source: defeated.name,
        );
      _xp += xp;
      _dinars += dinars;
    }
    ref.read(walletProvider.notifier).refresh();
    ref.read(dueCountProvider.notifier).refresh();
  }

  void _next() {
    final fight = _fight!;
    final remaining = _queue.length - _index - 1;
    if (fight.lost || remaining == 0) {
      playSfx(ref, fight.lost ? Sfx.repli : Sfx.victoire);
      setState(() => _ended = true);
      return;
    }
    if (fight.won) fight.addTraces(remaining);
    setState(() {
      _index++;
      _answered = false;
      _flash = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final fight = _fight;
    return Scaffold(
      backgroundColor: GameColors.night,
      appBar: AppBar(
        title: Text(widget.practice ? 'Entraînement libre' : 'L\'Expédition'),
        backgroundColor: GameColors.night,
        foregroundColor: GameColors.text,
      ),
      body: SafeArea(
        child: GameBody(
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              if (fight == null) _empty() else ..._combat(fight),
              if (widget.practice)
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    ExpeditionScreen.practiceNotice,
                    style: TextStyle(color: GameColors.muted, fontSize: 14),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _empty() {
    final repo = ref.read(reviewRepositoryProvider);
    final all = repo.all();
    String text;
    if (all.isEmpty) {
      text =
          'Aucune carte à réviser : réussis le mini-boss d\'une leçon pour '
          'créer tes premières cartes.';
    } else {
      final next = all
          .map((c) => c.due)
          .reduce((a, b) => a.isBefore(b) ? a : b);
      text =
          'Rien à réviser pour l\'instant. Prochaine révision : '
          '${_when(next)}.';
    }
    return PixelWindow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text),
          const SizedBox(height: 8),
          if (all.isNotEmpty && !widget.practice)
            PixelCommand(
              label: 'Entraînement libre',
              detail: ExpeditionScreen.practiceNotice,
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (_) =>
                      ExpeditionScreen(practice: true, random: widget.random),
                ),
              ),
            ),
          PixelCommand(
            label: 'Quitter la Faille',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  static String _when(DateTime t) {
    final d = t.toLocal().difference(DateTime.now());
    if (d.inMinutes < 60) return 'dans ${max(1, d.inMinutes)} min';
    if (d.inHours < 24) return 'dans ${d.inHours} h';
    return 'dans ${d.inDays} jour${d.inDays > 1 ? 's' : ''}';
  }

  List<Widget> _combat(ExpeditionFight fight) {
    final foe = fight.current ?? fight.foes.last;
    return [
      if (ref.watch(settingsProvider.select((s) => s.learningOnly)))
        // Apprentissage seul : les révisions en série, sans combat.
        PixelWindow(
          padding: const EdgeInsets.all(10),
          child: Text(
            '${fight.correct} bonne(s) réponse(s), ${fight.wrong} erreur(s).',
          ),
        )
      else ...[
        CombatSceneBox(child: GameWidget(game: _scene)),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: HpWindow(
                name: 'Le voyageur',
                hp: fight.heroHp,
                max: fight.hero.pv,
                color: GameColors.good,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: HpWindow(
                name: foe.name,
                hp: foe.hp,
                max: foe.maxHp,
                color: GameColors.bad,
              ),
            ),
          ],
        ),
      ],
      const SizedBox(height: 12),
      if (_ended)
        _endPanel(fight)
      else ...[
        Text(
          'Révision ${_index + 1} sur ${_queue.length}',
          style: TextStyle(color: GameColors.muted, fontSize: 14),
        ),
        const SizedBox(height: 4),
        QuestionView(
          key: ValueKey('exp-$_index'),
          question: _queue[_index].question,
          showExplanation: false,
          feedbackSound: false,
          onAnswered: _onAnswered,
          onContinue: _next,
          continueLabel: 'Suite',
          random: _random,
          // Carte revenue après une erreur : réponses déplacées.
          shuffleChoices: _queue.indexOf(_queue[_index]) != _index,
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
      ],
    ];
  }

  Widget _endPanel(ExpeditionFight fight) => PixelWindow(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fight.lost
              ? 'Tu te replies, sans rien perdre : les révisions faites comptent.'
              : 'Les brumes d\'oubli se dissipent !',
          style: TextStyle(fontSize: 20, color: GameColors.accent),
        ),
        const SizedBox(height: 6),
        Text('${fight.correct} bonne(s) réponse(s), ${fight.wrong} erreur(s).'),
        if (!widget.practice)
          Text(
            '$_reviews révision(s) enregistrée(s). Gains : +$_xp XP, '
            '+$_dinars dinars${_stones > 0 ? ', +$_stones pierre(s) de savoir' : ''}.',
          ),
        if (_mistakes.isNotEmpty) ...[
          const SizedBox(height: 10),
          Text(
            'Tes erreurs, expliquées :',
            style: TextStyle(color: GameColors.accent),
          ),
          for (final m in _mistakes.toSet())
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text('• ${m.question.explanation ?? ''}'),
            ),
        ],
        const SizedBox(height: 10),
        PixelCommand(
          label: 'Quitter la Faille',
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}
