/// Lecture des enregistrements livrés avec l'application (hors ligne).
///
/// Les enregistrements des leçons sont des voix de synthèse (Chatterbox) :
/// l'interface affiche toujours la mention « synthèse » à côté du bouton.
library;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
