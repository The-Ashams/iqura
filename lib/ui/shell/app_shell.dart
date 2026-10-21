import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/profile/profile.dart';
import '../screens/planned_space_screen.dart';
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
  _Space('Sanctuaire', Icons.local_library_outlined, Icons.local_library),
  _Space('Paramètres', Icons.settings_outlined, Icons.settings),
];

/// Les cinq espaces de l'application (cahier des charges §4) : barre en bas sur écran étroit
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

  Widget _page(int i) {
    final pseudo = ref.watch(profileProvider)?.pseudo ?? '';
    return switch (i) {
      0 => PlannedSpaceScreen(
        title: 'Carte du monde',
        icon: Icons.map,
        header: Text(
          'Bienvenue, $pseudo',
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        description:
            'Une région par étape du cursus, en commençant par « Déchiffrer ». '
            "On y vit l'Histoire (personnages, enquêtes, inscriptions à "
            "déchiffrer) et l'Expédition quotidienne dans la Faille des "
            'Oubliés (révisions et boss).',
        plannedPhase: 'jalon J1 (région 1)',
      ),
      1 => const PlannedSpaceScreen(
        title: 'Cité',
        icon: Icons.castle,
        description:
            'Reconstruire la cité du savoir ; boutique, équipement, '
            'enchantement de +1 à +15 ; Forge des mots.',
        plannedPhase: 'jalon J1 (Cité minimale), Forge au jalon J2',
      ),
      2 => const PlannedSpaceScreen(
        title: 'Grimoire',
        icon: Icons.menu_book,
        description:
            'Dictionnaire personnel, alphabet, règles apprises, racines et '
            'arbre des racines, listes personnelles.',
        plannedPhase: 'jalon J1 (alphabet, premiers mots)',
      ),
      3 => const PlannedSpaceScreen(
        title: 'Sanctuaire',
        icon: Icons.local_library,
        description:
            'Lecture et étude du Coran, sans aucun combat : texte Tanzil, '
            'traduction Hamidullah, sens des mots, récitation.',
        plannedPhase: 'jalon J1 (Al-Fātiḥa)',
      ),
      _ => const SettingsScreen(),
    };
  }

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
        selectedIndex: _index,
        onDestinationSelected: select,
        destinations: [
          for (final s in _spaces)
            NavigationDestination(
              icon: Icon(s.icon),
              selectedIcon: Icon(s.selectedIcon),
              label: s.label,
            ),
        ],
      ),
    );
  }
}
