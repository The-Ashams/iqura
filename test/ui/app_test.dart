import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iqura/app.dart';
import 'package:iqura/core/app_paths.dart';
import 'package:iqura/core/providers.dart';
import 'package:iqura/data/content_db/content_database.dart';
import 'package:iqura/data/user_db/user_database.dart';
import 'package:iqura/features/settings/settings.dart';

late Directory tmp;
late UserDatabase userDb;
late ContentDatabase contentDb;

Widget app() => ProviderScope(
  overrides: [
    appPathsProvider.overrideWithValue(AppPaths(tmp.path)),
    userDatabaseProvider.overrideWithValue(userDb),
    contentDatabaseProvider.overrideWithValue(contentDb),
  ],
  child: const IquraApp(),
);

void setSize(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

void main() {
  setUp(() {
    tmp = Directory.systemTemp.createTempSync('iqura-ui');
    // Base de contenu réelle, générée par tools/build_content/.
    contentDb = ContentDatabase.openVerified(ContentDatabase.assetPath);
    userDb = UserDatabase.open(null);
  });

  tearDown(() {
    userDb.close();
    contentDb.close();
    tmp.deleteSync(recursive: true);
  });

  testWidgets('premier lancement : création du profil puis carte', (
    tester,
  ) async {
    setSize(tester, const Size(400, 800));
    await tester.pumpWidget(app());
    expect(find.text('Choisissez un pseudo'), findsOneWidget);

    await tester.tap(find.text('Commencer'));
    await tester.pump();
    expect(find.text('Au moins 2 caractères.'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Amina');
    await tester.tap(find.text('Commencer'));
    await tester.pumpAndSettle();
    expect(find.text('Bienvenue, Amina'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Pas encore disponible'), findsOneWidget);
  });

  testWidgets('écran large : rail latéral', (tester) async {
    setSize(tester, const Size(1280, 800));
    await tester.pumpWidget(app());
    await tester.enterText(find.byType(TextField), 'Amina');
    await tester.tap(find.text('Commencer'));
    await tester.pumpAndSettle();
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });

  testWidgets('paramètres : thème enregistré en base', (tester) async {
    setSize(tester, const Size(400, 900));
    await tester.pumpWidget(app());
    await tester.enterText(find.byType(TextField), 'Amina');
    await tester.tap(find.text('Commencer'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Paramètres'));
    await tester.pumpAndSettle();
    expect(find.text('Exporter ma progression'), findsOneWidget);
    expect(find.text('Rédigé par IA — non vérifié'), findsOneWidget);

    await tester.tap(find.text('Sombre'));
    await tester.pumpAndSettle();
    expect(SettingsRepository(userDb).load().themeMode, ThemeMode.dark);
    final material = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(material.themeMode, ThemeMode.dark);

    await tester.tap(find.text('Simplifiée'));
    await tester.pumpAndSettle();
    expect(find.textContaining('sabâhu l-khayri'), findsOneWidget);
  });

  testWidgets('paramètres : les sources des données sont citées', (
    tester,
  ) async {
    setSize(tester, const Size(400, 2400));
    await tester.pumpWidget(app());
    await tester.enterText(find.byType(TextField), 'Amina');
    await tester.tap(find.text('Commencer'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Paramètres'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sources des données'));
    await tester.pumpAndSettle();
    expect(
      find.text('Tanzil Quran Text (Uthmani, Version 1.1)'),
      findsOneWidget,
    );
    expect(
      find.textContaining('Quranic Arabic Corpus, données'),
      findsOneWidget,
    );
  });
}
