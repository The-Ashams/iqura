/// Format de l'archive d'export de la progression (fichier `.zip`).
///
/// Contenu :
/// - `manifest.json` : format, versions, date, appareil, et pour chaque
///   fichier de données son empreinte SHA-256 et sa taille ;
/// - `tables/<table>.json` : une table de la base utilisateur, sous la forme
///   `{"table": ..., "columns": [...], "rows": [[...], ...]}`.
///
/// Le décodage refuse tout ce qui n'est pas attendu : fichiers inconnus,
/// tailles excessives, empreintes fausses, colonnes ou valeurs invalides.
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';

import 'hlc.dart';
import 'table_def.dart';

const String exportFormatName = 'iqura-export';
const int exportFormatVersion = 1;
const String manifestFileName = 'manifest.json';

/// Erreur d'import lisible par l'utilisateur.
class ExportArchiveException implements Exception {
  const ExportArchiveException(this.message);
  final String message;
  @override
  String toString() => message;
}

class ArchiveLimits {
  const ArchiveLimits({
    this.maxArchiveBytes = 100 * 1024 * 1024,
    this.maxEntryBytes = 200 * 1024 * 1024,
    this.maxTotalBytes = 400 * 1024 * 1024,
  });

  final int maxArchiveBytes;
  final int maxEntryBytes;
  final int maxTotalBytes;
}

class ExportManifest {
  const ExportManifest({
    required this.formatVersion,
    required this.schemaVersion,
    required this.appVersion,
    required this.createdAt,
    required this.deviceId,
  });

  final int formatVersion;
  final int schemaVersion;
  final String appVersion;
  final DateTime createdAt;
  final String deviceId;
}

/// Données d'une archive : en-tête et lignes de chaque table exportée.
class ExportData {
  const ExportData({required this.manifest, required this.tables});

  final ExportManifest manifest;

  /// Nom de table → lignes (colonne → valeur).
  final Map<String, List<Map<String, Object?>>> tables;

  int get rowCount => tables.values.fold(0, (sum, rows) => sum + rows.length);
}

String _tablePath(String table) => 'tables/$table.json';

/// Construit l'archive ZIP.
Uint8List encodeExportArchive(ExportData data, List<TableDef> schema) {
  final archive = Archive();
  final files = <Map<String, Object?>>[];
  for (final def in schema.where((d) => d.exported)) {
    final rows = data.tables[def.name] ?? const [];
    final cols = def.columnNames;
    final json = jsonEncode({
      'table': def.name,
      'columns': cols,
      'rows': [
        for (final r in rows) [for (final c in cols) r[c]],
      ],
    });
    final bytes = utf8.encode(json);
    final path = _tablePath(def.name);
    archive.add(ArchiveFile.bytes(path, bytes));
    files.add({
      'path': path,
      'sha256': sha256.convert(bytes).toString(),
      'size': bytes.length,
      'rows': rows.length,
    });
  }
  final m = data.manifest;
  final manifest = const JsonEncoder.withIndent('  ').convert({
    'format': exportFormatName,
    'format_version': m.formatVersion,
    'schema_version': m.schemaVersion,
    'app_version': m.appVersion,
    'created_at': m.createdAt.toUtc().toIso8601String(),
    'device_id': m.deviceId,
    'files': files,
  });
  archive.add(ArchiveFile.string(manifestFileName, manifest));
  return ZipEncoder().encodeBytes(archive);
}

/// Lit et valide une archive. Lève [ExportArchiveException] si elle est
/// invalide.
///
/// [currentSchemaVersion] : version du schéma de la base de cette
/// application. Une archive d'une version plus récente est refusée.
ExportData decodeExportArchive(
  Uint8List bytes,
  List<TableDef> schema, {
  required int currentSchemaVersion,
  ArchiveLimits limits = const ArchiveLimits(),
}) {
  Never fail(String message) => throw ExportArchiveException(message);

  if (bytes.length > limits.maxArchiveBytes) {
    fail('Fichier trop volumineux pour être une sauvegarde IQURA.');
  }

  final Archive archive;
  try {
    archive = ZipDecoder().decodeBytes(bytes);
  } catch (_) {
    fail("Ce fichier n'est pas une archive ZIP valide.");
  }
  // Le décodeur rend une archive vide pour des octets qui ne sont pas un ZIP.
  if (archive.isEmpty) {
    fail("Ce fichier n'est pas une archive ZIP valide.");
  }

  final defs = {for (final d in schema.where((d) => d.exported)) d.name: d};
  final allowed = {
    manifestFileName,
    for (final name in defs.keys) _tablePath(name),
  };

  final entries = <String, ArchiveFile>{};
  var total = 0;
  for (final f in archive.files) {
    if (!f.isFile || f.isSymbolicLink) {
      fail("L'archive contient un élément inattendu : ${f.name}");
    }
    if (!allowed.contains(f.name)) {
      fail("L'archive contient un fichier inconnu : ${f.name}");
    }
    if (entries.containsKey(f.name)) {
      fail("L'archive contient deux fois le fichier ${f.name}.");
    }
    if (f.size < 0 || f.size > limits.maxEntryBytes) {
      fail('Le fichier ${f.name} est trop volumineux.');
    }
    total += f.size;
    if (total > limits.maxTotalBytes) {
      fail('Le contenu de l’archive est trop volumineux.');
    }
    entries[f.name] = f;
  }

  Uint8List read(String name) {
    try {
      final data = entries[name]!.readBytes();
      if (data == null) fail('Le fichier $name est illisible.');
      return data;
    } on ExportArchiveException {
      rethrow;
    } catch (_) {
      fail('Le fichier $name est illisible ou chiffré.');
    }
  }

  Object? parseJson(String name, Uint8List data) {
    try {
      return jsonDecode(utf8.decode(data));
    } catch (_) {
      fail("Le fichier $name n'est pas un JSON valide.");
    }
  }

  // En-tête
  if (!entries.containsKey(manifestFileName)) {
    fail("Ce fichier n'est pas une sauvegarde IQURA (manifest.json absent).");
  }
  final manifestJson = parseJson(manifestFileName, read(manifestFileName));
  if (manifestJson is! Map<String, Object?> ||
      manifestJson['format'] != exportFormatName) {
    fail("Ce fichier n'est pas une sauvegarde IQURA.");
  }
  final formatVersion = manifestJson['format_version'];
  final schemaVersion = manifestJson['schema_version'];
  final appVersion = manifestJson['app_version'];
  final createdAtText = manifestJson['created_at'];
  final deviceId = manifestJson['device_id'];
  final files = manifestJson['files'];
  if (formatVersion is! int ||
      schemaVersion is! int ||
      appVersion is! String ||
      createdAtText is! String ||
      deviceId is! String ||
      files is! List) {
    fail('En-tête de sauvegarde incomplet ou invalide.');
  }
  if (formatVersion > exportFormatVersion ||
      schemaVersion > currentSchemaVersion) {
    fail(
      'Cette sauvegarde vient d’une version plus récente d’IQURA '
      '($appVersion). Mettez l’application à jour avant de l’importer.',
    );
  }
  if (formatVersion < 1 || schemaVersion < 1) {
    fail('Version de sauvegarde invalide.');
  }
  final createdAt = DateTime.tryParse(createdAtText);
  if (createdAt == null) fail('Date de sauvegarde invalide.');

  // Fichiers listés = fichiers présents, empreintes exactes.
  final listed = <String, String>{};
  for (final f in files) {
    if (f is! Map<String, Object?> ||
        f['path'] is! String ||
        f['sha256'] is! String) {
      fail('Liste des fichiers invalide dans l’en-tête.');
    }
    final path = f['path'] as String;
    if (path == manifestFileName || !allowed.contains(path)) {
      fail("L'en-tête cite un fichier inconnu : $path");
    }
    if (listed.containsKey(path)) {
      fail("L'en-tête cite deux fois le fichier $path.");
    }
    listed[path] = f['sha256'] as String;
  }
  final present = entries.keys.where((k) => k != manifestFileName).toSet();
  if (present.length != listed.length || !present.containsAll(listed.keys)) {
    fail("Les fichiers de l'archive ne correspondent pas à son en-tête.");
  }
  // Format 1 : toutes les tables exportées doivent être présentes, sinon une
  // restauration complète viderait silencieusement celles qui manquent.
  if (listed.length != allowed.length - 1) {
    fail("L'archive est incomplète : il manque des tables.");
  }

  final tables = <String, List<Map<String, Object?>>>{};
  for (final path in listed.keys) {
    final data = read(path);
    if (sha256.convert(data).toString() != listed[path]) {
      fail('Le fichier $path est corrompu (empreinte SHA-256 différente).');
    }
    final json = parseJson(path, data);
    if (json is! Map<String, Object?>) fail('Le fichier $path est invalide.');
    final name = json['table'];
    final def = defs[name];
    if (def == null || _tablePath(def.name) != path) {
      fail('Le fichier $path ne décrit pas la bonne table.');
    }
    tables[def.name] = _readRows(def, json, fail);
  }

  return ExportData(
    manifest: ExportManifest(
      formatVersion: formatVersion,
      schemaVersion: schemaVersion,
      appVersion: appVersion,
      createdAt: createdAt,
      deviceId: deviceId,
    ),
    tables: tables,
  );
}

List<Map<String, Object?>> _readRows(
  TableDef def,
  Map<String, Object?> json,
  Never Function(String) fail,
) {
  final columns = json['columns'];
  final rows = json['rows'];
  if (columns is! List || rows is! List) {
    fail('Table ${def.name} : structure invalide.');
  }
  final cols = <ColumnDef>[];
  for (final c in columns) {
    final col = c is String ? def.column(c) : null;
    if (col == null) fail('Table ${def.name} : colonne inconnue « $c ».');
    if (cols.contains(col)) {
      fail('Table ${def.name} : colonne « $c » en double.');
    }
    cols.add(col);
  }
  for (final required in def.columns.where((c) => !c.nullable)) {
    if (!cols.contains(required)) {
      fail('Table ${def.name} : colonne « ${required.name} » manquante.');
    }
  }

  final out = <Map<String, Object?>>[];
  final seen = <Object?>{};
  for (final r in rows) {
    if (r is! List || r.length != cols.length) {
      fail('Table ${def.name} : ligne de longueur invalide.');
    }
    final row = <String, Object?>{};
    for (var i = 0; i < cols.length; i++) {
      var value = r[i];
      // JSON ne distingue pas 1 et 1.0 : on accepte un entier pour un réel.
      if (cols[i].type == ColumnType.real && value is int) {
        value = value.toDouble();
      }
      if (!cols[i].accepts(value)) {
        fail('Table ${def.name} : valeur invalide pour « ${cols[i].name} ».');
      }
      row[cols[i].name] = value;
    }
    final key = row[def.primaryKey];
    if (key is String && key.isEmpty) {
      fail('Table ${def.name} : identifiant vide.');
    }
    if (!seen.add(key)) {
      fail('Table ${def.name} : identifiant « $key » en double.');
    }
    if (def.kind == SyncKind.lastWriterWins) {
      final hlc = row[TableDef.hlcColumn];
      final deleted = row[TableDef.deletedColumn];
      if (hlc is! String || !Hlc.isValid(hlc)) {
        fail('Table ${def.name} : date de modification (HLC) invalide.');
      }
      if (deleted != 0 && deleted != 1) {
        fail('Table ${def.name} : marqueur de suppression invalide.');
      }
    }
    out.add(row);
  }
  return out;
}
