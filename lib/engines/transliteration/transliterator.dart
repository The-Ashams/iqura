/// Translittération de l'arabe vocalisé (norme *Arabica* ou simplifiée).
///
/// Table et règles : `docs/TRANSLITTERATION.md`. Moteur pur Dart, sans
/// dépendance, testé règle par règle.
library;

enum TranslitStyle { scholarly, simplified }

class Transliterator {
  const Transliterator();

  static const _fatha = 'َ';
  static const _kasra = 'ِ';
  static const _damma = 'ُ';
  static const _fathatan = 'ً';
  static const _kasratan = 'ٍ';
  static const _dammatan = 'ٌ';
  static const _sukun = 'ْ';
  static const _shadda = 'ّ';
  static const _daggerAlif = 'ٰ';
  static const _tatweel = 'ـ';

  static const _alif = 'ا';
  static const _alifWasla = 'ٱ';
  static const _alifMadda = 'آ';
  static const _alifMaqsura = 'ى';
  static const _waw = 'و';
  static const _ya = 'ي';
  static const _lam = 'ل';
  static const _taMarbuta = 'ة';

  /// Consonnes (norme Arabica).
  static const Map<String, String> consonants = {
    'ء': 'ʾ', // ء
    'أ': 'ʾ', // أ
    'إ': 'ʾ', // إ
    'ؤ': 'ʾ', // ؤ
    'ئ': 'ʾ', // ئ
    'ب': 'b',
    'ت': 't',
    'ث': 'ṯ',
    'ج': 'ǧ',
    'ح': 'ḥ',
    'خ': 'ḫ',
    'د': 'd',
    'ذ': 'ḏ',
    'ر': 'r',
    'ز': 'z',
    'س': 's',
    'ش': 'š',
    'ص': 'ṣ',
    'ض': 'ḍ',
    'ط': 'ṭ',
    'ظ': 'ẓ',
    'ع': 'ʿ',
    'غ': 'ġ',
    'ف': 'f',
    'ق': 'q',
    'ك': 'k',
    'ل': 'l',
    'م': 'm',
    'ن': 'n',
    'ه': 'h',
    'و': 'w',
    'ي': 'y',
  };

  /// Passage du style savant au style simplifié.
  static const Map<String, String> simplification = {
    'ʾ': "'",
    'ʿ': '`',
    'ṯ': 'th',
    'ǧ': 'j',
    'ḥ': 'h',
    'ḫ': 'kh',
    'ḏ': 'dh',
    'š': 'sh',
    'ṣ': 's',
    'ḍ': 'd',
    'ṭ': 't',
    'ẓ': 'z',
    'ġ': 'gh',
    'ā': 'â',
    'ī': 'î',
    'ū': 'û',
  };

  static const _hamzaSeats = {'ء', 'أ', 'إ', 'ؤ', 'ئ'};
  static const _vowelMarks = {_fatha, _kasra, _damma};
  static const _tanwin = {_fathatan, _kasratan, _dammatan};

  static bool _isMark(String c) =>
      _vowelMarks.contains(c) ||
      _tanwin.contains(c) ||
      c == _sukun ||
      c == _shadda ||
      c == _daggerAlif;

  /// Translittère une phrase (mots séparés par des espaces).
  String transliterate(
    String text, {
    TranslitStyle style = TranslitStyle.scholarly,
  }) {
    final out = <String>[];
    var previousEndsWithVowel = false;
    for (final word in text.split(RegExp(r'\s+')).where((w) => w.isNotEmpty)) {
      final t = _word(word, afterVowel: previousEndsWithVowel);
      out.add(t);
      previousEndsWithVowel =
          t.isNotEmpty && 'aiuāīū'.contains(t[t.length - 1]);
    }
    final scholarly = out.join(' ');
    return style == TranslitStyle.scholarly ? scholarly : simplify(scholarly);
  }

  static String simplify(String scholarly) {
    final b = StringBuffer();
    for (final rune in scholarly.runes) {
      final c = String.fromCharCode(rune);
      b.write(simplification[c] ?? c);
    }
    return b.toString();
  }

  String _word(String raw, {required bool afterVowel}) {
    final chars = [for (final r in raw.runes) String.fromCharCode(r)]
        .where((c) => c != _tatweel)
        .toList();
    final b = StringBuffer();
    var i = 0;
    var skipNextShadda = false;

    // Article : ال / ٱل en début de mot.
    if (chars.length > 2 &&
        (chars[0] == _alif || chars[0] == _alifWasla) &&
        chars[1] == _lam) {
      b.write(afterVowel ? 'l-' : 'al-');
      i = 2;
      if (i < chars.length && chars[i] == _sukun) i++;
      // Lettre solaire : la shadda d'assimilation n'est pas notée.
      skipNextShadda = true;
    }

    // Marques portées par la lettre en position j (indices j+1…).
    List<String> marksAfter(int j) {
      final m = <String>[];
      for (var k = j + 1; k < chars.length && _isMark(chars[k]); k++) {
        m.add(chars[k]);
      }
      return m;
    }

    String lastVowel() {
      final s = b.toString();
      return s.isEmpty ? '' : s[s.length - 1];
    }

    void lengthen(String shortV, String longV) {
      final s = b.toString();
      if (s.endsWith(shortV)) {
        b.clear();
        b.write(s.substring(0, s.length - 1));
        b.write(longV);
      }
    }

    for (; i < chars.length; i++) {
      final c = chars[i];
      final marks = marksAfter(i);
      final hasVowel = marks.any(
        (m) => _vowelMarks.contains(m) || _tanwin.contains(m),
      );
      final isFirst =
          b.isEmpty || b.toString() == 'al-' || b.toString() == 'l-';

      if (c == _alif || c == _alifMaqsura) {
        if (!hasVowel && lastVowel() == 'a') {
          lengthen('a', 'ā'); // voyelle longue
        } else if (!hasVowel && b.toString().endsWith('an')) {
          // alif du tanwīn : non noté
        } else if (c == _alif && i == 0 && hasVowel) {
          // alif initial portant une voyelle : hamza non notée en début
        }
      } else if (c == _alifMadda) {
        b.write(isFirst ? 'ā' : 'ʾā');
      } else if (c == _alifWasla) {
        // waṣla hors article : rien
      } else if (c == _daggerAlif) {
        if (lastVowel() == 'a') {
          lengthen('a', 'ā');
        } else {
          b.write('ā');
        }
        continue;
      } else if (c == _taMarbuta) {
        if (hasVowel) b.write('t');
      } else if ((c == _ya || c == _waw) &&
          !hasVowel &&
          !marks.contains(_shadda) &&
          ((c == _ya && lastVowel() == 'i') ||
              (c == _waw && lastVowel() == 'u'))) {
        lengthen(c == _ya ? 'i' : 'u', c == _ya ? 'ī' : 'ū');
      } else if (consonants.containsKey(c)) {
        final initialHamza = _hamzaSeats.contains(c) && isFirst && i == 0;
        if (!initialHamza) {
          final cons = consonants[c]!;
          b.write(cons);
          if (marks.contains(_shadda)) {
            if (skipNextShadda) {
              skipNextShadda = false;
            } else {
              b.write(cons);
            }
          }
        }
        skipNextShadda = false;
      } else if (_isMark(c)) {
        // les marques sont traitées avec leur lettre (ci-dessous)
      } else {
        // signe hors table (ex. signes du Mushaf) : ignoré
        continue;
      }

      // Voyelles portées par la lettre.
      for (final m in marks) {
        switch (m) {
          case _fatha:
            b.write('a');
          case _kasra:
            b.write('i');
          case _damma:
            b.write('u');
          case _fathatan:
            b.write('an');
          case _kasratan:
            b.write('in');
          case _dammatan:
            b.write('un');
          case _daggerAlif:
            lengthen('a', 'ā');
        }
      }
      i += marks.length;
    }
    return b.toString();
  }
}
