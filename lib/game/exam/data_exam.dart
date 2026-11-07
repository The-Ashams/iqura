/// Examen de fin de région écrit en données (à partir de la région 2, cahier
/// v3 §5.11) : un récit à comprendre, une épreuve d'écoute, des réponses à
/// un personnage. Le contenu vient de `tools/build_content/exams/`.
library;

import '../lesson/lesson.dart';

/// Une réponse libre : l'apprenant répond, puis compare avec les modèles et
/// s'évalue lui-même. Jamais notée par l'application.
class FreeReply {
  const FreeReply({
    required this.prompt,
    required this.speaker,
    required this.arabic,
    required this.models,
    this.explanation,
  });

  final String prompt;
  final String speaker;
  final String arabic;
  final List<String> models;
  final String? explanation;
}

/// Une partie de l'épreuve « répondre » : phrase à remettre en ordre (notée)
/// ou réponse libre (auto-évaluée).
class ExamReply {
  const ExamReply.graded(LessonQuestion this.question) : free = null;
  const ExamReply.free(FreeReply this.free) : question = null;

  final LessonQuestion? question;
  final FreeReply? free;
}

class DataExam {
  const DataExam({
    required this.id,
    required this.region,
    required this.place,
    required this.title,
    required this.intro,
    required this.storyTitle,
    required this.story,
    required this.reading,
    required this.readingPass,
    required this.listening,
    required this.listeningPass,
    required this.replies,
    required this.repliesPass,
  });

  factory DataExam.fromJson(Map<String, dynamic> j) {
    List<LessonQuestion> questions(Map<String, dynamic> part) => [
      for (final q in (part['questions'] as List).cast<Map<String, dynamic>>())
        LessonQuestion.fromJson(q),
    ];
    final lecture = j['lecture'] as Map<String, dynamic>;
    final ecoute = j['ecoute'] as Map<String, dynamic>;
    final reponses = j['reponses'] as Map<String, dynamic>;
    return DataExam(
      id: j['id'] as String,
      region: j['region'] as int,
      place: j['lieu'] as String,
      title: j['titre'] as String,
      intro: frenchWithArabic(j['intro'] as String),
      storyTitle: lecture['titre'] as String?,
      story: (lecture['phrases'] as List).cast<String>(),
      reading: questions(lecture),
      readingPass: (lecture['seuil'] as num).toDouble(),
      listening: questions(ecoute),
      listeningPass: (ecoute['seuil'] as num).toDouble(),
      replies: [
        for (final q
            in (reponses['questions'] as List).cast<Map<String, dynamic>>())
          q['type'] == 'libre'
              ? ExamReply.free(
                  FreeReply(
                    prompt: frenchWithArabic(q['consigne'] as String),
                    speaker: (q['replique'] as Map)['qui'] as String,
                    arabic: (q['replique'] as Map)['ar'] as String,
                    models: (q['modeles'] as List).cast<String>(),
                    explanation: q['explication'] == null
                        ? null
                        : frenchWithArabic(q['explication'] as String),
                  ),
                )
              : ExamReply.graded(LessonQuestion.fromJson(q)),
      ],
      repliesPass: (reponses['seuil'] as num).toDouble(),
    );
  }

  final String id;
  final int region;
  final String place;
  final String title;
  final String intro;
  final String? storyTitle;
  final List<String> story;
  final List<LessonQuestion> reading;
  final double readingPass;
  final List<LessonQuestion> listening;
  final double listeningPass;
  final List<ExamReply> replies;
  final double repliesPass;

  /// Phrases à remettre en ordre : la seule partie notée de « répondre ».
  int get gradedReplies => replies.where((r) => r.question != null).length;

  static int mark(int count, double pass) => (count * pass - 1e-9).ceil();
  int get readingMark => mark(reading.length, readingPass);
  int get listeningMark => mark(listening.length, listeningPass);
  int get repliesMark => mark(gradedReplies, repliesPass);

  bool passed({
    required int reading,
    required int listening,
    required int replies,
  }) =>
      reading >= readingMark &&
      listening >= listeningMark &&
      replies >= repliesMark;
}
