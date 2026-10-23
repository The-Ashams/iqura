/// Lecture des enregistrements livrés avec l'application (hors ligne).
///
/// Les enregistrements des leçons sont des voix de synthèse (Chatterbox) :
/// l'interface affiche toujours la mention « synthèse » à côté du bouton.
library;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/settings/settings.dart';

abstract class AudioService {
  /// Joue un fichier des ressources de l'application, chemin relatif à
  /// `assets/` (par exemple `audio/lecons/ar-….mp3`).
  Future<void> playAsset(String path);

  Future<void> dispose();
}

class AudioPlayersService implements AudioService {
  AudioPlayersService() : _player = AudioPlayer();

  final AudioPlayer _player;

  @override
  Future<void> playAsset(String path) async {
    await _player.stop();
    await _player.play(AssetSource(path));
  }

  @override
  Future<void> dispose() => _player.dispose();
}

final audioServiceProvider = Provider<AudioService>((ref) {
  final service = AudioPlayersService();
  ref.onDispose(service.dispose);
  return service;
});

/// Bruitages du jeu (`assets/sfx/`, créés pour le projet : tools/build_sfx).
enum Sfx { menu, choix, juste, faux, coup, degats, victoire, repli, sceau }

/// Joue les bruitages sur leurs propres lecteurs, pour ne jamais couper le
/// son d'une leçon. Rien n'est joué si les bruitages sont désactivés.
abstract class SfxPlayer {
  Future<void> play(Sfx sound);

  Future<void> dispose();
}

class AudioPlayersSfx implements SfxPlayer {
  // Quelques lecteurs en rotation : deux bruitages rapprochés se superposent.
  final List<AudioPlayer> _players = List.generate(3, (_) => AudioPlayer());
  int _next = 0;

  @override
  Future<void> play(Sfx sound) async {
    final p = _players[_next];
    _next = (_next + 1) % _players.length;
    try {
      await p.stop();
      await p.play(AssetSource('sfx/${sound.name}.wav'), volume: 0.6);
    } catch (_) {
      // Un bruitage manqué n'empêche jamais de jouer.
    }
  }

  @override
  Future<void> dispose() async {
    for (final p in _players) {
      await p.dispose();
    }
  }
}

final sfxPlayerProvider = Provider<SfxPlayer>((ref) {
  final player = AudioPlayersSfx();
  ref.onDispose(player.dispose);
  return player;
});

/// Joue un bruitage si le joueur ne les a pas désactivés.
void playSfx(WidgetRef ref, Sfx sound) {
  if (ref.read(settingsProvider).soundEffects) {
    ref.read(sfxPlayerProvider).play(sound);
  }
}
