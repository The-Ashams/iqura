import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/world.dart';
import '../../game/world_providers.dart';
import 'combat_screen.dart';
import 'pixel.dart';
import 'sprites.dart';

/// Un lieu de la carte : sa scène, ses personnages et une fenêtre de
/// dialogue (cahier v3 §8.3).
class PlaceScreen extends ConsumerWidget {
  const PlaceScreen({super.key, required this.place});

  final Place place;

  /// Les leçons au format mini-donjon arrivent à l'étape 4 du jalon J1a.
  static const String lessonNotReady =
      "Jouable à l'étape 4 du jalon J1a (leçons en mini-donjon)";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characters = [
      for (final c in ref.watch(regionCharactersProvider))
        if (c.places.contains(place.id) && c.sprite != null) c,
    ];
    final ground = (place.groundY ?? 62).toDouble();
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
                  for (final n in place.lessons)
                    PixelCommand(
                      label: 'Leçon $n',
                      detail: lessonNotReady,
                      onPressed: null,
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
