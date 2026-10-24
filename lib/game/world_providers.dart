import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers.dart';
import 'world.dart';

/// Région en cours : la première (région 1, jalon J1).
final currentRegionProvider = Provider<Region>(
  (ref) => ref.watch(contentDatabaseProvider).regions().first,
);

final regionPlacesProvider = Provider<List<Place>>((ref) {
  final region = ref.watch(currentRegionProvider);
  return ref.watch(contentDatabaseProvider).places(region.id);
});

final regionCharactersProvider = Provider<List<GameCharacter>>((ref) {
  final region = ref.watch(currentRegionProvider);
  return ref.watch(contentDatabaseProvider).characters(region.id);
});
