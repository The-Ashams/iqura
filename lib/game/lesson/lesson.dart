/// Une leçon au format mini-donjon (format 2, cahier v3 §6), lue dans la
/// base de contenu. Le contenu est rédigé dans
/// `tools/build_content/lessons/` et contrôlé par `mini_donjon.py`.
library;

/// Marque « gauche à droite » (U+200E), invisible.
const String _lrm = '\u200E';

// Suite de mots arabes (lettres, voyelles, ponctuation arabe), espaces
// intérieurs compris.
final RegExp _arabicRun = RegExp(
  r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]+'
  r'(?:\s+[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]+)*',
);

/// Texte français qui cite de l'arabe : une marque invisible suit chaque
/// passage arabe, pour que deux passages séparés par « : » ou « , » restent
/// dans l'ordre de la phrase française (« بَ : بَاب » et non « بَاب : بَ »).
String frenchWithArabic(String text) => text
    .replaceAllMapped(_lonelyMark, (m) => '${m[1]}ـ${m[2]}')
    .replaceAllMapped(_arabicRun, (m) => '${m[0]}$_lrm');

// Signe arabe isolé (voyelle, tanwīn, signe du Mushaf) : posé sur un trait
// (tatwīl) pour être lisible.
final RegExp _lonelyMark = RegExp(
  r'(^|[\s(«])([\u064B-\u065F\u0670\u06D6-\u06ED])',
);

/// Vrai pour un signe (voyelle, shadda, tanwīn, signe du Mushaf), faux pour
/// une lettre.
bool isArabicMark(String c) =>
    c.runes.length == 1 &&
    RegExp(r'^[\u064B-\u065F\u0670\u06D6-\u06ED]$').hasMatch(c);

/// Un signe seul s'affiche posé sur un trait (tatwīl) ; une lettre telle
/// quelle.
String showMark(String c) => isArabicMark(c) ? 'ـ$c' : c;

String? _fr(Object? v) => v == null ? null : frenchWithArabic(v as String);

/// Sorte de question (cahier v3 §6.4).
enum QuestionKind {
  qcm,
  points,
  formes,
  reconnaitre,
  ecouter,
  paires,
  ecouterLettre,
  lire,
  reconstruire,
  tracer,
  repeter,
  repererMot,
  compter;

  static QuestionKind parse(String s) => switch (s) {
    'qcm' => qcm,
    'points' => points,
    'formes' => formes,
    'reconnaitre' => reconnaitre,
    'ecouter' => ecouter,
    'paires' => paires,
    'ecouter_lettre' => ecouterLettre,
    'lire' => lire,
    'reconstruire' => reconstruire,
    'tracer' => tracer,
    'repeter' => repeter,
    'reperer_mot' => repererMot,
    'compter' => compter,
    _ => throw FormatException('type de question inconnu : $s'),
  };

  /// Exercice sans bonne ou mauvaise réponse (tracer, répéter à voix
  /// haute) : jamais noté (cahier v3 §3.5, pas de note automatique).
  bool get ungraded => this == tracer || this == repeter;
}

/// Ce que représentent les choix d'une question.
enum ChoiceKind { text, arabic, audio, none }

class LessonQuestion {
  const LessonQuestion({
    required this.kind,
    required this.prompt,
    this.choices = const [],
    this.choiceKind = ChoiceKind.none,
    this.answer,
    this.explanation,
    this.arabic,
    this.audio,
    this.tiles = const [],
    this.solution = const [],
    this.letter,
    this.word,
    this.revision = false,
  });

  factory LessonQuestion.fromJson(Map<String, dynamic> j) {
    final (choices, choiceKind) = j['choix'] != null
        ? (j['choix'] as List, ChoiceKind.text)
        : j['choix_ar'] != null
        ? (j['choix_ar'] as List, ChoiceKind.arabic)
        : j['choix_audio'] != null
        ? (j['choix_audio'] as List, ChoiceKind.audio)
        : (const [], ChoiceKind.none);
    return LessonQuestion(
      kind: QuestionKind.parse(j['type'] as String),
      prompt: frenchWithArabic(j['consigne'] as String),
      // Réponses en français : l'arabe cité garde l'ordre de la phrase.
      choices: [
        for (final c in choices.cast<String>())
          choiceKind == ChoiceKind.text ? frenchWithArabic(c) : c,
      ],
      choiceKind: choiceKind,
      answer: j['reponse'] as int?,
      explanation: _fr(j['explication']),
      arabic: j['ar'] as String?,
      audio: j['audio'] as String?,
      tiles: ((j['tuiles'] as List?) ?? const []).cast<String>(),
      solution: ((j['solution'] as List?) ?? const []).cast<String>(),
      letter: j['lettre'] as String?,
      word: j['mot'] as int?,
      revision: j['revision'] == true,
    );
  }

  final QuestionKind kind;

  /// Consigne (« Quelle syllabe entends-tu ? »).
  final String prompt;
  final List<String> choices;
  final ChoiceKind choiceKind;

  /// Indice de la bonne réponse parmi [choices].
  final int? answer;

  /// Explication montrée après la réponse (au mini-boss : à la revue).
  final String? explanation;

  /// Texte arabe affiché (lettre, mot à lire, texte à répéter).
  final String? arabic;

  /// Texte arabe joué (écouter, paires, reconstruire).
  final String? audio;
  final List<String> tiles;
  final List<String> solution;

  /// Lettre à tracer, ou à compter dans un mot de la salle de lecture.
  final String? letter;

  /// Mot visé dans l'inscription (indice), salle de lecture seulement.
  final int? word;

  /// Question de révision (leçons précédentes), au mini-boss.
  final bool revision;
}

/// Un écran de la leçon.
sealed class LessonStep {
  const LessonStep();

  static LessonStep fromJson(Map<String, dynamic> j) {
    LessonQuestion? q(Object? v) =>
        v == null ? null : LessonQuestion.fromJson(v as Map<String, dynamic>);
    List<String> strings(Object? v) => ((v as List?) ?? const []).cast();
    final type = j['type'] as String;
    return switch (type) {
      'entree' => EntryStep(
        lines: [
          for (final r in (j['repliques'] as List).cast<Map>())
            (
              speaker: r['qui'] as String,
              text: frenchWithArabic(r['texte'] as String),
            ),
        ],
        objective: frenchWithArabic(j['objectif'] as String),
      ),
      'decouverte' || 'element' || 'regle' => ExplainStep(
        kind: switch (type) {
          'decouverte' => ExplainKind.discovery,
          'element' => ExplainKind.element,
          _ => ExplainKind.rule,
        },
        title: _fr(j['titre']),
        text: _fr(j['texte']),
        arabic: [...strings(j['support']), ...strings(j['exemples'])],
        letter: j['lettre'] as String?,
        question: q(j['question'])!,
      ),
      'echauffement' || 'entrainement' => PracticeStep(
        warmUp: type == 'echauffement',
        exercises: [
          for (final e in ((j['exercices'] ?? j['questions']) as List))
            LessonQuestion.fromJson(e as Map<String, dynamic>),
        ],
      ),
      'lecture' => ReadingStep(
        title: _fr(j['titre']),
        text: frenchWithArabic(j['texte'] as String),
        inscription: strings(j['inscription']),
        questions: [
          for (final e in j['questions'] as List)
            LessonQuestion.fromJson(e as Map<String, dynamic>),
        ],
      ),
      'mini_boss' => BossStep(
        threshold: (j['seuil'] as num).toDouble(),
        questions: [
          for (final e in j['questions'] as List)
            LessonQuestion.fromJson(e as Map<String, dynamic>),
        ],
      ),
      'fin' => EndStep(
        learned: frenchWithArabic(j['acquis'] as String),
        next: _fr(j['suite']),
      ),
      _ => throw FormatException('écran inconnu : $type'),
    };
  }
}

class EntryStep extends LessonStep {
  const EntryStep({required this.lines, required this.objective});

  final List<({String speaker, String text})> lines;
  final String objective;
}

enum ExplainKind { discovery, element, rule }

/// Découverte, élément (fiche d'une lettre) ou règle : toujours suivi de sa
/// question (jamais deux écrans d'explication de suite, cahier v3 §6.2).
class ExplainStep extends LessonStep {
  const ExplainStep({
    required this.kind,
    required this.question,
    this.title,
    this.text,
    this.arabic = const [],
    this.letter,
  });

  final ExplainKind kind;
  final String? title;
  final String? text;

  /// Support de la découverte ou exemples de la règle.
  final List<String> arabic;

  /// Lettre présentée (écran « élément »).
  final String? letter;
  final LessonQuestion question;
}

class PracticeStep extends LessonStep {
  const PracticeStep({required this.exercises, this.warmUp = false});

  final List<LessonQuestion> exercises;
  final bool warmUp;
}

/// Salle de lecture (avenant n° 1) : une inscription d'exemples construits,
/// faite de mots déjà lus, et ses questions. Lieu calme, sans combat ;
/// aucun verset ni extrait coranique.
class ReadingStep extends LessonStep {
  const ReadingStep({
    required this.text,
    required this.inscription,
    required this.questions,
    this.title,
  });

  final String? title;
  final String text;

  /// Mots de l'inscription, dans l'ordre de lecture (de droite à gauche).
  final List<String> inscription;
  final List<LessonQuestion> questions;
}

class BossStep extends LessonStep {
  const BossStep({required this.threshold, required this.questions});

  final double threshold;
  final List<LessonQuestion> questions;
}

class EndStep extends LessonStep {
  const EndStep({required this.learned, this.next});

  final String learned;
  final String? next;
}

class Lesson {
  const Lesson({
    required this.id,
    required this.stage,
    required this.ordinal,
    required this.title,
    required this.objective,
    required this.place,
    required this.master,
    required this.steps,
    this.letters = const [],
    this.signs = const [],
    this.readings = const [],
    this.noCombat = false,
  });

  /// Leçon au format 2 ; `null` pour une leçon d'un ancien format.
  static Lesson? fromJson(Map<String, dynamic> j) {
    if (j['format'] != 2) return null;
    return Lesson(
      id: j['id'] as String,
      stage: j['etape'] as int,
      ordinal: j['ordre'] as int,
      title: j['titre'] as String,
      objective: frenchWithArabic(j['objectif'] as String),
      place: j['lieu'] as String,
      master: j['maitre'] as String,
      steps: [
        for (final s in j['ecrans'] as List)
          LessonStep.fromJson(s as Map<String, dynamic>),
      ],
      letters: ((j['introduit'] as Map)['lettres'] as List).cast<String>(),
      signs: ((j['introduit'] as Map)['signes'] as List).cast<String>(),
      noCombat: j['sans_combat'] == true,
      readings: [
        for (final kind in ['syllabes', 'mots'])
          for (final e in ((j['elements'] as Map)[kind] as List).cast<Map>())
            e['ar'] as String,
      ],
    );
  }

  final String id;
  final int stage;
  final int ordinal;
  final String title;
  final String objective;

  /// Lieu de la carte et maître qui y enseigne.
  final String place;
  final String master;
  final List<LessonStep> steps;

  /// Lettres et signes introduits (noms : `fatha`, `kasra`…).
  final List<String> letters;
  final List<String> signs;

  /// Syllabes puis mots à lire.
  final List<String> readings;

  /// Lieu calme, sans combat (leçon 14, salle des manuscrits) : le
  /// mini-boss devient une série finale de questions.
  final bool noCombat;
}

/// Résumé d'une leçon, pour la liste d'un lieu.
class LessonSummary {
  const LessonSummary({
    required this.id,
    required this.stage,
    required this.ordinal,
    required this.title,
    required this.playable,
  });

  final String id;
  final int stage;
  final int ordinal;
  final String title;

  /// Au format mini-donjon (les autres arrivent à l'étape 5).
  final bool playable;
}

/// Lettres arabes précomposées et leur forme décomposée (Unicode).
const _decomposed = {
  'آ': 'ا\u0653',
  'أ': 'ا\u0654',
  'إ': 'ا\u0655',
  'ؤ': 'و\u0654',
  'ئ': 'ي\u0654',
};

/// Nombre de fois où [letter] apparaît dans [word] (réponse d'une question
/// « compter », calculée, jamais recopiée). Un signe seul se compte aussi
/// dans les lettres qui le portent : آ contient ٓ.
int countLetter(String word, String letter) {
  var text = word;
  if (letter.length == 1 && isArabicMark(letter)) {
    text = text.split('').map((c) => _decomposed[c] ?? c).join();
  }
  return letter.allMatches(text).length;
}

/// Score minimal au mini-boss : [threshold] des questions notées, arrondi au
/// supérieur (80 % de 12 = 9,6 → 10).
int bossPassMark(int questions, double threshold) =>
    (questions * threshold - 1e-9).ceil();
