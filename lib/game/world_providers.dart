import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers.dart';
import '../features/progress/lesson_progress.dart';
import 'world.dart';

/// Identifiant de l'examen (boss) d'une région, dans la progression.
String regionExamId(int regionNumber) => 'examen-r$regionNumber';

/// Régions ouvertes : la région 1, puis chaque région dont l'examen de la
/// précédente est réussi.
final unlockedRegionsProvider = Provider<List<Region>>((ref) {
  final all = ref.watch(contentDatabaseProvider).regions();
  final progress = ref.watch(lessonProgressProvider);
  final open = <Region>[all.first];
  for (var i = 1; i < all.length; i++) {
    final passed = progress[regionExamId(all[i - 1].number)]?.completed;
    if (passed != true) break;
    open.add(all[i]);
  }
  return open;
});

/// Région choisie par le joueur sur la carte ; `null` : la dernière ouverte.
final selectedRegionProvider = NotifierProvider<SelectedRegion, int?>(
  SelectedRegion.new,
);

class SelectedRegion extends Notifier<int?> {
  @override
  int? build() => null;

  void select(int number) => state = number;
}

/// Région en cours : celle choisie, sinon la dernière ouverte.
final currentRegionProvider = Provider<Region>((ref) {
  final open = ref.watch(unlockedRegionsProvider);
  final chosen = ref.watch(selectedRegionProvider);
  return open.firstWhere((r) => r.number == chosen, orElse: () => open.last);
});

final regionPlacesProvider = Provider<List<Place>>((ref) {
  final region = ref.watch(currentRegionProvider);
  return ref.watch(contentDatabaseProvider).places(region.id);
});

final regionCharactersProvider = Provider<List<GameCharacter>>((ref) {
  final region = ref.watch(currentRegionProvider);
  return ref.watch(contentDatabaseProvider).characters(region.id);
});
