import 'package:flutter/material.dart';

import 'pixel.dart';

/// Cité minimale (jalon J1a) : vue de la cité à reconstruire. Boutique,
/// équipement et enchantement arrivent à l'étape 6.
class CityScreen extends StatelessWidget {
  const CityScreen({super.key});

  static const List<String> buildings = [
    'La bibliothèque',
    "L'école",
    'Le marché',
    'La forge',
    'Le sanctuaire',
  ];

  static const String laterNotice =
      "Boutique, équipement et enchantement : à l'étape 6 du jalon J1a.";

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: GameColors.night,
    body: SafeArea(
      child: GameBody(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: const SceneView(background: 'scene_cite'),
            ),
            const SizedBox(height: 12),
            PixelWindow(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'La Cité du savoir',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  for (final b in buildings)
                    PixelCommand(
                      label: b,
                      detail: 'À reconstruire',
                      onPressed: null,
                    ),
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      laterNotice,
                      style: TextStyle(color: GameColors.muted, fontSize: 14),
                    ),
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
