import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/settings/settings.dart';

/// Polices arabes embarquées (SIL Open Font License 1.1).
abstract final class ArabicFonts {
  /// Texte arabe courant (leçons, exemples construits, interface).
  static const String text = 'Amiri';

  /// Écriture du Mushaf (mots isolés de la leçon 14) : gère tous ses signes.
  static const String mushaf = 'AmiriQuran';
}

/// Texte arabe, écrit de droite à gauche, à la taille choisie dans les
/// réglages. [mushaf] à vrai pour un mot écrit avec les signes du Mushaf.
class ArabicText extends ConsumerWidget {
  const ArabicText(
    this.text, {
    super.key,
    this.baseSize = 28,
    this.style,
    this.mushaf = false,
  });

  final String text;
  final double baseSize;
  final TextStyle? style;
  final bool mushaf;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scale = ref.watch(settingsProvider.select((s) => s.arabicFontScale));
    return Text(
      text,
      textDirection: TextDirection.rtl,
      style: (style ?? const TextStyle()).copyWith(
        fontFamily: mushaf ? ArabicFonts.mushaf : ArabicFonts.text,
        fontSize: baseSize * scale,
        height: mushaf ? 2.0 : 1.8,
      ),
    );
  }
}
