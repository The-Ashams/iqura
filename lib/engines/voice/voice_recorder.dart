/// Enregistrement de la voix du joueur (cahier v3 §10) : écouter, répéter,
/// s'enregistrer, réécouter en alternance. Aucune note automatique de
/// prononciation. Le micro est demandé à la première utilisation ; seul le
/// dernier enregistrement de chaque élément est gardé, sur l'appareil, et il
/// n'est jamais envoyé ni exporté.
library;

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:record/record.dart';

import '../../core/providers.dart';

abstract class VoiceRecorder {
  /// Vrai si le micro est autorisé (le demande au besoin).
  Future<bool> allowed();

  /// Commence à enregistrer l'élément [key] (remplace l'ancien).
  Future<void> start(String key);

  /// Arrête ; renvoie le fichier enregistré, ou `null`.
  Future<String?> stop();

  /// Dernier enregistrement de [key], s'il existe.
  String? last(String key);

  Future<void> dispose();
}

class DeviceVoiceRecorder implements VoiceRecorder {
  DeviceVoiceRecorder(this.dir);

  final String dir;
  final AudioRecorder _recorder = AudioRecorder();

  String _path(String key) => p.join(
    dir,
    '${sha256.convert(utf8.encode(key)).toString().substring(0, 16)}.m4a',
  );

  @override
  Future<bool> allowed() => _recorder.hasPermission();

  @override
  Future<void> start(String key) async {
    Directory(dir).createSync(recursive: true);
    final path = _path(key);
    final f = File(path);
    if (f.existsSync()) f.deleteSync();
    await _recorder.start(
      const RecordConfig(encoder: AudioEncoder.aacLc, numChannels: 1),
      path: path,
    );
  }

  @override
  Future<String?> stop() => _recorder.stop();

  @override
  String? last(String key) {
    final path = _path(key);
    return File(path).existsSync() ? path : null;
  }

  @override
  Future<void> dispose() => _recorder.dispose();
}

final voiceRecorderProvider = Provider<VoiceRecorder>((ref) {
  final r = DeviceVoiceRecorder(ref.watch(appPathsProvider).recordingsDir);
  ref.onDispose(r.dispose);
  return r;
});
