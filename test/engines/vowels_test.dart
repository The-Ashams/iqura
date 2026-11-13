import 'package:flutter_test/flutter_test.dart';
import 'package:iqura/engines/arabic/vowels.dart';

void main() {
  test('palier A : voyelles internes retirées, fin et shadda gardées', () {
    expect(stripWord('التَّاجِرُ', VowelLevel.a), 'التّاجرُ');
    expect(stripWord('كَثِيرٌ', VowelLevel.a), 'كثيرٌ');
  });
  test('palier B : fin et tanwīn retirés, shadda gardée', () {
    expect(stripWord('التَّاجِرُ', VowelLevel.b), 'التّاجر');
    expect(stripWord('دِرْهَمًا', VowelLevel.b), 'درهما');
  });
  test('palier C : lettres seules ; petit alif retiré', () {
    expect(stripWord('هَٰذَا', VowelLevel.c), 'هذا');
    expect(stripWord('ذَهَبٌ', VowelLevel.c), 'ذهب');
  });
  test('ponctuation gardée, mots à garder intacts', () {
    expect(
      stripVowels('ذَهَبَ التَّاجِرُ.', VowelLevel.c, keep: {'ذَهَبَ'}),
      'ذَهَبَ التاجر.',
    );
  });
  test('code de palier', () {
    expect(vowelLevelFrom('B'), VowelLevel.b);
    expect(vowelLevelFrom(null), isNull);
  });
}
