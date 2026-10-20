import 'package:flutter/material.dart';

/// Espace prévu mais pas encore construit. Dit clairement ce qui viendra et
/// quand, sans faux boutons.
class PlannedSpaceScreen extends StatelessWidget {
  const PlannedSpaceScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
    required this.plannedPhase,
    this.header,
  });

  final String title;
  final IconData icon;
  final String description;
  final String plannedPhase;
  final Widget? header;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (header != null) ...[header!, const SizedBox(height: 24)],
                Icon(icon, size: 64, color: theme.colorScheme.primary),
                const SizedBox(height: 16),
                Text(
                  'Pas encore disponible',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 12),
                Chip(label: Text('Prévu : $plannedPhase')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
