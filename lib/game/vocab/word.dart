/// Fiche de mot (avenant n° 2, cahier §5.4 bis), lue dans la table `word`.
///
/// Racine et fréquence viennent du Quranic Arabic Corpus (lemme lié) ; sens,
/// pluriel, conjugaison et exemple sont rédigés par IA ([meaningSource]).
library;

class Word {
  const Word({
    required this.id,
    required this.arabic,
    required this.translit,
    required this.french,
    required this.nature,
    required this.lessonId,
    required this.lessonStage,
    required this.lessonOrdinal,
    required this.meaningSource,
    required this.keys,
    this.gender,
    this.plural,
    this.past,
    this.present,
    this.lemmaId,
    this.rootId,
    this.rootLetters,
    this.occurrences,
    this.exampleArabic,
    this.exampleFrench,
    this.theme,
    this.remark,
  });

  final String id;
  final String arabic;
  final String translit;
  final String french;

  /// nom, adjectif, verbe, particule, pronom, demonstratif, interrogatif,
  /// adverbe.
  final String nature;
  final String? gender;
  final String? plural;
  final String? past;
  final String? present;

  /// Lemme et racine du Quranic Arabic Corpus ; `null` si le mot n'y est
  /// pas lemmatisé (pronoms…) : rien n'est inventé.
  final String? lemmaId;
  final String? rootId;
  final String? rootLetters;

  /// Nombre d'occurrences du lemme dans le Corpus.
  final int? occurrences;
  final String? exampleArabic;
  final String? exampleFrench;
  final String? theme;

  /// Précision sur le genre ou l'usage (ex. « masculin (parfois féminin en
  /// arabe classique) »).
  final String? remark;
  final String lessonId;
  final int lessonStage;
  final int lessonOrdinal;
  final String meaningSource;

  /// Formes de base reconnues dans une phrase (voir [arabicKey]).
  final List<String> keys;

  String get natureLabel => switch (nature) {
    'nom' => gender == 'f' ? 'nom féminin' : 'nom masculin',
    'adjectif' => 'adjectif',
    'verbe' => 'verbe',
    'particule' => 'particule',
    // Pronoms, démonstratifs, interrogatifs : des noms en grammaire arabe
    // (décision du conseiller, 25/10/2026).
    'pronom' => 'nom (pronom)',
    'demonstratif' => 'nom (démonstratif)',
    'demonstratif_lieu' => 'nom (démonstratif de lieu)',
    'interrogatif' => 'nom (interrogatif)',
    'adverbe' => 'adverbe',
    _ => nature,
  };
}

final _marks = RegExp('[ً-ٰۖ-ۭـ]');
final _punct = RegExp(r'[،؛؟.!?,:«»"()…]');
const _unify = {
  'ٱ': 'ا',
  'أ': 'ا',
  'إ': 'ا',
  'آ': 'ا',
  'ى': 'ي',
  'ئ': 'ي',
  'ؤ': 'و',
  'ة': 'ه',
  'ء': '',
};
const _prefixes = ['و', 'ف', 'ب', 'ل', 'ك'];

/// Squelette d'un mot : sans voyelles ni signes, alifs et hamzas unifiés.
/// Même définition que `vocab.key` (Python).
String arabicKey(String token) {
  final bare = token.replaceAll(_punct, '').replaceAll(_marks, '');
  return bare.split('').map((c) => _unify[c] ?? c).join();
}

/// Formes de base possibles d'un mot d'une phrase (même définition que
/// `vocab.candidates`) : le mot, sans l'article, sans un préfixe d'une
/// lettre.
List<String> keyCandidates(String token) {
  final k = arabicKey(token);
  final out = [k];
  if (k.startsWith('ال') && k.length > 3) out.add(k.substring(2));
  if (k.isNotEmpty && _prefixes.contains(k[0]) && k.length > 2) {
    final rest = k.substring(1);
    out.add(rest);
    if (rest.startsWith('ال') && rest.length > 3) out.add(rest.substring(2));
    if (k.startsWith('لل') && k.length > 3) out.add(k.substring(2));
  }
  return out;
}

/// Mots d'une phrase, sans la ponctuation.
List<String> sentenceTokens(String text) =>
    text.replaceAll(_punct, ' ').split(RegExp(r'\s+')).where((t) {
      return t.isNotEmpty && arabicKey(t).isNotEmpty;
    }).toList();

const _accents = {
  'à': 'a', 'â': 'a', 'ä': 'a', 'é': 'e', 'è': 'e', 'ê': 'e', 'ë': 'e', //
  'î': 'i', 'ï': 'i', 'ô': 'o', 'ö': 'o', 'ù': 'u', 'û': 'u', 'ü': 'u', //
  'ç': 'c', 'œ': 'oe',
};

String _plain(String s) =>
    s.toLowerCase().split('').map((c) => _accents[c] ?? c).join();

final _arabicLetter = RegExp('[ء-يٱ]');

/// Recherche dans le dictionnaire (avenant n° 2) : en arabe avec ou sans
/// voyelles (le mot, sans article ni préfixe, ou le début du mot), par
/// racine (trois lettres), ou en français (sans tenir compte des accents).
/// Les mots dont la forme correspond exactement viennent d'abord.
List<Word> searchWords(List<Word> words, String query) {
  final q = query.trim();
  if (q.isEmpty) return const [];
  if (_arabicLetter.hasMatch(q)) {
    final cands = keyCandidates(q);
    final bare = arabicKey(q).replaceAll(' ', '');
    final exact = <Word>[];
    final other = <Word>[];
    for (final w in words) {
      if (w.keys.any(cands.contains)) {
        exact.add(w);
      } else if (w.rootLetters != null && arabicKey(w.rootLetters!) == bare) {
        other.add(w);
      } else if (bare.length >= 2 && w.keys.any((k) => k.startsWith(bare))) {
        other.add(w);
      }
    }
    return [...exact, ...other];
  }
  final p = _plain(q);
  return [
    for (final w in words)
      if (_plain(w.french).contains(p)) w,
  ];
}
