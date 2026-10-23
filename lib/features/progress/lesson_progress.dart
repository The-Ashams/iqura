/// Progression dans les leçons : écran où reprendre, réussite du mini-boss,
/// leçon suivante débloquée (cahier v3 §6.2).
library;

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/user_db/schema.dart';
import '../../data/user_db/user_database.dart';
import '../../game/lesson/lesson.dart';

@immutable
class LessonProgress {
  const LessonProgress({
    required this.lessonId,
    this.step = 0,
    this.completedAt,
    this.bestScore = 0,
    this.bossFailures = 0,
  });

  final String lessonId;

  /// Écran où reprendre.
  final int step;

  /// Première réussite du mini-boss.
  final DateTime? completedAt;
  final int bestScore;

  /// Échecs au mini-boss depuis la dernière réussite.
  final int bossFailures;

  bool get completed => completedAt != null;
}

class LessonProgressRepository {
  LessonProgressRepository(this._db, {DateTime Function()? now})
    : _now = now ?? DateTime.now;

  final UserDatabase _db;
  final DateTime Function() _now;

  Map<String, LessonProgress> loadAll() => {
    for (final r in _db.select(
      'SELECT * FROM lesson_progress WHERE deleted = 0',
    ))
      r['lesson_id'] as String: LessonProgress(
        lessonId: r['lesson_id'] as String,
        step: r['step'] as int,
        completedAt: r['completed_at'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(r['completed_at'] as int),
        bestScore: r['best_score'] as int,
        bossFailures: r['boss_failures'] as int,
      ),
  };

  LessonProgress get(String lessonId) =>
      loadAll()[lessonId] ?? LessonProgress(lessonId: lessonId);

  void _write(LessonProgress p) => _db.upsert(lessonProgressTable, {
    'lesson_id': p.lessonId,
    'step': p.step,
    'completed_at': p.completedAt?.millisecondsSinceEpoch,
    'best_score': p.bestScore,
    'boss_failures': p.bossFailures,
  });

  /// Enregistre l'écran atteint.
  void saveStep(String lessonId, int step) {
    final p = get(lessonId);
    if (p.step == step) return;
    _write(
      LessonProgress(
        lessonId: lessonId,
        step: step,
        completedAt: p.completedAt,
        bestScore: p.bestScore,
        bossFailures: p.bossFailures,
      ),
    );
  }

  /// Enregistre un mini-boss : réussi (la leçon est terminée, la suivante
  /// s'ouvre) ou non (rien n'est perdu ; l'échec est compté).
  LessonProgress recordBoss(
    String lessonId, {
    required int score,
    required bool passed,
  }) {
    final p = get(lessonId);
    final next = LessonProgress(
      lessonId: lessonId,
      step: p.step,
      completedAt: p.completedAt ?? (passed ? _now() : null),
      bestScore: max(p.bestScore, score),
      bossFailures: passed ? 0 : p.bossFailures + 1,
    );
    _write(next);
    return next;
  }
}

final lessonProgressRepositoryProvider = Provider<LessonProgressRepository>(
  (ref) => LessonProgressRepository(ref.watch(userDatabaseProvider)),
);

final lessonProgressProvider =
    NotifierProvider<LessonProgressNotifier, Map<String, LessonProgress>>(
      LessonProgressNotifier.new,
    );

class LessonProgressNotifier extends Notifier<Map<String, LessonProgress>> {
  LessonProgressRepository get _repo =>
      ref.read(lessonProgressRepositoryProvider);

  @override
  Map<String, LessonProgress> build() =>
      ref.watch(lessonProgressRepositoryProvider).loadAll();

  void saveStep(String lessonId, int step) {
    _repo.saveStep(lessonId, step);
    state = _repo.loadAll();
  }

  LessonProgress recordBoss(
    String lessonId, {
    required int score,
    required bool passed,
  }) {
    final p = _repo.recordBoss(lessonId, score: score, passed: passed);
    state = _repo.loadAll();
    return p;
  }
}

/// Une leçon est ouverte si c'est la première de l'étape ou si la
/// précédente est terminée (mini-boss réussi).
bool lessonUnlocked(
  LessonSummary lesson,
  List<LessonSummary> stageLessons,
  Map<String, LessonProgress> progress,
) {
  final before = stageLessons.where((l) => l.ordinal < lesson.ordinal);
  if (before.isEmpty) return true;
  final previous = before.reduce((a, b) => a.ordinal > b.ordinal ? a : b);
  return progress[previous.id]?.completed ?? false;
}
