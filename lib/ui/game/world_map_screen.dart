import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/profile/profile.dart';
import '../../game/world.dart';
import '../../game/world_providers.dart';
import 'pixel.dart';
import 'place_screen.dart';

/// Carte à étapes de la région en cours (cahier v3 §8.3) : lieux reliés par
/// des chemins ; on touche un lieu pour s'y rendre.
class WorldMapScreen extends ConsumerWidget {
  const WorldMapScreen({super.key});

  static const String lockedDetail = 'À venir (prochains niveaux)';

  void _open(BuildContext context, Place place) => Navigator.push(
    context,
    MaterialPageRoute<void>(builder: (_) => PlaceScreen(place: place)),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final region = ref.watch(currentRegionProvider);
    final places = ref.watch(regionPlacesProvider);
    final pseudo = ref.watch(profileProvider)?.pseudo ?? '';
    final byId = {for (final p in places) p.id: p};
    return Scaffold(
      backgroundColor: GameColors.night,
      body: SafeArea(
        child: GameBody(
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              PixelWindow(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bienvenue, $pseudo',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'RÉGION ${region.number} · ${region.skill.toUpperCase()}',
                      style: const TextStyle(
                        color: GameColors.accent,
                        fontSize: 14,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(region.name, style: const TextStyle(fontSize: 24)),
                    Text(
                      'Adversaire : ${region.adversary}',
                      style: const TextStyle(color: GameColors.muted),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SceneView(
                  background: region.mapImage,
                  parts: [
                    ScenePart(
                      x: 0,
                      y: 0,
                      width: sceneWidth,
                      height: sceneHeight,
                      child: CustomPaint(painter: _PathsPainter(places, byId)),
                    ),
                    for (final p in places)
                      ScenePart(
                        x: p.mapX - 4,
                        y: p.mapY - 4,
                        width: 8,
                        height: 8,
                        child: _PlaceMarker(
                          place: p,
                          onTap: p.inVerticalSlice
                              ? () => _open(context, p)
                              : null,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              PixelWindow(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Column(
                  children: [
                    for (final p in places)
                      PixelCommand(
                        label: '${p.number}. ${p.name}',
                        detail: p.inVerticalSlice
                            ? _lessonsLabel(p)
                            : lockedDetail,
                        onPressed: p.inVerticalSlice
                            ? () => _open(context, p)
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

  static String? _lessonsLabel(Place p) => switch (p.lessons.length) {
    0 => 'Expédition quotidienne',
    1 => 'Leçon ${p.lessons.first}',
    _ => 'Leçons ${p.lessons.join(' et ')}',
  };
}

class _PlaceMarker extends StatelessWidget {
  const _PlaceMarker({required this.place, required this.onTap});

  final Place place;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final open = onTap != null;
    return Semantics(
      button: open,
      label: open
          ? place.name
          : '${place.name}. ${WorldMapScreen.lockedDetail}',
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: open ? GameColors.accent : const Color(0xFF8A8577),
            border: Border.all(color: const Color(0xFF3A2A20), width: 2),
          ),
        ),
      ),
    );
  }
}

/// Chemins pointillés entre lieux reliés, en pixels de la carte.
class _PathsPainter extends CustomPainter {
  _PathsPainter(this.places, this.byId);

  final List<Place> places;
  final Map<String, Place> byId;

  @override
  void paint(Canvas canvas, Size size) {
    final k = size.width / sceneWidth;
    final paint = Paint()..color = const Color(0xFF8A6A3C);
    for (final a in places) {
      for (final id in a.links) {
        final b = byId[id]!;
        final dx = (b.mapX - a.mapX).toDouble();
        final dy = (b.mapY - a.mapY).toDouble();
        final steps = (dx.abs() > dy.abs() ? dx.abs() : dy.abs()).round();
        for (var i = 0; i <= steps; i += 3) {
          final x = (a.mapX + dx * i / steps).roundToDouble();
          final y = (a.mapY + dy * i / steps).roundToDouble();
          canvas.drawRect(Rect.fromLTWH(x * k, y * k, k, k), paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(_PathsPainter old) => old.places != places;
}
