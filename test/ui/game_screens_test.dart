import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iqura/app.dart';
import 'package:iqura/core/app_paths.dart';
import 'package:iqura/core/providers.dart';
import 'package:iqura/data/content_db/content_database.dart';
import 'package:iqura/data/user_db/user_database.dart';
import 'package:iqura/engines/audio/audio_service.dart';
import 'package:iqura/ui/game/combat_screen.dart';
import 'package:iqura/ui/game/place_screen.dart';
import 'package:iqura/ui/game/world_map_screen.dart';

class FakeAudio implements AudioService {
  final played = <String>[];
  @override
  Future<void> playAsset(String path) async => played.add(path);
  @override
  Future<void> dispose() async {}
}

late Directory tmp;
late UserDatabase userDb;
late ContentDatabase contentDb;
late FakeAudio audio;

Widget app({Widget? home}) => ProviderScope(
  overrides: [
    appPathsProvider.overrideWithValue(AppPaths(tmp.path)),
    userDatabaseProvider.overrideWithValue(userDb),
    contentDatabaseProvider.overrideWithValue(contentDb),
    audioServiceProvider.overrideWithValue(audio),
  ],
  child: home == null ? const IquraApp() : MaterialApp(home: home),
);

Future<void> start(WidgetTester tester) async {
  tester.view.physicalSize = const Size(700, 3200);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(app());
  await tester.enterText(find.byType(TextField), 'Amina');
  await tester.tap(find.text('Commencer'));
  await tester.pumpAndSettle();
}

void main() {
  setUp(() {
    tmp = Directory.systemTemp.createTempSync('iqura-game');
    contentDb = ContentDatabase.openVerified(ContentDatabase.assetPath);
    userDb = UserDatabase.open(null);
    audio = FakeAudio();
  });

  tearDown(() {
    userDb.close();
    contentDb.close();
    tmp.deleteSync(recursive: true);
  });

  testWidgets('carte : lieux de la tranche ouverts, les autres « à venir »', (
    tester,
  ) async {
    await start(tester);
    expect(find.text('Le Désert des Lettres'), findsOneWidget);
    expect(find.text(WorldMapScreen.lockedDetail), findsNWidgets(8));
    // Un lieu à venir ne s'ouvre pas.
    await tester.tap(find.text('4. Le Caravansérail'));
    await tester.pumpAndSettle();
    expect(find.byType(PlaceScreen), findsNothing);
  });

  testWidgets('lieu : scène, personnage, leçon jouable ou fermée', (
    tester,
  ) async {
    await start(tester);
    await tester.tap(find.text("1. Le Puits de l'arrivée"));
    await tester.pumpAndSettle();
    expect(find.byType(PlaceScreen), findsOneWidget);
    expect(find.text("Nūra, l'archiviste"), findsOneWidget);
    expect(find.text('Rédigé par IA'), findsOneWidget);
    expect(find.text("Leçon 0 · L'énigme du puits"), findsOneWidget);
    expect(find.text('Nouvelle'), findsOneWidget);
    await tester.tap(find.text('Retour à la carte'));
    await tester.pumpAndSettle();
    expect(find.byType(PlaceScreen), findsNothing);

    // Leçon 1 fermée tant que le mini-boss de la leçon 0 n'est pas réussi.
    await tester.tap(find.text('2. La Porte de la bibliothèque'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Fermée'), findsOneWidget);
    await tester.tap(find.text('Retour à la carte'));
    await tester.pumpAndSettle();

    // Leçons 2 et 3 : pas encore réécrites au format mini-donjon.
    await tester.tap(find.text('3. Le Marché aux enseignes'));
    await tester.pumpAndSettle();
    expect(find.text(PlaceScreen.lessonNotReady), findsNWidgets(2));
  });

  testWidgets('combat d’entraînement : question neutre, réponse, explication', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(700, 3200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(app(home: CombatScreen(random: Random(3))));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Comment se lit… ?'), findsOneWidget);
    expect(find.text(CombatScreen.practiceNotice), findsNothing);
    expect(find.textContaining(CombatScreen.practiceNotice), findsOneWidget);
    expect(find.text('Débloqué à la leçon 7'), findsOneWidget);

    // Écouter la syllabe : voix de synthèse.
    expect(find.text('synthèse'), findsOneWidget);
    await tester.tap(find.text('synthèse'));
    expect(audio.played.single, startsWith('audio/lecons/'));

    // Répondre : soit « Juste », soit l'explication avec la bonne lecture,
    // et les points de vie bougent en conséquence.
    final buttons = find.byType(OutlinedButton);
    expect(buttons, findsAtLeastNWidgets(3));
    var sawExplanation = false;
    for (var n = 0; n < 6 && !sawExplanation; n++) {
      await tester.tap(find.byType(OutlinedButton).first);
      await tester.pump(const Duration(milliseconds: 100));
      // Choisir ne suffit pas : il faut valider.
      expect(find.textContaining('Juste'), findsNothing);
      expect(find.textContaining('se lit «'), findsNothing);
      await tester.tap(find.text('Valider'));
      await tester.pump(const Duration(milliseconds: 100));
      final right = find.textContaining('Juste').evaluate().isNotEmpty;
      sawExplanation = find.textContaining('se lit «').evaluate().isNotEmpty;
      expect(right || sawExplanation, isTrue);
      if (find.text('Question suivante').evaluate().isEmpty) break;
      await tester.tap(find.text('Question suivante'));
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(sawExplanation, isTrue);
    expect(find.text('PV 50 / 50'), findsNothing);
  });

  testWidgets(
    'Grimoire : fiche de lettre et signalement gardé sur l’appareil',
    (tester) async {
      await start(tester);
      await tester.tap(find.text('Grimoire'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('bāʾ'));
      await tester.pumpAndSettle();
      expect(find.text('Lettre bāʾ'), findsOneWidget);
      expect(find.text('Rédigé par IA'), findsOneWidget);
      await tester.tap(find.text('Signaler une erreur'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byType(TextField),
        'Une coquille dans le nom',
      );
      await tester.runAsync(() async {
        await tester.tap(find.text('Enregistrer'));
        await Future<void>.delayed(const Duration(milliseconds: 200));
      });
      await tester.pumpAndSettle();
      expect(
        find.text('Signalement enregistré sur cet appareil.'),
        findsOneWidget,
      );
      expect(find.text('Envoyer par mail'), findsOneWidget);
      final saved = File(AppPaths(tmp.path).errorReports).readAsStringSync();
      expect(saved, contains('Une coquille dans le nom'));
    },
  );

  testWidgets('Sanctuaire : Al-Fātiḥa, texte vérifié et traduction citée', (
    tester,
  ) async {
    await start(tester);
    await tester.tap(find.text('Sanctuaire'));
    await tester.pumpAndSettle();
    for (var a = 1; a <= 7; a++) {
      expect(find.textContaining('1:$a — '), findsOneWidget);
    }
    expect(find.textContaining('édition non précisée'), findsOneWidget);
    expect(find.textContaining('pas encore disponible'), findsOneWidget);
  });

  testWidgets('Cité : bâtiments à reconstruire, sans faux bouton', (
    tester,
  ) async {
    await start(tester);
    await tester.tap(find.text('Cité'));
    await tester.pumpAndSettle();
    expect(find.text('La bibliothèque'), findsOneWidget);
    expect(find.text('À reconstruire'), findsNWidgets(5));
  });
}
