/// Lecture sans voyelles (région 4, chapitre C ; plan d'Avancé 2, 4.23) :
/// le texte reste écrit vocalisé dans les données, l'application retire les
/// signes selon le palier.
///
/// - Palier A : voyelles brèves et sukūn retirés à l'intérieur du mot ;
///   shadda, tanwīn et voyelle finale gardés.
/// - Palier B : voyelle finale et tanwīn retirés aussi ; shadda gardée.
/// - Palier C : lettres seules, comme dans un livre (sauf les mots à garder).
///
/// Toujours gardés : les lettres (hamza et ses supports, آ, ة, ى, alif du
/// tanwīn). Toujours retiré : le petit alif (هذا, لكن).
enum VowelLevel { a, b, c }

VowelLevel? vowelLevelFrom(String? code) => switch (code) {
  'A' => VowelLevel.a,
  'B' => VowelLevel.b,
  'C' => VowelLevel.c,
  _ => null,
};

const int _fathatan = 0x064B, _kasratan = 0x064D;
const int _fatha = 0x064E, _sukun = 0x0652, _shadda = 0x0651;
const int _smallAlif = 0x0670;

bool _isMark(int c) => (c >= _fathatan && c <= _sukun) || c == _smallAlif;
bool _isTanwin(int c) => c >= _fathatan && c <= _kasratan;
bool _isShortVowel(int c) => (c >= _fatha && c <= 0x0650) || c == _sukun;

/// Un mot (sans espace) au palier [level].
String stripWord(String word, VowelLevel level) {
  final cs = word.runes.toList();
  // Index de la dernière lettre (ni signe ni ponctuation).
  var last = -1;
  for (var i = cs.length - 1; i >= 0; i--) {
    final c = cs[i];
    if (!_isMark(c) && _isArabicLetter(c)) {
      last = i;
      break;
    }
  }
  final out = StringBuffer();
  for (var i = 0; i < cs.length; i++) {
    final c = cs[i];
    if (!_isMark(c)) {
      out.writeCharCode(c);
      continue;
    }
    if (c == _smallAlif) continue;
    final finalMark = last >= 0 && i > last;
    final keep = switch (level) {
      VowelLevel.a =>
        c == _shadda || _isTanwin(c) || (finalMark && _isShortVowel(c)),
      VowelLevel.b => c == _shadda,
      VowelLevel.c => false,
    };
    if (keep) out.writeCharCode(c);
  }
  return out.toString();
}

bool _isArabicLetter(int c) => c >= 0x0621 && c <= 0x064A;

/// Une phrase au palier [level] ; les mots de [keep] restent vocalisés.
String stripVowels(
  String text,
  VowelLevel level, {
  Set<String> keep = const {},
}) => text
    .split(' ')
    .map((w) => keep.contains(w) ? w : stripWord(w, level))
    .join(' ');
