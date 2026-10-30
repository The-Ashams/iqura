import 'package:flutter/material.dart';

import 'equipment_screens.dart';
import 'status_bar.dart';

import 'pixel.dart';

/// La Cité (cahier v3 §8.3, §8.6) : boutique, équipement et enchantement ;
/// les bâtiments seront reconstruits avec les matériaux des quêtes.
class CityScreen extends StatelessWidget {
  const CityScreen({super.key});

  static const List<String> buildings = [
    'La bibliothèque',
    "L'école",
    'Le marché',
    'La forge',
    'La Grande Salle de lecture',
    "L'Atelier des phrases",
  ];

  static const String laterNotice =
      'Les bâtiments se reconstruiront avec les matériaux des quêtes de '
      "l'Histoire (prochains niveaux).";

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
            const HeroStatusBar(),
            const SizedBox(height: 12),
            PixelWindow(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  PixelCommand(
                    label: 'Boutique du marché',
                    detail: 'Armes, capes, accessoires…',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => const ShopScreen(),
                      ),
                    ),
                  ),
                  PixelCommand(
                    label: 'Équipement et enchantement',
                    detail: 'Équiper ses objets, les enchanter de +1 à +15',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => const EquipmentScreen(),
                      ),
                    ),
                  ),
                ],
              ),
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
                  Padding(
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
