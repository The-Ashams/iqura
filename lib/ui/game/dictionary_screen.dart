/// Dictionnaire intégré (avenant n° 2, cahier §5.4 bis) : hors ligne,
/// accessible à tout moment (Grimoire, et pendant une leçon) ; recherche en
/// arabe avec ou sans voyelles, en français, par racine ; « déjà appris »
/// ou non ; ajout aux révisions en un geste.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../features/progress/lesson_progress.dart';
import '../../features/review/review.dart';
import '../../game/lesson/lesson.dart';
import '../../game/vocab/word.dart';
import 'lesson/fondations_views.dart';
import 'pixel.dart';
import 'report_error.dart';

class DictionaryScreen extends ConsumerStatefulWidget {
  const DictionaryScreen({super.key, this.initialQuery = ''});

  final String initialQuery;

  static const String sourceNotice =
      'Racines et fréquences : Quranic Arabic Corpus. Sens, exemples, '
      'pluriels et conjugaisons : rédigés par IA.';

  @override
  ConsumerState<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends ConsumerState<DictionaryScreen> {
  late final _controller = TextEditingController(text: widget.initialQuery);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final words = ref.watch(contentDatabaseProvider).words();
    final query = _controller.text;
    final results = query.trim().isEmpty ? words : searchWords(words, query);
    final progress = ref.watch(lessonProgressProvider);
    final reviews = ref.watch(reviewRepositoryProvider);
    return Scaffold(
      backgroundColor: GameColors.night,
      appBar: AppBar(
        title: const Text('Dictionnaire'),
        backgroundColor: GameColors.night,
        foregroundColor: GameColors.text,
      ),
      body: SafeArea(
        child: GameBody(
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              TextField(
                controller: _controller,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(
                  labelText: 'Chercher un mot',
                  helperText:
                      'En arabe (avec ou sans voyelles), en français, ou '
                      'par racine (ex. كتب).',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                DictionaryScreen.sourceNotice,
                style: TextStyle(color: GameColors.muted, fontSize: 13),
              ),
              const SizedBox(height: 8),
              if (results.isEmpty)
                PixelWindow(
                  child: Text(
                    words.isEmpty
                        ? 'Le dictionnaire se remplit avec les leçons de la '
                              'région 2.'
                        : 'Aucun mot trouvé.',
                  ),
                ),
              for (final w in results) ...[
                WordCard(word: w),
                _Status(
                  word: w,
                  learned: progress[w.lessonId]?.completed ?? false,
                  inReviews: reviews.get('sens:${w.id}') != null,
                  onAdd: () {
                    reviews.createCards(w.lessonId, [
                      (id: 'sens:${w.id}', kind: CardKind.sens, target: w.id),
                    ]);
                    ref.read(dueCountProvider.notifier).refresh();
                    setState(() {});
                  },
                ),
                const SizedBox(height: 12),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Status extends StatelessWidget {
  const _Status({
    required this.word,
    required this.learned,
    required this.inReviews,
    required this.onAdd,
  });

  final Word word;
  final bool learned;
  final bool inReviews;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          learned
              ? 'Déjà appris (leçon '
                    '${lessonNumber(word.lessonStage, word.lessonOrdinal)})'
              : 'Pas encore appris (leçon '
                    '${lessonNumber(word.lessonStage, word.lessonOrdinal)})',
          style: TextStyle(
            color: learned ? GameColors.accent : GameColors.muted,
            fontSize: 14,
          ),
        ),
      ),
      TextButton(
        onPressed: inReviews ? null : onAdd,
        child: Text(inReviews ? 'Dans tes révisions' : 'Ajouter aux révisions'),
      ),
      ReportErrorButton(subject: 'Dictionnaire : ${word.arabic} (${word.id})'),
    ],
  );
}
