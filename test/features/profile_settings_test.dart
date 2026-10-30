import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iqura/data/user_db/user_database.dart';
import 'package:iqura/features/profile/profile.dart';
import 'package:iqura/features/settings/settings.dart';

void main() {
  test('règles du pseudo', () {
    expect(PseudoRules.validate(' a '), isNotNull);
    expect(PseudoRules.validate('Amina'), isNull);
    expect(PseudoRules.validate('x' * 25), isNotNull);
  });

  test('le profil garde sa date de création quand on change de pseudo', () {
    final db = UserDatabase.open(null);
    var t = DateTime(2026, 1, 1);
    final repo = ProfileRepository(db, now: () => t);
    expect(repo.load(), isNull);
    repo.save('  Amina ');
    t = DateTime(2026, 6, 1);
    final p = repo.save('Bilal');
    expect(p.pseudo, 'Bilal');
    expect(p.createdAt, DateTime(2026, 1, 1));
    expect(() => repo.save('a'), throwsArgumentError);
    db.close();
  });

  test('réglages : valeurs par défaut puis enregistrées', () {
    final db = UserDatabase.open(null);
    final repo = SettingsRepository(db);
    final d = repo.load();
    expect(d.themeMode, ThemeMode.system);
    expect(d.transliteration, TransliterationStyle.scholarly);
    expect(d.arabicFontScale, 1.0);

    repo.saveThemeMode(ThemeMode.dark);
    repo.saveTransliteration(TransliterationStyle.simplified);
    repo.saveArabicFontScale(1.5);
    final s = repo.load();
    expect(s.themeMode, ThemeMode.dark);
    expect(s.transliteration, TransliterationStyle.simplified);
    expect(s.arabicFontScale, 1.5);
    db.close();
  });

  test('translittération masquable et animations désactivables', () {
    final db = UserDatabase.open(null);
    final repo = SettingsRepository(db);
    expect(repo.load().showTransliteration, isTrue);
    expect(repo.load().animations, isTrue);
    repo.saveShowTransliteration(false);
    repo.saveAnimations(false);
    expect(repo.load().showTransliteration, isFalse);
    expect(repo.load().animations, isFalse);
    db.close();
  });

  test('bruitages activés par défaut, désactivables', () {
    final db = UserDatabase.open(null);
    final repo = SettingsRepository(db);
    expect(repo.load().soundEffects, isTrue);
    repo.saveSoundEffects(false);
    expect(repo.load().soundEffects, isFalse);
    db.close();
  });

  test('réglage invalide en base : valeur par défaut', () {
    final db = UserDatabase.open(null);
    final repo = SettingsRepository(db)..saveArabicFontScale(1.2);
    db.select(
      "UPDATE settings SET value = 'pas du json' WHERE key = 'arabic_font_scale'",
    );
    expect(repo.load().arabicFontScale, 1.0);
    db.close();
  });
}
