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

  /// Précision sur le genre ou l'usage (ex. « parfois féminin en
  /// arabe classique »).
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
    // تَحْتَ، فَوْقَ، مَعَ، عِنْدَ (décision n° 3, Élémentaire 2).
    'nom_lieu' => 'nom de lieu, employé comme une préposition',
    'nombre' => 'nom (nombre)',
    'relatif' => 'nom (relatif)',
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

/// Terminaisons collées au nom, en squelette (même table que
/// `vocab.ENDINGS`) : pronoms, duel, pluriel, alif du tanwīn -an.
const _endings = [
  ['هما', 'كما', 'ها', 'نا', 'كم', 'كن', 'هم', 'هن', 'ي', 'ك', 'ه'],
  ['ان', 'ين'],
  ['ون', 'ين', 'ات'],
  ['ا'],
];

/// Formes de base possibles d'un mot d'une phrase (même définition que
/// `vocab.candidates`, toutes terminaisons comprises) : le mot, sans
/// l'article, sans un préfixe d'une lettre, sans une terminaison.
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
  void add(String c) {
    if (!out.contains(c)) out.add(c);
  }

  for (final base in List.of(out)) {
    for (final group in _endings) {
      for (final s in group) {
        if (!base.endsWith(s)) continue;
        final rest = base.substring(0, base.length - s.length);
        // Une seule lettre ne reste que pour لِـ, بِـ, كَـ… (لِي، لَهُ).
        if (rest.length < 2 && !_prefixes.contains(rest)) continue;
        add(rest);
        if (rest.endsWith('ت')) add('${rest.substring(0, rest.length - 1)}ه');
        if (s == 'ات') add('$restه');
      }
    }
  }
  // Verbes réguliers (même définition que `vocab._verb_stems`) : formes
  // conjuguées ramenées au passé ou à l'inaccompli de la fiche.
  for (final base in List.of(out)) {
    for (final c in _verbStems(base)) {
      add(c);
    }
  }
  return out;
}

const _pastSuffixes = ['تما', 'تم', 'تن', 'نا', 'وا', 'ت', 'ا', 'ن'];
const _presentPrefixes = ['ي', 'ت', 'ا', 'ن'];
const _presentSuffixes = ['ون', 'ين', 'ان', 'وا', 'ن', 'ي', 'ا'];

List<String> _verbStems(String k) {
  final out = <String>[];
  void add(String c) {
    if (c.length >= 2 && !out.contains(c)) out.add(c);
  }

  void present(String form) {
    if (form.length > 3 && _presentPrefixes.contains(form[0])) {
      final stem = form.substring(1);
      add('ي$stem');
      for (final s in _presentSuffixes) {
        if (stem.endsWith(s) && stem.length - s.length >= 2) {
          add('ي${stem.substring(0, stem.length - s.length)}');
        }
      }
    }
  }

  for (final s in _pastSuffixes) {
    if (k.endsWith(s) && k.length - s.length >= 2) {
      add(k.substring(0, k.length - s.length));
      // سَكَنَّا : le ن du verbe et celui de la terminaison.
      if ('نت'.contains(s[0])) {
        add('${k.substring(0, k.length - s.length)}${s[0]}');
      }
    }
  }
  present(k);
  if (k.startsWith('س') && k.length > 4) {
    add(k.substring(1));
    present(k.substring(1));
  }
  if (k.startsWith('ا') && k.length > 3) {
    final stem = k.substring(1);
    add('ي$stem');
    for (final s in ['ي', 'وا', 'ا', 'ن']) {
      if (stem.endsWith(s) && stem.length - s.length >= 2) {
        add('ي${stem.substring(0, stem.length - s.length)}');
      }
    }
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
