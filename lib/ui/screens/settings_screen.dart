import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/app_info.dart';
import '../../core/providers.dart';
import '../../features/profile/profile.dart';
import '../../engines/transliteration/transliterator.dart';
import '../../features/settings/settings.dart';
import '../widgets/ai_content_badge.dart';
import '../widgets/arabic_text.dart';
import 'backups_screen.dart';
import 'pseudo_dialog.dart';
import 'sources_screen.dart';
import 'transfer_actions.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);
    final profile = ref.watch(profileProvider);
    final theme = Theme.of(context);

    Widget section(String title) => Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          section('Profil'),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(profile?.pseudo ?? '—'),
            subtitle: const Text('Pseudo'),
            trailing: const Icon(Icons.edit),
            onTap: () async {
              final pseudo = await showPseudoDialog(
                context,
                initial: profile?.pseudo ?? '',
              );
              if (pseudo != null) {
                ref.read(profileProvider.notifier).save(pseudo);
              }
            },
          ),

          section('Affichage'),
          ListTile(
            title: const Text('Thème'),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SegmentedButton<ThemeMode>(
                segments: const [
                  ButtonSegment(
                    value: ThemeMode.system,
                    label: Text('Système'),
                  ),
                  ButtonSegment(value: ThemeMode.light, label: Text('Clair')),
                  ButtonSegment(value: ThemeMode.dark, label: Text('Sombre')),
                ],
                selected: {settings.themeMode},
                onSelectionChanged: (s) => notifier.setThemeMode(s.first),
              ),
            ),
          ),
          ListTile(
            title: const Text('Translittération'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                SegmentedButton<TransliterationStyle>(
                  segments: [
                    for (final s in TransliterationStyle.values)
                      ButtonSegment(value: s, label: Text(s.label)),
                  ],
                  selected: {settings.transliteration},
                  onSelectionChanged: (s) =>
                      notifier.setTransliteration(s.first),
                ),
                const SizedBox(height: 8),
                const _TransliterationExample(),
              ],
            ),
          ),
          SwitchListTile(
            title: const Text('Afficher la translittération'),
            subtitle: const Text('Lettres latines sous le texte arabe.'),
            value: settings.showTransliteration,
            onChanged: notifier.setShowTransliteration,
          ),
          SwitchListTile(
            title: const Text('Animations'),
            subtitle: const Text(
              'Désactivées : pas de transitions entre les écrans.',
            ),
            value: settings.animations,
            onChanged: notifier.setAnimations,
          ),
          ListTile(
            title: const Text('Taille du texte arabe'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Slider(
                  value: settings.arabicFontScale,
                  min: AppSettings.minArabicScale,
                  max: AppSettings.maxArabicScale,
                  divisions: 12,
                  label: '${(settings.arabicFontScale * 100).round()} %',
                  onChanged: (v) =>
                      notifier.setArabicFontScale(v, persist: false),
                  onChangeEnd: notifier.setArabicFontScale,
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: ArabicText('صَبَاحُ الْخَيْرِ'),
                ),
              ],
            ),
          ),

          section('Sauvegarde et transfert'),
          ListTile(
            leading: const Icon(Icons.upload_file),
            title: const Text('Exporter ma progression'),
            subtitle: const Text(
              'Crée un fichier .zip à copier sur un autre appareil.',
            ),
            onTap: () => exportProgress(context, ref),
          ),
          ListTile(
            leading: const Icon(Icons.download),
            title: const Text('Importer une progression'),
            subtitle: const Text('Fusion ou restauration complète.'),
            onTap: () => importProgress(context, ref),
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Sauvegardes locales'),
            subtitle: const Text(
              'Copies automatiques quotidiennes et avant chaque import.',
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (_) => const BackupsScreen()),
            ),
          ),

          section('Sources et licences'),
          const _AboutTile(),
        ],
      ),
    );
  }
}

/// Exemple construit (« bonjour »), translittéré par le moteur.
const _exampleArabic = 'صَبَاحُ الْخَيْرِ';

class _TransliterationExample extends ConsumerWidget {
  const _TransliterationExample();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final example = settings.showTransliteration
        ? const Transliterator().transliterate(
            _exampleArabic,
            style: settings.transliteration.engineStyle,
          )
        : '(translittération masquée)';
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text('Exemple : $example (« bonjour »)'),
        const AiContentBadge(),
      ],
    );
  }
}

class _AboutTile extends ConsumerWidget {
  const _AboutTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final content = ref.watch(contentDatabaseProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: Text('$appName $appVersion'),
          subtitle: SelectableText(
            'Logiciel libre et gratuit, licence $appLicense.\n'
            'Code source : $sourceRepositoryUrl\n'
            'Version du contenu : ${content.contentVersion}',
          ),
        ),
        ListTile(
          leading: const Icon(Icons.source_outlined),
          title: const Text('Sources des données'),
          subtitle: const Text(
            'Tanzil (texte coranique, traduction), Quranic Arabic Corpus '
            '(morphologie).',
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute<void>(builder: (_) => const SourcesScreen()),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.gavel_outlined),
          title: const Text('Licences des bibliothèques'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => showLicensePage(
            context: context,
            applicationName: appName,
            applicationVersion: appVersion,
            applicationLegalese: 'Licence $appLicense',
          ),
        ),
      ],
    );
  }
}
