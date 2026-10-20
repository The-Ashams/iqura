import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/settings/settings.dart';

/// Texte arabe, écrit de droite à gauche, à la taille choisie dans les
/// réglages.
class ArabicText extends ConsumerWidget {
  const ArabicText(this.text, {super.key, this.baseSize = 28, this.style});

  final String text;
  final double baseSize;
  final TextStyle? style;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scale = ref.watch(settingsProvider.select((s) => s.arabicFontScale));
    return Text(
      text,
      textDirection: TextDirection.rtl,
      style: (style ?? const TextStyle()).copyWith(
        fontSize: baseSize * scale,
        height: 1.8,
      ),
    );
  }
}
