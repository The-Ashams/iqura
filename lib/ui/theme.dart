import 'package:flutter/material.dart';

/// Police des textes du jeu (Pixelify Sans, SIL OFL 1.1).
const String gameFont = 'PixelifySans';

/// Couleur de base : sable du désert.
const Color _seed = Color(0xFFB8860B);

ThemeData buildTheme(Brightness brightness, {bool animations = true}) {
  final scheme = ColorScheme.fromSeed(seedColor: _seed, brightness: brightness);
  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    // Police pixel du jeu (OFL) ; Amiri complète les lettres qui lui manquent
    // (translittération : ḥ, ṯ, ǧ, ʿ…).
    fontFamily: gameFont,
    fontFamilyFallback: const ['Amiri'],
    visualDensity: VisualDensity.adaptivePlatformDensity,
    pageTransitionsTheme: animations
        ? const PageTransitionsTheme()
        : const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: _NoTransition(),
              TargetPlatform.windows: _NoTransition(),
              TargetPlatform.linux: _NoTransition(),
              TargetPlatform.macOS: _NoTransition(),
              TargetPlatform.iOS: _NoTransition(),
            },
          ),
  );
}

/// Changement d'écran sans animation.
class _NoTransition extends PageTransitionsBuilder {
  const _NoTransition();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) => child;
}
