import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../features/progress/lesson_progress.dart';
import '../../game/lesson/lesson.dart';
import '../../game/world.dart';
import '../../game/world_providers.dart';
import 'combat_screen.dart';
import 'lesson/lesson_screen.dart';
import 'pixel.dart';
import 'sprites.dart';

/// Un lieu de la carte : sa scène, ses personnages et une fenêtre de
/// dialogue (cahier v3 §8.3).
class PlaceScreen extends ConsumerWidget {
  const PlaceScreen({super.key, required this.place});

  final Place place;

  /// Leçons pas encore réécrites au format mini-donjon.
  static const String lessonNotReady =
      "Jouable à l'étape 5 du jalon J1a (réécriture en mini-donjon)";

  /// État d'une leçon, affiché sous son nom.
  static String lessonStatus(
    LessonSummary lesson,
    List<LessonSummary> stage,
    Map<String, LessonProgress> progress,
  ) {
    if (!lesson.playable) return lessonNotReady;
    if (!lessonUnlocked(lesson, stage, progress)) {
      return 'Fermée : réussis d\'abord le mini-boss de la leçon '
          '${lesson.ordinal - 1}';
    }
    final p = progress[lesson.id];
    if (p == null) return 'Nouvelle';
    if (p.completed) return 'Terminée · rejouer';
    return 'En cours · reprendre à l\'écran ${p.step + 1}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characters = [
      for (final c in ref.watch(regionCharactersProvider))
        if (c.places.contains(place.id) && c.sprite != null) c,
    ];
    final ground = (place.groundY ?? 62).toDouble();
    // Leçons de l'étape 1 (région 1, jalon J1a).
    final stage = ref.watch(contentDatabaseProvider).lessons(1);
    final progress = ref.watch(lessonProgressProvider);
    final parts = <ScenePart>[
      for (final (i, c) in characters.indexed)
        _sprite(c.sprite!, 26.0 + i * 20, ground),
      _sprite('voyageur', 116, ground),
    ];
    final speaker = characters.isEmpty ? null : characters.first;
    return Scaffold(
      backgroundColor: GameColors.night,
      appBar: AppBar(
        title: Text(place.name),
        backgroundColor: GameColors.night,
        foregroundColor: GameColors.text,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: SceneView(background: place.sceneImage!, parts: parts),
            ),
            const SizedBox(height: 12),
            PixelWindow(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          speaker == null
                              ? 'Le voyageur'
                              : '${speaker.name}, ${speaker.role.toLowerCase()}',
                          style: const TextStyle(
                            color: GameColors.accent,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const AiTag(),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(place.description, style: const TextStyle(height: 1.4)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            PixelWindow(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  for (final l in stage.where(
                    (l) => place.lessons.contains(l.ordinal),
                  ))
                    PixelCommand(
                      label: 'Leçon ${l.ordinal} · ${l.title}',
                      detail: lessonStatus(l, stage, progress),
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
                  if (place.lessons.isEmpty)
                    PixelCommand(
                      label: "Affronter les brumes d'oubli",
                      detail: CombatScreen.practiceNotice,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (_) => const CombatScreen(),
                        ),
                      ),
                    ),
                  PixelCommand(
                    label: 'Retour à la carte',
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
