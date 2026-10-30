import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iqura/ui/game/pixel.dart';
import 'package:iqura/ui/theme.dart';

Color windowColor(WidgetTester tester) {
  final box = tester.widget<DecoratedBox>(
    find.descendant(
      of: find.byType(PixelWindow),
      matching: find.byType(DecoratedBox),
    ),
  );
  return (box.decoration as BoxDecoration).color!;
}

void main() {
  testWidgets('le thème clair s’applique aux écrans du jeu, et le '
      'changement de thème les redessine', (tester) async {
    Widget app(ThemeMode mode) => MaterialApp(
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      themeMode: mode,
      builder: (context, child) => GameThemeScope(child: child!),
      // Écran constant : il n'est redessiné que par GameThemeScope.
      home: const Scaffold(body: PixelWindow(child: Text('Bonjour'))),
    );

    await tester.pumpWidget(app(ThemeMode.light));
    await tester.pumpAndSettle();
    expect(GameColors.light, isTrue);
    final light = windowColor(tester);

    await tester.pumpWidget(app(ThemeMode.dark));
    await tester.pumpAndSettle();
    expect(GameColors.light, isFalse);
    final dark = windowColor(tester);
    expect(dark, isNot(light));
    expect(dark.computeLuminance(), lessThan(light.computeLuminance()));
  });
}
