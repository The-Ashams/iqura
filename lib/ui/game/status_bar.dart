import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/resources/resources.dart';
import '../../features/review/review.dart';
import 'pixel.dart';

/// Bandeau du voyageur : niveau, ressources, série et révisions dues.
class HeroStatusBar extends ConsumerWidget {
  const HeroStatusBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final w = ref.watch(walletProvider);
    final due = ref.watch(dueCountProvider);
    final streak = ref.watch(resourceRepositoryProvider).streak();
    final xp = w[Currency.xp];
    final from = xpForLevel(w.level);
    final to = xpForLevel(w.level + 1);
    Widget chip(IconData icon, String text, String label) => Semantics(
      label: label,
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: GameColors.accent),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
    return PixelWindow(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Niveau ${w.level}', style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 10),
              Expanded(
                child: Semantics(
                  label: '$xp XP, ${to - xp} avant le niveau ${w.level + 1}',
                  excludeSemantics: true,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2F2848),
                      border: Border.all(color: const Color(0xFF0D0B16)),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: ((xp - from) / (to - from)).clamp(0, 1),
                      child: ColoredBox(color: GameColors.accent),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '$xp XP',
                style: TextStyle(color: GameColors.muted, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 14,
            runSpacing: 6,
            children: [
              chip(
                Icons.paid_outlined,
                '${w[Currency.dinars]}',
                '${w[Currency.dinars]} dinars',
              ),
              chip(
                Icons.diamond_outlined,
                '${w[Currency.pierres]}',
                '${w[Currency.pierres]} pierres de savoir',
              ),
              chip(
                Icons.edit_outlined,
                '${w[Currency.encre]}',
                '${w[Currency.encre]} encre de scribe',
              ),
              chip(
                Icons.local_fire_department_outlined,
                '$streak j',
                'Série : $streak jour${streak > 1 ? 's' : ''}',
              ),
              chip(
                Icons.style_outlined,
                '$due',
                '$due révision${due > 1 ? 's' : ''} due${due > 1 ? 's' : ''}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
