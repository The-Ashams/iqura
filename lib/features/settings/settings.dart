/// Réglages de l'application, enregistrés dans la table `settings` de la
/// base utilisateur (une ligne par clé, valeur en JSON).
library;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../engines/transliteration/transliterator.dart';
import '../../data/user_db/schema.dart';
import '../../data/user_db/user_database.dart';

enum TransliterationStyle {
  /// Norme Arabica : ṯ, ǧ, ḫ, ā… (par défaut)
  scholarly('savante', 'Savante'),

  /// th, j, kh, â… (docs/TRANSLITTERATION.md)
  simplified('simplifiee', 'Simplifiée');

  const TransliterationStyle(this.storageValue, this.label);
  final String storageValue;
  final String label;

  TranslitStyle get engineStyle => switch (this) {
    TransliterationStyle.scholarly => TranslitStyle.scholarly,
    TransliterationStyle.simplified => TranslitStyle.simplified,
  };

  static TransliterationStyle fromStorage(Object? v) =>
      values.firstWhere((s) => s.storageValue == v, orElse: () => scholarly);
}

@immutable
class AppSettings {
  const AppSettings({
    this.themeMode = ThemeMode.system,
    this.transliteration = TransliterationStyle.scholarly,
    this.arabicFontScale = 1.0,
  });

  final ThemeMode themeMode;
  final TransliterationStyle transliteration;

  /// Facteur appliqué à la taille du texte arabe.
  final double arabicFontScale;

  static const double minArabicScale = 0.8;
  static const double maxArabicScale = 2.0;

  AppSettings copyWith({
    ThemeMode? themeMode,
    TransliterationStyle? transliteration,
    double? arabicFontScale,
  }) => AppSettings(
    themeMode: themeMode ?? this.themeMode,
    transliteration: transliteration ?? this.transliteration,
    arabicFontScale: arabicFontScale ?? this.arabicFontScale,
  );
}

class SettingsRepository {
  SettingsRepository(this._db);
  final UserDatabase _db;

  static const _theme = 'theme_mode';
  static const _translit = 'transliteration';
  static const _arabicScale = 'arabic_font_scale';

  AppSettings load() {
    final rows = _db.select(
      'SELECT key, value FROM settings WHERE deleted = 0',
    );
    final values = {
      for (final r in rows) r['key'] as String: _decode(r['value'] as String),
    };
    final scale = values[_arabicScale];
    return AppSettings(
      themeMode: ThemeMode.values.firstWhere(
        (m) => m.name == values[_theme],
        orElse: () => ThemeMode.system,
      ),
      transliteration: TransliterationStyle.fromStorage(values[_translit]),
      arabicFontScale: scale is num
          ? scale.toDouble().clamp(
              AppSettings.minArabicScale,
              AppSettings.maxArabicScale,
            )
          : 1.0,
    );
  }

  static Object? _decode(String json) {
    try {
      return jsonDecode(json);
    } on FormatException {
      return null;
    }
  }

  void _put(String key, Object value) =>
      _db.upsert(settingsTable, {'key': key, 'value': jsonEncode(value)});

  void saveThemeMode(ThemeMode m) => _put(_theme, m.name);
  void saveTransliteration(TransliterationStyle s) =>
      _put(_translit, s.storageValue);
  void saveArabicFontScale(double v) => _put(_arabicScale, v);
}

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(ref.watch(userDatabaseProvider)),
);

final settingsProvider = NotifierProvider<SettingsNotifier, AppSettings>(
  SettingsNotifier.new,
);

class SettingsNotifier extends Notifier<AppSettings> {
  SettingsRepository get _repo => ref.read(settingsRepositoryProvider);

  @override
  AppSettings build() => ref.watch(settingsRepositoryProvider).load();

  void setThemeMode(ThemeMode m) {
    _repo.saveThemeMode(m);
    state = state.copyWith(themeMode: m);
  }

  void setTransliteration(TransliterationStyle s) {
    _repo.saveTransliteration(s);
    state = state.copyWith(transliteration: s);
  }

  /// [persist] à faux pendant le glissement du curseur : on n'écrit en base
  /// qu'à la fin.
  void setArabicFontScale(double v, {bool persist = true}) {
    final clamped = v.clamp(
      AppSettings.minArabicScale,
      AppSettings.maxArabicScale,
    );
    if (persist) _repo.saveArabicFontScale(clamped);
    state = state.copyWith(arabicFontScale: clamped);
  }

  /// Relit la base (après un import ou une restauration).
  void reload() => state = _repo.load();
}
