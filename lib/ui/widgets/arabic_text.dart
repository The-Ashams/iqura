import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/settings/settings.dart';

/// Polices arabes embarquées (SIL Open Font License 1.1).
abstract final class ArabicFonts {
  /// Texte arabe courant (leçons, exemples construits, interface).
  static const String text = 'Amiri';

  /// Texte coranique (Tanzil Uthmani) : gère tous les signes du Mushaf.
  static const String quran = 'AmiriQuran';
}

/// Texte arabe, écrit de droite à gauche, à la taille choisie dans les
/// réglages. [quran] à vrai pour le texte coranique, lu dans la base vérifiée.
class ArabicText extends ConsumerWidget {
  const ArabicText(
    this.text, {
    super.key,
    this.baseSize = 28,
    this.style,
    this.quran = false,
  });

  final String text;
  final double baseSize;
  final TextStyle? style;
  final bool quran;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scale = ref.watch(settingsProvider.select((s) => s.arabicFontScale));
    return Text(
      text,
      textDirection: TextDirection.rtl,
      style: (style ?? const TextStyle()).copyWith(
        fontFamily: quran ? ArabicFonts.quran : ArabicFonts.text,
        fontSize: baseSize * scale,
        height: quran ? 2.0 : 1.8,
      ),
    );
  }
}
