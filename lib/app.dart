import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/app_info.dart';
import 'features/profile/profile.dart';
import 'features/settings/settings.dart';
import 'ui/screens/onboarding_screen.dart';
import 'ui/shell/app_shell.dart';
import 'ui/theme.dart';

const _localizations = <LocalizationsDelegate<Object>>[
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

class IquraApp extends ConsumerWidget {
  const IquraApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(settingsProvider.select((s) => s.themeMode));
    final animations = ref.watch(settingsProvider.select((s) => s.animations));
    final hasProfile = ref.watch(profileProvider) != null;
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: buildTheme(Brightness.light, animations: animations),
      darkTheme: buildTheme(Brightness.dark, animations: animations),
      themeMode: themeMode,
      // Animations désactivées : le signal est transmis à tous les widgets
      // (MediaQuery.disableAnimations) et les transitions de page supprimées.
      builder: (context, child) => animations
          ? child!
          : MediaQuery(
              data: MediaQuery.of(context).copyWith(disableAnimations: true),
              child: child!,
            ),
      locale: const Locale('fr'),
      supportedLocales: const [Locale('fr')],
      localizationsDelegates: _localizations,
      home: hasProfile ? const AppShell() : const OnboardingScreen(),
    );
  }
}

/// Affiché si l'application ne peut pas démarrer (base illisible…).
class StartupErrorApp extends StatelessWidget {
  const StartupErrorApp({super.key, required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: buildTheme(Brightness.light),
      locale: const Locale('fr'),
      supportedLocales: const [Locale('fr')],
      localizationsDelegates: _localizations,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'IQURA ne peut pas démarrer',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Vos données n’ont pas été modifiées. Détail de l’erreur :',
                ),
                const SizedBox(height: 8),
                SelectableText('$error'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
