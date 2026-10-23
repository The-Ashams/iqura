import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:fsrs/fsrs.dart' as fsrs;
import 'package:iqura/data/content_db/content_database.dart';
import 'package:iqura/data/user_db/user_database.dart';
import 'package:iqura/features/inventory/inventory.dart';
import 'package:iqura/features/progress/lesson_progress.dart';
import 'package:iqura/features/resources/resources.dart';
import 'package:iqura/features/review/review.dart';
import 'package:iqura/game/equipment/equipment.dart';
import 'package:iqura/game/expedition/expedition.dart';
import 'package:iqura/game/lesson/lesson.dart';
import 'package:iqura/game/review/review_question.dart';

void main() {
  late UserDatabase db;
  late ContentDatabase content;
  late DateTime now;
  late ResourceRepository res;
  late ReviewRepository reviews;

  setUp(() {
    db = UserDatabase.open(null);
    content = ContentDatabase.openVerified(ContentDatabase.assetPath);
    now = DateTime.utc(2026, 10, 23, 12);
    res = ResourceRepository(db, now: () => now);
    reviews = ReviewRepository(db, res, now: () => now);
  });
  tearDown(() {
    db.close();
    content.close();
  });

  group('notes FSRS (cahier §6.3)', () {
    test('faux, plus de 8 s, 3 à 8 s, moins de 3 s', () {
      fsrs.Rating r(bool right, int s, {bool timer = true}) => ratingFor(
        right: right,
        time: Duration(seconds: s),
        timer: timer,
      );
      expect(r(false, 1), fsrs.Rating.again);
      expect(r(true, 9), fsrs.Rating.hard);
      expect(r(true, 5), fsrs.Rating.good);
      expect(r(true, 3), fsrs.Rating.good);
      expect(r(true, 2), fsrs.Rating.easy);
      expect(r(true, 1, timer: false), fsrs.Rating.good);
    });

    test('jamais « maîtrisé » après une seule réussite, même facile', () {
      reviews.createCards('x', [
        (id: 'lire:بَ', kind: CardKind.lire, target: 'بَ'),
      ]);
      final r = reviews.review(
        'lire:بَ',
        right: true,
        time: const Duration(seconds: 1),
      );
      expect(r.rating, fsrs.Rating.easy);
      expect(r.card.level, isNot(MasteryLevel.maitrise));
      expect(db.select('SELECT * FROM review_log'), hasLength(1));
      expect(r.card.due.isAfter(now), isTrue);
    });

    test('pierres de savoir : une seule fois par état atteint', () {
      reviews.createCards('x', [
        (id: 'lire:تَ', kind: CardKind.lire, target: 'تَ'),
      ]);
      var stones = 0;
      for (var i = 0; i < 12; i++) {
        final r = reviews.review(
          'lire:تَ',
          right: true,
          time: const Duration(seconds: 5),
        );
        stones += r.stones;
        now = r.card.due.add(const Duration(minutes: 1));
      }
      // Reconnu (1) puis maîtrisé (3) : 4 pierres au total, jamais plus.
      expect(reviews.get('lire:تَ')!.bestLevel, MasteryLevel.maitrise);
      expect(stones, 4);
      expect(res.wallet()[Currency.pierres], 4);
    });

    test('une carte n’est jamais créée deux fois', () {
      final cards = [(id: 'ecouter:ب', kind: CardKind.ecouter, target: 'ب')];
      expect(reviews.createCards('a', cards), 1);
      expect(reviews.createCards('a', cards), 0);
    });
  });

  group('leçon réussie', () {
    test('première fois : cartes, XP, dinars, encre ; rejouée : 10 XP par '
        'jour', () {
      final lesson = content.lesson('dechiffrer-01')!;
      final r = rewardLesson(
        lesson,
        first: true,
        resources: res,
        reviews: reviews,
        now: now,
      );
      expect(r.newCards, 4 * 2 + 1 + 10);
      var w = res.wallet();
      expect(w[Currency.xp], 50);
      expect(w[Currency.dinars], 20);
      expect(w[Currency.encre], 1);
      // Toutes les cartes neuves sont dues tout de suite.
      expect(reviews.due(), hasLength(r.newCards));
      rewardLesson(
        lesson,
        first: false,
        resources: res,
        reviews: reviews,
        now: now,
      );
      rewardLesson(
        lesson,
        first: false,
        resources: res,
        reviews: reviews,
        now: now,
      );
      w = res.wallet();
      expect(w[Currency.xp], 60);
    });

    test('questions de révision : 3 choix distincts, une seule bonne '
        'réponse, jamais de lettres latines dans les choix', () {
      for (final id in ['dechiffrer-01', 'dechiffrer-02']) {
        rewardLesson(
          content.lesson(id)!,
          first: true,
          resources: res,
          reviews: reviews,
          now: now,
        );
      }
      final items = content.readingItems(stage: 1, upTo: 99);
      final cards = reviews.all();
      final pools = ReviewPools(
        letters: [
          for (final l in content.letters())
            if (cards.any((c) => c.target == l.letter)) l,
        ],
        readings: [
          for (final c in cards)
            if (c.kind == CardKind.lire) c.target,
        ],
        translit: {for (final i in items) i.arabic: i.translit},
        syllables: {
          for (final i in items)
            if (!i.word) i.arabic,
        },
      );
      final latin = RegExp(r'[A-Za-zāīūṯḥḫǧ]');
      for (final c in cards) {
        for (var seed = 0; seed < 5; seed++) {
          final q = questionFor(c, pools, Random(seed));
          expect(q, isNotNull, reason: c.id);
          expect(q!.choices.length, 3, reason: c.id);
          expect(q.choices.toSet().length, 3, reason: c.id);
          expect(q.answer, inInclusiveRange(0, 2));
          for (final ch in q.choices) {
            expect(latin.hasMatch(ch), isFalse, reason: '${c.id} $ch');
          }
          expect(latin.hasMatch(q.arabic ?? ''), isFalse);
          // Tout ce qui se joue a un enregistrement.
          if (q.choiceKind == ChoiceKind.audio) {
            for (final ch in q.choices) {
              expect(content.audioFile(ch), isNotNull, reason: ch);
            }
          }
          if (q.audio != null) expect(content.audioFile(q.audio!), isNotNull);
        }
      }
    });
  });

  group('ressources et séries', () {
    test(
      'un gain n’est compté qu’une fois ; dépense refusée si insuffisant',
      () {
        expect(res.grant(Currency.dinars, 30, key: 'k', source: 't'), isTrue);
        expect(res.grant(Currency.dinars, 30, key: 'k', source: 't'), isFalse);
        expect(res.spend({Currency.dinars: 50}, source: 't'), isFalse);
        expect(res.spend({Currency.dinars: 20}, source: 't'), isTrue);
        expect(res.wallet()[Currency.dinars], 10);
      },
    );

    test('niveau du héros : 100 XP pour le 2, 300 pour le 3', () {
      expect(levelForXp(0), 1);
      expect(levelForXp(99), 1);
      expect(levelForXp(100), 2);
      expect(levelForXp(299), 2);
      expect(levelForXp(300), 3);
      expect(xpForLevel(3), 300);
    });

    test('série : un jour de repos ne la casse pas, deux jours si', () {
      void dayAt(int d) {
        now = DateTime(2026, 10, d, 12);
        res.recordActivity();
      }

      dayAt(1);
      dayAt(2);
      dayAt(4); // le 3 : repos
      now = DateTime(2026, 10, 4, 20);
      expect(res.streak(), 3);
      now = DateTime(2026, 10, 7, 9); // le 5 et le 6 sans activité
      expect(res.streak(), 0);
      // La récompense de série n'est donnée qu'une fois par jour.
      final before = res.wallet()[Currency.dinars];
      dayAt(7);
      dayAt(7);
      expect(res.wallet()[Currency.dinars], before + 6);
    });
  });

  group('enchantement (cahier §8.6)', () {
    test('taux affichés et garantie après échecs', () {
      expect(Enchant.baseRate(1), 95);
      expect(Enchant.baseRate(5), 75);
      expect(Enchant.baseRate(6), 60);
      expect(Enchant.baseRate(10), 40);
      expect(Enchant.baseRate(11), 30);
      expect(Enchant.baseRate(15), 10);
      expect(Enchant.rate(11, 2), 40); // +5 points par échec
      expect(Enchant.rate(3, 3), 100); // pity : 3 échecs
      expect(Enchant.rate(8, 5), 100);
      expect(Enchant.rate(15, 8), 100);
      expect(Enchant.bonusPercent(5), 20);
      expect(Enchant.bonusPercent(10), 50);
      expect(Enchant.bonusPercent(15), 95);
    });

    test('sur de nombreux tirages, la réussite suit le taux affiché', () {
      final r = Random(42);
      for (final target in [1, 6, 15]) {
        var ok = 0;
        const n = 20000;
        for (var i = 0; i < n; i++) {
          if (Enchant.succeeds(target, 0, r.nextDouble() * 100)) ok++;
        }
        expect(ok / n, closeTo(Enchant.baseRate(target) / 100, 0.015));
      }
    });

    test('un échec ne détruit rien ni ne fait perdre de niveau', () {
      final inv = InventoryRepository(
        db,
        content,
        res,
        random: Random(1),
        now: () => now,
      );
      res.grant(Currency.dinars, 5000, key: 'test', source: 'test');
      res.grant(Currency.pierres, 100, key: 'test-p', source: 'test');
      final item = content.items().first;
      expect(inv.buy(item), isTrue);
      var o = inv.owned().single;
      var maxSeen = 0;
      for (var i = 0; i < 60 && o.level < Enchant.maxLevel; i++) {
        final before = o.level;
        final out = inv.enchant(o);
        o = inv.owned().single;
        if (out == EnchantOutcome.failure) expect(o.level, before);
        if (out == EnchantOutcome.success) expect(o.level, before + 1);
        maxSeen = max(maxSeen, o.fails);
        expect(o.fails, lessThanOrEqualTo(Enchant.pity(o.level + 1)));
      }
      expect(inv.owned(), hasLength(1));
    });

    test('équiper remplace l’objet du même emplacement ; bonus d’ensemble', () {
      final inv = InventoryRepository(db, content, res, now: () => now);
      res.grant(Currency.dinars, 1000, key: 'test', source: 'test');
      final byId = {for (final i in content.items()) i.id: i};
      for (final id in ['baton', 'plume', 'cape', 'turban']) {
        inv.buy(byId[id]!);
      }
      OwnedItem own(String id) =>
          inv.owned().firstWhere((o) => o.item.id == id);
      inv.equip(own('baton'));
      inv.equip(own('plume'));
      expect(inv.equipped().map((o) => o.item.id), ['plume']);
      inv
        ..equip(own('baton'))
        ..equip(own('cape'))
        ..equip(own('turban'));
      final s = heroStats(1, inv.equipped());
      // Base 50 PV et 10 d'attaque ; cape +8 PV ; bâton +2 ; turban +1 ;
      // ensemble « Voyageur du désert » (3 pièces) : +10 PV, +1 attaque.
      expect(s.pv, 68);
      expect(s.attaque, 13);
      expect(s.defense, 1);
    });
  });

  group('Expédition', () {
    test('répartition : au plus 3 vagues puis un gardien', () {
      expect(splitQuestions(3), [3]);
      expect(splitQuestions(4), [2, 2]);
      expect(splitQuestions(20), [5, 5, 5, 5]);
      expect(splitQuestions(13).reduce((a, b) => a + b), 13);
    });

    test('sans erreur, tous les adversaires tombent ; trop d’erreurs : '
        'repli', () {
      const hero = Stats(pv: 50, attaque: 10);
      final win = ExpeditionFight(questions: 12, hero: hero);
      for (var i = 0; i < 12 && !win.over; i++) {
        win.answer(right: true, time: const Duration(seconds: 5));
      }
      expect(win.won, isTrue);
      final lose = ExpeditionFight(questions: 12, hero: hero, overdue: 50);
      // L'Oubli frappe plus fort quand des révisions sont en retard.
      expect(lose.foeStrike, 13);
      while (!lose.over) {
        lose.answer(right: false, time: const Duration(seconds: 5));
      }
      expect(lose.lost, isTrue);
    });

    test('sans chronomètre, pas de coup critique', () {
      const hero = Stats(pv: 50, attaque: 10);
      final f = ExpeditionFight(questions: 4, hero: hero, timer: false);
      expect(
        f.answer(right: true, time: const Duration(seconds: 1)).critical,
        isFalse,
      );
    });
  });
}
