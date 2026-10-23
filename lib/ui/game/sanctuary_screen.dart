import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../widgets/arabic_text.dart';
import 'pixel.dart';

/// Sanctuaire minimal (jalon J1a) : lieu calme, sans aucun combat, où l'on
/// lit Al-Fātiḥa, ouverte d'office (cahier v3 §9). Le texte vient de la base
/// vérifiée (Tanzil, empreinte SHA-256) et n'est jamais recopié ni modifié.
class SanctuaryScreen extends ConsumerWidget {
  const SanctuaryScreen({super.key});

  static const String recitationNotice =
      "Récitation d'al-Ḥuṣarī : téléchargement pas encore disponible.";
  static const String recognitionNotice =
      'Part des mots reconnus : calculée quand les révisions seront '
      "branchées (étape 6 du jalon J1a).";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verses = ref.watch(contentDatabaseProvider).surahVerses(1);
    return Scaffold(
      backgroundColor: GameColors.night,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: const SceneView(background: 'scene_sanctuaire'),
            ),
            const SizedBox(height: 12),
            const PixelWindow(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Le Sanctuaire', style: TextStyle(fontSize: 24)),
                  Text(
                    'Al-Fātiḥa (sourate 1)',
                    style: TextStyle(color: GameColors.accent, fontSize: 16),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '$recitationNotice\n$recognitionNotice',
                    style: TextStyle(color: GameColors.muted, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            for (final v in verses)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6EFDF),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ArabicText(
                        v.arabic,
                        quran: true,
                        baseSize: 30,
                        style: const TextStyle(color: Color(0xFF2A1F18)),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${v.surah}:${v.ayah} — ${v.translation}',
                        style: const TextStyle(
                          color: Color(0xFF4A3F33),
                          fontFamily: 'Amiri',
                          fontSize: 17,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const Text(
              'Texte : Tanzil (copie vérifiée). Traduction : Muhammad '
              'Hamidullah, version diffusée par Tanzil (édition non précisée).',
              style: TextStyle(color: GameColors.muted, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
