import 'dart:math';

import 'package:flutter/widgets.dart';

/// Agrandit toute l'interface sur les grandes fenêtres (PC, tablette) :
/// le jeu est dessiné pour une fenêtre d'environ [referenceWidth] ×
/// [referenceHeight], puis agrandi en gardant ses proportions, au lieu de
/// rester petit au milieu d'un grand écran. Sur téléphone, rien ne change.
class ScreenScaler extends StatelessWidget {
  const ScreenScaler({super.key, required this.child});

  static const double referenceWidth = 1000;
  static const double referenceHeight = 800;
  static const double maxScale = 2.5;

  /// Facteur d'agrandissement pour une fenêtre de taille [size].
  static double scaleFor(Size size) => min(
    size.width / referenceWidth,
    size.height / referenceHeight,
  ).clamp(1.0, maxScale);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final scale = scaleFor(media.size);
    if (scale == 1) return child;
    final size = media.size / scale;
    return FittedBox(
      fit: BoxFit.fill,
      alignment: Alignment.topLeft,
      child: SizedBox.fromSize(
        size: size,
        child: MediaQuery(
          data: media.copyWith(
            size: size,
            devicePixelRatio: media.devicePixelRatio * scale,
            padding: media.padding / scale,
            viewPadding: media.viewPadding / scale,
            viewInsets: media.viewInsets / scale,
          ),
          child: child,
        ),
      ),
    );
  }
}
