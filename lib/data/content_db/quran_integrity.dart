/// Contrôle d'intégrité du texte coranique de la base de contenu.
///
/// Le texte vient uniquement de Tanzil et ne doit jamais être modifié.
/// L'empreinte ci-dessous est calculée par `tools/build_content/` à partir
/// du fichier Tanzil versionné ; elle est figée ici indépendamment de la
/// base, qui ne peut donc pas « se valider elle-même ».
library;

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:sqlite3/sqlite3.dart';

/// SHA-256 du texte Tanzil Uthmani 1.1 (voir [quranTextSha256]).
const String expectedQuranTextSha256 =
    '351c2dcbf6ec6ccebb856bf5cb82f40073767fbd215ea92008e82989fcae189e';

/// SHA-256 (UTF-8) de la suite des lignes `sourate|0|basmala\n` (si la
/// sourate en a une) puis `sourate|verset|texte\n`, dans l'ordre du Coran.
/// Même définition que `tanzil.integrity_sha256` (Python).
String quranTextSha256(Database db) {
  final bismillah = {
    for (final r in db.select(
      'SELECT id, bismillah FROM surah WHERE bismillah IS NOT NULL',
    ))
      r['id'] as int: r['bismillah'] as String,
  };
  final output = _DigestSink();
  final input = sha256.startChunkedConversion(output);
  for (final r in db.select(
    'SELECT surah_id, ayah, text_uthmani FROM verse ORDER BY id',
  )) {
    final s = r['surah_id'] as int;
    final a = r['ayah'] as int;
    if (a == 1 && bismillah.containsKey(s)) {
      input.add(utf8.encode('$s|0|${bismillah[s]}\n'));
    }
    input.add(utf8.encode('$s|$a|${r['text_uthmani']}\n'));
  }
  input.close();
  return output.value.toString();
}

class _DigestSink implements Sink<Digest> {
  late Digest value;
  @override
  void add(Digest data) => value = data;
  @override
  void close() {}
}
