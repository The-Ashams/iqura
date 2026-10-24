import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../game/world.dart';
import '../widgets/arabic_text.dart';
import 'pixel.dart';
import 'report_error.dart';

/// Grimoire minimal (jalon J1a) : l'alphabet déjà rédigé.
class GrimoireScreen extends ConsumerWidget {
  const GrimoireScreen({super.key});

  static const String laterNotice =
      'Dictionnaire personnel, mots, règles et indicateurs : avec les '
      "révisions, à l'étape 6 du jalon J1a.";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final letters = ref.watch(contentDatabaseProvider).letters();
    return Scaffold(
      backgroundColor: GameColors.night,
      body: SafeArea(
        child: GameBody(
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              PixelWindow(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Grimoire', style: TextStyle(fontSize: 24)),
                    Text(
                      'Alphabet',
                      style: TextStyle(color: GameColors.accent, fontSize: 16),
                    ),
                    SizedBox(height: 6),
                    Text(
                      laterNotice,
                      style: TextStyle(color: GameColors.muted, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final l in letters)
                    Semantics(
                      button: true,
                      label: 'Lettre ${l.name}',
                      excludeSemantics: true,
                      child: InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (_) => LetterSheet(letter: l),
                          ),
                        ),
                        child: SizedBox(
                          width: 96,
                          child: PixelWindow(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                ArabicText(
                                  l.letter,
                                  baseSize: 40,
                                  style: TextStyle(color: GameColors.text),
                                ),
                                Text(l.name, textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Fiche d'une lettre : formes, nom (audio de synthèse), articulation.
class LetterSheet extends StatelessWidget {
  const LetterSheet({super.key, required this.letter});

  final LetterCard letter;

  static const String _zwj = '‍';

  /// Formes de la lettre selon sa place dans le mot (isolée, début, milieu,
  /// fin) ; deux seulement si elle ne se lie pas à la suivante.
  static List<(String, String)> formsOf(LetterCard letter) {
    final l = letter.letter;
    return letter.joinsLeft
        ? [
            ('isolée', l),
            ('début', '$l$_zwj'),
            ('milieu', '$_zwj$l$_zwj'),
            ('fin', '$_zwj$l'),
          ]
        : [('isolée', l), ('fin', '$_zwj$l')];
  }

  @override
  Widget build(BuildContext context) {
    final l = letter.letter;
    final forms = formsOf(letter);
    return Scaffold(
      backgroundColor: GameColors.night,
      appBar: AppBar(
        title: Text('Lettre ${letter.name}'),
        backgroundColor: GameColors.night,
        foregroundColor: GameColors.text,
      ),
      body: SafeArea(
        child: GameBody(
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              PixelWindow(
                child: Column(
                  children: [
                    ArabicText(
                      l,
                      baseSize: 72,
                      style: TextStyle(color: GameColors.text),
                    ),
                    SpokenArabic(letter.nameAr, size: 30),
                    Text(letter.name, style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 18,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        for (final (name, glyph) in forms)
                          Column(
                            children: [
                              ArabicText(
                                glyph,
                                baseSize: 40,
                                style: TextStyle(color: GameColors.text),
                              ),
                              Text(
                                name,
                                style: TextStyle(
                                  color: GameColors.muted,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    if (!letter.joinsLeft)
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text('Ne se lie pas à la lettre suivante.'),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              PixelWindow(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            letter.zone,
                            style: TextStyle(color: GameColors.accent),
                          ),
                        ),
                        const AiTag(),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      letter.pronunciation,
                      style: const TextStyle(height: 1.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: ReportErrorButton(
                  subject:
                      'Fiche de la lettre ${letter.letter} (${letter.name})',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
