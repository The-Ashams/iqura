import 'package:flutter_test/flutter_test.dart';
import 'package:iqura/engines/transliteration/transliterator.dart';

void main() {
  const t = Transliterator();
  String s(String ar) => t.transliterate(ar);
  String simple(String ar) =>
      t.transliterate(ar, style: TranslitStyle.simplified);

  group('Arabica (savante)', () {
    final cases = {
      // voyelles brèves, consonnes à points
      'ثَبَتَ': 'ṯabata',
      'نَبَتَ': 'nabata',
      'بَحَثَ': 'baḥaṯa',
      'نَجَحَ': 'naǧaḥa',
      'حُجِبَ': 'ḥuǧiba',
      'بُنِيَ': 'buniya',
      // voyelles longues, tanwīn, tāʾ marbūṭa
      'كِتَابٌ': 'kitābun',
      'كِتَابًا': 'kitāban',
      'قَالَ': 'qāla',
      'فِي': 'fī',
      'سُورَةٌ': 'sūratun',
      'مَدِينَةٌ': 'madīnatun',
      'مَدِينَة': 'madīna',
      'عَلَى': 'ʿalā',
      // diphtongues, hamza
      'بَيْتٌ': 'baytun',
      'يَوْمٌ': 'yawmun',
      'سَمَاءٌ': 'samāʾun',
      'أَمْرٌ': 'amrun',
      'سَأَلَ': 'saʾala',
      // shadda
      'رَبٌّ': 'rabbun',
      // article : al- sans assimilation, voyelle élidée après voyelle
      'الشَّمْسُ': 'al-šamsu',
      'الْقَمَرُ': 'al-qamaru',
      'صَبَاحُ الْخَيْرِ': 'ṣabāḥu l-ḫayri',
    };
    cases.forEach((ar, expected) {
      test('$ar → $expected', () => expect(s(ar), expected));
    });
  });

  group('simplifiée', () {
    test('consonnes et voyelles longues', () {
      expect(simple('ثَبَتَ'), 'thabata');
      expect(simple('نَجَحَ'), 'najaha');
      expect(simple('خَيْرٌ'), 'khayrun');
      expect(simple('صَبَاحُ الْخَيْرِ'), 'sabâhu l-khayri');
      expect(simple('سَمَاءٌ'), "samâ'un");
      expect(simple('عَلَى'), '`alâ');
    });
  });

  test(
    'chaque lettre de la table a un équivalent simplifié sans diacritique',
    () {
      for (final latin in Transliterator.consonants.values) {
        final simplified = Transliterator.simplify(latin);
        expect(
          RegExp(r"^[a-z'`]+$").hasMatch(simplified),
          isTrue,
          reason: latin,
        );
      }
    },
  );
}
