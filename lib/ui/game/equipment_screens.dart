/// Boutique, équipement et enchantement (cahier v3 §8.6), dans la Cité.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../engines/audio/audio_service.dart';
import '../../features/inventory/inventory.dart';
import '../../features/resources/resources.dart';
import '../../game/equipment/equipment.dart';
import 'pixel.dart';
import 'status_bar.dart';

String _stats(Stats s) => [
  for (final (name, v) in s.entries)
    if (v > 0)
      '$name +$v${name == 'Critique'
          ? ' %'
          : name == 'Concentration'
          ? ' s'
          : ''}',
].join(', ');

Scaffold _page(String title, List<Widget> children) => Scaffold(
  backgroundColor: GameColors.night,
  appBar: AppBar(
    title: Text(title),
    backgroundColor: GameColors.night,
    foregroundColor: GameColors.text,
  ),
  body: SafeArea(
    child: GameBody(
      child: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const HeroStatusBar(),
          const SizedBox(height: 12),
          ...children,
          const SizedBox(height: 8),
          Text(
            'L\'équipement change les combats de l\'Expédition, jamais '
            'l\'apprentissage : ni les questions, ni les révisions, ni les '
            'mini-boss des leçons.',
            style: TextStyle(color: GameColors.muted, fontSize: 13),
          ),
        ],
      ),
    ),
  ),
);

class ShopScreen extends ConsumerWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(contentDatabaseProvider).items();
    final dinars = ref.watch(walletProvider)[Currency.dinars];
    final owned = {for (final o in ref.watch(inventoryProvider)) o.item.id};
    return _page('Boutique du marché', [
      for (final it in items)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: PixelWindow(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(it.name, style: const TextStyle(fontSize: 18)),
                Text(
                  '${it.slotLabel} · ${it.rarityLabel}'
                  '${it.set != null ? ' · ensemble « ${it.set!.name} »' : ''}',
                  style: TextStyle(color: GameColors.muted, fontSize: 14),
                ),
                Text(_stats(it.stats)),
                Text(
                  it.description,
                  style: TextStyle(color: GameColors.muted, fontSize: 14),
                ),
                PixelCommand(
                  label: 'Acheter (${it.price} dinars)',
                  detail: owned.contains(it.id)
                      ? 'Déjà possédé'
                      : dinars < it.price
                      ? 'Pas assez de dinars'
                      : null,
                  onPressed: owned.contains(it.id) || dinars < it.price
                      ? null
                      : () {
                          ref.read(inventoryRepositoryProvider).buy(it);
                          ref.read(walletProvider.notifier).refresh();
                          ref.read(inventoryProvider.notifier).refresh();
                        },
                ),
              ],
            ),
          ),
        ),
    ]);
  }
}

class EquipmentScreen extends ConsumerStatefulWidget {
  const EquipmentScreen({super.key});

  @override
  ConsumerState<EquipmentScreen> createState() => _EquipmentScreenState();
}

class _EquipmentScreenState extends ConsumerState<EquipmentScreen> {
  String? _message;

  void _refresh() {
    ref.read(walletProvider.notifier).refresh();
    ref.read(inventoryProvider.notifier).refresh();
  }

  void _enchant(OwnedItem o) {
    final out = ref.read(inventoryRepositoryProvider).enchant(o);
    playSfx(ref, out == EnchantOutcome.success ? Sfx.victoire : Sfx.faux);
    setState(() {
      _message = switch (out) {
        EnchantOutcome.success => '${o.item.name} passe à +${o.level + 1} !',
        EnchantOutcome.failure =>
          'L\'enchantement échoue : rien n\'est perdu, et la prochaine '
              'tentative aura plus de chances.',
        EnchantOutcome.notEnough => 'Il manque des dinars ou des pierres.',
        EnchantOutcome.maxed => 'Déjà au maximum (+${Enchant.maxLevel}).',
      };
    });
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    final owned = ref.watch(inventoryProvider);
    final w = ref.watch(walletProvider);
    final hero = heroStats(w.level, [
      for (final o in owned)
        if (o.equipped) o,
    ]);
    return _page('Équipement et enchantement', [
      PixelWindow(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Le voyageur',
              style: TextStyle(color: GameColors.accent, fontSize: 18),
            ),
            Text(_stats(hero)),
          ],
        ),
      ),
      const SizedBox(height: 8),
      if (_message != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(_message!, style: TextStyle(color: GameColors.accent)),
        ),
      if (owned.isEmpty)
        const PixelWindow(
          child: Text('Aucun objet : la boutique du marché en vend.'),
        ),
      for (final o in owned)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: PixelWindow(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${o.item.name}${o.level > 0 ? ' +${o.level}' : ''}'
                  '${o.glow != null ? ' · ${o.glow}' : ''}',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  '${o.item.slotLabel} · ${_stats(o.stats)}',
                  style: TextStyle(color: GameColors.muted, fontSize: 14),
                ),
                PixelCommand(
                  label: o.equipped ? 'Retirer' : 'Équiper',
                  onPressed: () {
                    final inv = ref.read(inventoryRepositoryProvider);
                    o.equipped ? inv.unequip(o) : inv.equip(o);
                    playSfx(ref, Sfx.choix);
                    _refresh();
                  },
                ),
                if (o.level < Enchant.maxLevel) _enchantCommand(o, w),
              ],
            ),
          ),
        ),
    ]);
  }

  Widget _enchantCommand(OwnedItem o, Wallet w) {
    final target = o.level + 1;
    final cost = Enchant.cost(target);
    final rate = Enchant.rate(target, o.fails);
    final enough =
        w[Currency.dinars] >= cost.dinars &&
        w[Currency.pierres] >= cost.pierres;
    return PixelCommand(
      label: 'Enchanter → +$target ($rate % de réussite)',
      detail:
          'Coût : ${cost.dinars} dinars et ${cost.pierres} pierre'
          '${cost.pierres > 1 ? 's' : ''} de savoir. Taux de base '
          '${Enchant.baseRate(target)} %, +5 points par échec, réussite '
          'garantie après ${Enchant.pity(target)} échecs '
          '(${o.fails} pour l\'instant). Un échec ne fait rien perdre.'
          '${enough ? '' : ' Ressources insuffisantes.'}',
      onPressed: enough ? () => _enchant(o) : null,
    );
  }
}
