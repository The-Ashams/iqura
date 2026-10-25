/// Écrans des leçons de la région 2 (format 3) : dialogue, les mots, texte
/// gradué à lire (mots touchables), et la fiche de mot partagée avec le
/// dictionnaire.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../../game/lesson/lesson.dart';
import '../../../game/vocab/word.dart';
import '../../widgets/arabic_text.dart';
import '../pixel.dart';
import 'question_view.dart';

/// Dialogue : répliques en arabe (touche pour entendre), traduction à la
/// demande, puis la question « qu'as-tu compris ? ».
class DialogueView extends ConsumerStatefulWidget {
  const DialogueView({super.key, required this.step, required this.onNext});

  final DialogueStep step;
  final VoidCallback onNext;

  @override
  ConsumerState<DialogueView> createState() => _DialogueViewState();
}

class _DialogueViewState extends ConsumerState<DialogueView> {
  bool _french = false;

  @override
  Widget build(BuildContext context) {
    final names = {
      for (final c in ref.watch(contentDatabaseProvider).allCharacters())
        c.id: c.name,
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PixelWindow(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final l in widget.step.lines) ...[
                Text(
                  l.speaker == 'voyageur' ? 'Toi' : names[l.speaker] ?? '',
                  style: TextStyle(color: GameColors.accent, fontSize: 15),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: SpokenArabic(l.arabic, size: 32),
                ),
                if (_french)
                  Text(
                    l.french,
                    style: TextStyle(color: GameColors.muted, fontSize: 15),
                  ),
                const SizedBox(height: 8),
              ],
              Row(
                children: [
                  TextButton(
                    onPressed: () => setState(() => _french = !_french),
                    child: Text(
                      _french ? 'Cacher la traduction' : 'Voir la traduction',
                    ),
                  ),
                  const Spacer(),
                  ConstructedExampleTag(color: GameColors.muted),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        QuestionView(question: widget.step.question, onContinue: widget.onNext),
      ],
    );
  }
}

/// Les mots : une fiche par mot nouveau, puis la question.
class WordsView extends ConsumerWidget {
  const WordsView({super.key, required this.step, required this.onNext});

  final WordsStep step;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(contentDatabaseProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final id in step.words)
          if (db.word(id) case final w?)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: WordCard(word: w),
            ),
        QuestionView(question: step.question, onContinue: onNext),
      ],
    );
  }
}

/// Fiche de mot complète (avenant n° 2) : sens, nature, genre, pluriel,
/// passé et inaccompli, racine et famille, fréquence, exemple, sources.
class WordCard extends ConsumerWidget {
  const WordCard({super.key, required this.word, this.compact = false});

  final Word word;

  /// Sans famille ni exemple (aperçu au toucher d'un mot).
  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final w = word;
    final family = w.rootId == null || compact
        ? const <Word>[]
        : [
            for (final o in ref.watch(contentDatabaseProvider).words())
              if (o.rootId == w.rootId && o.id != w.id) o,
          ];
    final muted = TextStyle(color: GameColors.muted, fontSize: 14);
    return PixelWindow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(w.french, style: const TextStyle(fontSize: 20)),
                    Text('${w.natureLabel} · ${w.translit}', style: muted),
                    if (w.remark != null) Text(w.remark!, style: muted),
                  ],
                ),
              ),
              SpokenArabic(w.arabic, size: 40),
            ],
          ),
          if (w.plural != null)
            _Line(label: 'Pluriel (appris plus tard)', arabic: w.plural!),
          if (w.past != null) _Line(label: 'Passé', arabic: w.past!),
          if (w.present != null)
            _Line(label: 'Présent (appris plus tard)', arabic: w.present!),
          if (w.rootLetters != null) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                Text('Racine : ', style: muted),
                ArabicText(
                  w.rootLetters!.split('').join(' '),
                  baseSize: 24,
                  style: TextStyle(color: GameColors.accent),
                ),
                const Spacer(),
                if (w.occurrences != null)
                  Text('${w.occurrences} fois dans le Coran', style: muted),
              ],
            ),
            if (family.isNotEmpty)
              Wrap(
                spacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text('Même racine :', style: muted),
                  for (final o in family)
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: o.arabic,
                            style: const TextStyle(
                              fontFamily: ArabicFonts.text,
                              fontSize: 22,
                            ),
                          ),
                          TextSpan(text: ' (${o.french})', style: muted),
                        ],
                      ),
                    ),
                ],
              ),
            if (!compact)
              Text(
                'La racine aide à retenir ; elle ne suffit pas à deviner le '
                'sens d\'un mot.',
                style: muted.copyWith(fontSize: 12),
              ),
          ],
          if (!compact && w.exampleArabic != null) ...[
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerRight,
              child: SpokenArabic(w.exampleArabic!, size: 26),
            ),
            Text(w.exampleFrench ?? '', style: muted),
          ],
          const SizedBox(height: 4),
          Text(
            [
              if (w.lemmaId != null)
                'Racine et fréquence : Quranic Arabic Corpus'
              else if (w.rootId != null)
                'Racine : Quranic Arabic Corpus (mot absent du Corpus)',
              'Sens${w.exampleArabic != null ? ' et exemple' : ''} : '
                  '${w.meaningSource}',
              if (w.exampleArabic != null) 'exemple construit',
            ].join(' · '),
            style: muted.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.label, required this.arabic});

  final String label;
  final String arabic;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Text(
        '$label : ',
        style: TextStyle(color: GameColors.muted, fontSize: 14),
      ),
      const Spacer(),
      SpokenArabic(arabic, size: 26),
    ],
  );
}

/// Court texte gradué : chaque phrase s'entend en la touchant longuement ;
/// chaque mot se touche pour voir sa fiche (cahier §4 : « le mot inconnu
/// devient une carte »).
class GradedText extends ConsumerWidget {
  const GradedText({super.key, required this.sentences});

  final List<String> sentences;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(contentDatabaseProvider);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF6EFDF),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final s in sentences)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    tooltip: 'Écouter la phrase (synthèse)',
                    icon: const Icon(Icons.volume_up, size: 20),
                    color: const Color(0xFF4A3F33),
                    onPressed: db.audioFile(s) == null
                        ? null
                        : () => playLessonAudio(ref, s),
                  ),
                  Expanded(
                    child: Wrap(
                      textDirection: TextDirection.rtl,
                      spacing: 8,
                      runSpacing: 2,
                      children: [
                        for (final t in s.split(' '))
                          InkWell(
                            onTap: () {
                              final w = db.wordForToken(t);
                              if (w == null) return;
                              showModalBottomSheet<void>(
                                context: context,
                                backgroundColor: GameColors.night,
                                builder: (_) => Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: WordCard(word: w, compact: true),
                                ),
                              );
                            },
                            child: ArabicText(
                              t,
                              baseSize: 30,
                              style: const TextStyle(color: Color(0xFF2A1F18)),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          const Text(
            'Touche un mot pour voir son sens.',
            style: TextStyle(color: Color(0xFF6A5D4D), fontSize: 13),
          ),
        ],
      ),
    );
  }
}
