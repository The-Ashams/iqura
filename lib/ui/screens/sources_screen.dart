import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';

/// Sources des données intégrées, lues dans la base de contenu.
class SourcesScreen extends ConsumerWidget {
  const SourcesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final content = ref.watch(contentDatabaseProvider);
    final sources = content.sources();
    final notices = content.sourceNotices();
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Sources des données')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Le texte coranique est copié tel quel depuis Tanzil et vérifié '
            'par empreinte SHA-256 à chaque démarrage. Les racines, lemmes et '
            'segments viennent du Quranic Arabic Corpus.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Version du contenu : ${content.contentVersion}',
            style: theme.textTheme.bodySmall,
          ),
          for (final s in sources)
            Card(
              margin: const EdgeInsets.only(top: 12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.title, style: theme.textTheme.titleSmall),
                    const SizedBox(height: 4),
                    Text(s.attribution),
                    Text('Licence : ${s.license}'),
                    SelectableText(s.link),
                    if (s.notes != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(s.notes!, style: theme.textTheme.bodySmall),
                      ),
                    if (notices[s.id] != null)
                      ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        title: const Text('Notice de copyright d\'origine'),
                        children: [
                          SelectableText(
                            notices[s.id]!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
