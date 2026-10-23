/// Révisions FSRS (cahier v3 §4, §6.3) : cartes créées à la réussite d'une
/// leçon, planifiées par FSRS-6 (paquet `fsrs`, paramètres par défaut),
/// note déduite de la justesse et du temps de réponse.
library;

import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fsrs/fsrs.dart' as fsrs;
import 'package:uuid/uuid.dart';

import '../../core/providers.dart';
import '../../data/user_db/schema.dart';
import '../../data/user_db/user_database.dart';
import '../../game/lesson/lesson.dart';
import '../resources/resources.dart';

/// Sorte de carte (région 1, cahier §6.3).
enum CardKind {
  /// Forme → nom et son : la lettre est montrée, on choisit son nom entendu.
  reconnaitre,

  /// Son → lettre : le nom est joué, on choisit la lettre.
  ecouter,

  /// Un signe ou une règle : une syllabe entendue, on choisit son écriture.
  signe,

  /// Une syllabe ou un mot écrit : on choisit sa lecture entendue.
  lire;

  static CardKind parse(String s) => values.byName(s);
}

/// État d'un élément (cahier §4) : jamais « maîtrisé » après une seule
/// réussite (la stabilité FSRS après un premier « facile » reste sous le
/// seuil de « maîtrisé »).
enum MasteryLevel { apprentissage, reconnu, maitrise }

/// Seuils de stabilité FSRS (jours) des états « reconnu » et « maîtrisé »
/// (décision du 23/10/2026, niveau Débutant 1).
const double recognizedStability = 7;
const double masteredStability = 21;

MasteryLevel masteryOf(fsrs.Card c) {
  final s = c.stability ?? 0;
  if (c.state != fsrs.State.review) return MasteryLevel.apprentissage;
  if (s >= masteredStability) return MasteryLevel.maitrise;
  if (s >= recognizedStability) return MasteryLevel.reconnu;
  return MasteryLevel.apprentissage;
}

/// Note FSRS d'une réponse (cahier §6.3) : faux = à revoir ; juste en plus
/// de 8 s = difficile ; de 3 à 8 s = bien ; moins de 3 s = facile.
/// Chronomètre désactivé : toute réponse juste vaut « bien ».
fsrs.Rating ratingFor({
  required bool right,
  required Duration time,
  bool timer = true,
}) {
  if (!right) return fsrs.Rating.again;
  if (!timer) return fsrs.Rating.good;
  if (time > const Duration(seconds: 8)) return fsrs.Rating.hard;
  if (time >= const Duration(seconds: 3)) return fsrs.Rating.good;
  return fsrs.Rating.easy;
}

class ReviewCard {
  const ReviewCard({
    required this.id,
    required this.lessonId,
    required this.kind,
    required this.target,
    required this.state,
    required this.bestLevel,
  });

  final String id;
  final String lessonId;
  final CardKind kind;

  /// Lettre, nom de signe (`fatha`…) ou texte arabe à lire.
  final String target;
  final fsrs.Card state;
  final MasteryLevel bestLevel;

  DateTime get due => state.due;
  MasteryLevel get level => masteryOf(state);
}

/// Signes enseignés par les leçons (noms des données de leçon).
const Map<String, String> signMarks = {
  'fatha': 'َ',
  'kasra': 'ِ',
  'damma': 'ُ',
  'sukun': 'ْ',
};

/// Cartes d'une leçon réussie (cahier §6.3, région 1) : pour chaque lettre
/// introduite, « reconnaître » et « écouter » ; une par signe ; une « lire »
/// par syllabe et par mot. Identifiants stables : une carte n'est jamais
/// créée deux fois.
List<({String id, CardKind kind, String target})> cardsOfLesson(
  Lesson lesson, {
  required List<String> letters,
  required List<String> signs,
  required List<String> readings,
}) => [
  for (final l in letters) ...[
    (id: 'reconnaitre:$l', kind: CardKind.reconnaitre, target: l),
    (id: 'ecouter:$l', kind: CardKind.ecouter, target: l),
  ],
  for (final s in signs) (id: 'signe:$s', kind: CardKind.signe, target: s),
  for (final r in readings) (id: 'lire:$r', kind: CardKind.lire, target: r),
];

class ReviewRepository {
  ReviewRepository(this._db, this._resources, {DateTime Function()? now})
    : _now = now ?? DateTime.now;

  final UserDatabase _db;
  final ResourceRepository _resources;
  final DateTime Function() _now;

  /// Planificateur FSRS-6, paramètres par défaut officiels ; la petite
  /// variation aléatoire des intervalles évite que des cartes apprises
  /// ensemble reviennent toujours ensemble.
  static final fsrs.Scheduler scheduler = fsrs.Scheduler();

  List<ReviewCard> all() => [
    for (final r in _db.select('SELECT * FROM card WHERE deleted = 0'))
      _fromRow(r),
  ];

  ReviewCard? get(String id) {
    final rows = _db.select('SELECT * FROM card WHERE id = ? AND deleted = 0', [
      id,
    ]);
    return rows.isEmpty ? null : _fromRow(rows.first);
  }

  /// Cartes dues maintenant, les plus en retard d'abord.
  List<ReviewCard> due({DateTime? at}) => [
    for (final r in _db.select(
      'SELECT * FROM card WHERE deleted = 0 AND due <= ? ORDER BY due',
      [(at ?? _now()).millisecondsSinceEpoch],
    ))
      _fromRow(r),
  ];

  static ReviewCard _fromRow(Map<String, Object?> r) => ReviewCard(
    id: r['id']! as String,
    lessonId: r['lesson_id']! as String,
    kind: CardKind.parse(r['kind']! as String),
    target: r['target']! as String,
    state: fsrs.Card.fromMap(
      jsonDecode(r['fsrs']! as String) as Map<String, dynamic>,
    ),
    bestLevel: MasteryLevel.values[r['best_level']! as int],
  );

  /// Crée les cartes absentes ; renvoie le nombre de cartes créées. Les
  /// cartes neuves sont dues tout de suite (premier passage dans
  /// l'Expédition).
  int createCards(
    String lessonId,
    List<({String id, CardKind kind, String target})> cards,
  ) {
    final now = _now().toUtc();
    var created = 0;
    for (final c in cards) {
      if (get(c.id) != null) continue;
      final card = fsrs.Card(
        cardId: now.millisecondsSinceEpoch + created,
        due: now,
      );
      _write(
        id: c.id,
        lessonId: lessonId,
        kind: c.kind,
        target: c.target,
        card: card,
        best: MasteryLevel.apprentissage,
        createdAt: now,
      );
      created++;
    }
    return created;
  }

  void _write({
    required String id,
    required String lessonId,
    required CardKind kind,
    required String target,
    required fsrs.Card card,
    required MasteryLevel best,
    required DateTime createdAt,
  }) => _db.upsert(cardTable, {
    'id': id,
    'lesson_id': lessonId,
    'kind': kind.name,
    'target': target,
    'fsrs': jsonEncode(card.toMap()),
    'due': card.due.millisecondsSinceEpoch,
    'best_level': best.index,
    'created_at': createdAt.millisecondsSinceEpoch,
  });

  /// Enregistre une révision : nouvel état FSRS, journal, et pierres de
  /// savoir si l'élément atteint pour la première fois « reconnu » (1) ou
  /// « maîtrisé » (3). Renvoie la note et le gain de pierres.
  ({fsrs.Rating rating, int stones, ReviewCard card}) review(
    String id, {
    required bool right,
    required Duration time,
    bool timer = true,
    String origin = 'expedition',
  }) {
    final c = get(id)!;
    final now = _now().toUtc();
    final rating = ratingFor(right: right, time: time, timer: timer);
    final result = scheduler.reviewCard(
      c.state,
      rating,
      reviewDateTime: now,
      reviewDuration: time.inMilliseconds,
    );
    final level = masteryOf(result.card);
    final best = MasteryLevel.values[max(level.index, c.bestLevel.index)];
    var stones = 0;
    _db.transaction(() {
      _write(
        id: id,
        lessonId: c.lessonId,
        kind: c.kind,
        target: c.target,
        card: result.card,
        best: best,
        createdAt: now,
      );
      _db.append(reviewLogTable, {
        'id': const Uuid().v7(),
        'card_id': id,
        'rating': rating.value,
        'reviewed_at': now.millisecondsSinceEpoch,
        'duration_ms': time.inMilliseconds,
        'origin': origin,
      });
    });
    if (best.index > c.bestLevel.index) {
      for (var l = c.bestLevel.index + 1; l <= best.index; l++) {
        final gain = l == MasteryLevel.reconnu.index ? 1 : 3;
        _resources.grant(
          Currency.pierres,
          gain,
          key: 'pierre:$id:$l',
          source: 'carte $id ${MasteryLevel.values[l].name}',
        );
        stones += gain;
      }
    }
    return (rating: rating, stones: stones, card: get(id)!);
  }

  /// Nombre d'éléments par état (indicateurs du Grimoire).
  Map<MasteryLevel, int> counts() {
    final m = {for (final l in MasteryLevel.values) l: 0};
    for (final c in all()) {
      m[c.level] = m[c.level]! + 1;
    }
    return m;
  }
}

final reviewRepositoryProvider = Provider<ReviewRepository>(
  (ref) => ReviewRepository(
    ref.watch(userDatabaseProvider),
    ref.watch(resourceRepositoryProvider),
  ),
);

/// Nombre de cartes dues, relu après chaque révision.
final dueCountProvider = NotifierProvider<DueCountNotifier, int>(
  DueCountNotifier.new,
);

class DueCountNotifier extends Notifier<int> {
  @override
  int build() => ref.watch(reviewRepositoryProvider).due().length;

  void refresh() => state = ref.read(reviewRepositoryProvider).due().length;
}
