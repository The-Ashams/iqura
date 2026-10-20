import 'package:flutter/material.dart';

/// Mention obligatoire sur tout texte rédigé par IA (aucun relecteur humain).
class AiContentBadge extends StatelessWidget {
  const AiContentBadge({super.key});

  static const String label = 'Rédigé par IA — non vérifié';

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: scheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall
            ?.copyWith(color: scheme.onTertiaryContainer),
      ),
    );
  }
}
