/// Mode « apprentissage seul » (cahier v3 §8.3) : la carte devient une
/// liste de leçons ; mêmes écrans de leçon sans scènes d'Histoire ; les
/// combats deviennent des séries de questions simples. La progression est
/// commune aux deux modes.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../features/progress/lesson_progress.dart';
import '../../features/review/review.dart';
import 'expedition_screen.dart';
import 'lesson/lesson_screen.dart';
import 'pixel.dart';
import 'place_screen.dart';
import 'status_bar.dart';

class LearningListView extends ConsumerWidget {
  const LearningListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stage = ref.watch(contentDatabaseProvider).lessons(1);
    final progress = ref.watch(lessonProgressProvider);
    final due = ref.watch(dueCountProvider);
    return Scaffold(
      backgroundColor: GameColors.night,
      body: SafeArea(
        child: GameBody(
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              const PixelWindow(
                child: Text(
                  'Apprentissage seul : les leçons, sans Histoire ni combats '
                  '(réglage réversible dans les Paramètres).',
                ),
              ),
              const SizedBox(height: 12),
              const HeroStatusBar(),
              const SizedBox(height: 12),
              PixelWindow(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    PixelCommand(
                      label: 'Révisions',
                      detail: due == 0
                          ? 'Aucune révision due pour l\'instant'
                          : '$due révision${due > 1 ? 's' : ''} à faire',
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (_) => const ExpeditionScreen(),
                        ),
                      ),
                    ),
                    for (final l in stage)
                      PixelCommand(
                        label: 'Leçon ${l.ordinal} · ${l.title}',
                        detail: PlaceScreen.lessonStatus(l, stage, progress),
                        onPressed:
                            l.playable && lessonUnlocked(l, stage, progress)
                            ? () => Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (_) => LessonScreen(lessonId: l.id),
                                ),
                              )
                            : null,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
