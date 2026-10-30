import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../features/progress/lesson_progress.dart';
import '../../game/lesson/lesson.dart';
import '../../game/world.dart';
import '../../game/world_providers.dart';
import '../../features/review/review.dart';
import 'expedition_screen.dart';
import 'exam/data_exam_screen.dart';
import 'exam/region_exam_screen.dart';
import 'lesson/lesson_screen.dart';
import 'pixel.dart';
import 'sprites.dart';

/// Un lieu de la carte : sa scène, ses personnages et une fenêtre de
/// dialogue (cahier v3 §8.3).
/// Lieu de l'examen de la région 1 (la porte de la bibliothèque).
const String regionExamPlace = 'porte';

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
      final previous = stage.lastWhere((l) => l.ordinal < lesson.ordinal);
      return 'Fermée : réussis d\'abord le mini-boss de la leçon '
          '${previous.number}';
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
    // Leçons de l'étape de la région en cours.
    final region = ref.watch(currentRegionProvider);
    final db = ref.watch(contentDatabaseProvider);
    final stage = db.lessons(region.number);
    final dataExam = region.number >= 2 ? db.regionExam(region.number) : null;
    final progress = ref.watch(lessonProgressProvider);
    final due = ref.watch(dueCountProvider);
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
        child: GameBody(
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
                            style: TextStyle(
                              color: GameColors.accent,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const AiTag(),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      place.description,
                      style: const TextStyle(height: 1.4),
                    ),
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
                        label: 'Leçon ${l.number} · ${l.title}',
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
                    if (place.id == regionExamPlace && region.number == 1)
                      examCommand(context, stage, progress),
                    if (dataExam != null && dataExam.place == place.id)
                      dataExamCommand(
                        context,
                        dataExam.id,
                        dataExam.title,
                        region.number,
                        stage,
                        progress,
                      ),
                    if (place.lessons.isEmpty)
                      PixelCommand(
                        label: region.number == 1
                            ? "L'Expédition : affronter les brumes d'oubli"
                            : "L'Expédition : affronter les mirages de la "
                                  'Confusion',
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

  /// Le boss d'une région écrit en données (région 2 et suivantes) : ouvert
  /// quand toutes les leçons de la région sont terminées.
  static Widget dataExamCommand(
    BuildContext context,
    String examId,
    String title,
    int region,
    List<LessonSummary> stage,
    Map<String, LessonProgress> progress,
  ) {
    final open = stage.every((l) => progress[l.id]?.completed ?? false);
    final done = progress[examId]?.completed ?? false;
    return PixelCommand(
      label: '$title · examen de la région',
      detail: !open
          ? 'Termine d\'abord les ${stage.length} leçons de la région'
          : done
          ? 'Réussi · le rejouer'
          : 'Trois épreuves : un récit, l\'écoute, répondre',
      onPressed: open
          ? () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => DataExamScreen(region: region),
              ),
            )
          : null,
    );
  }

  /// Le boss de la région : ouvert quand toutes les leçons de l'étape sont
  /// terminées (les 14 sceaux brisés).
  static Widget examCommand(
    BuildContext context,
    List<LessonSummary> stage,
    Map<String, LessonProgress> progress,
  ) {
    final open = stage.every((l) => progress[l.id]?.completed ?? false);
    final done = progress[RegionExamScreen.examId]?.completed ?? false;
    return PixelCommand(
      label: "Le Gardien de l'Oubli · examen de la région",
      detail: !open
          ? 'Brise d\'abord les 14 sceaux (leçons 0 à 14)'
          : done
          ? 'Réussi · le rejouer'
          : 'Trois épreuves : lecture, écoute, prononciation',
      onPressed: open
          ? () => Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (_) => const RegionExamScreen()),
            )
          : null,
    );
  }
}
