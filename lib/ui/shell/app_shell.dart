import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../game/city_screen.dart';
import '../game/grimoire_screen.dart';
import '../game/pixel.dart';
import '../game/world_map_screen.dart';
import '../screens/settings_screen.dart';

class _Space {
  const _Space(this.label, this.icon, this.selectedIcon);
  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

const _spaces = [
  _Space('Carte', Icons.map_outlined, Icons.map),
  _Space('Cité', Icons.castle_outlined, Icons.castle),
  _Space('Grimoire', Icons.menu_book_outlined, Icons.menu_book),
  _Space('Paramètres', Icons.settings_outlined, Icons.settings),
];

/// Les espaces du jeu (cahier §8.3 ; plus de Sanctuaire depuis l'avenant
/// n° 1) : barre en bas sur écran étroit
/// (téléphone), rail latéral sur écran large (Windows, tablette).
class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  /// Largeur à partir de laquelle on passe au rail latéral.
  static const double wideBreakpoint = 720;

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  int _index = 0;

  Widget _page(int i) => switch (i) {
    0 => const WorldMapScreen(),
    1 => const CityScreen(),
    2 => const GrimoireScreen(),
    _ => const SettingsScreen(),
  };

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= AppShell.wideBreakpoint;
    final body = _page(_index);
    void select(int i) => setState(() => _index = i);

    if (wide) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              backgroundColor: GameColors.window,
              indicatorColor: GameColors.accent,
              unselectedIconTheme: IconThemeData(color: GameColors.muted),
              selectedIconTheme: IconThemeData(color: GameColors.night),
              unselectedLabelTextStyle: TextStyle(color: GameColors.muted),
              selectedLabelTextStyle: TextStyle(color: GameColors.text),
              selectedIndex: _index,
              onDestinationSelected: select,
              labelType: NavigationRailLabelType.all,
              destinations: [
                for (final s in _spaces)
                  NavigationRailDestination(
                    icon: Icon(s.icon),
                    selectedIcon: Icon(s.selectedIcon),
                    label: Text(s.label),
                  ),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: body),
          ],
        ),
      );
    }
    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        backgroundColor: GameColors.window,
        indicatorColor: GameColors.accent,
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(color: GameColors.text, fontSize: 13),
        ),
        selectedIndex: _index,
        onDestinationSelected: select,
        destinations: [
          for (final s in _spaces)
            NavigationDestination(
              icon: Icon(s.icon, color: GameColors.muted),
              selectedIcon: Icon(s.selectedIcon, color: GameColors.night),
              label: s.label,
            ),
        ],
      ),
    );
  }
}
