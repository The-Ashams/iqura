/// « Signaler une erreur » (cahier v3 §3.2, décision du 22/10/2026) : le
/// joueur décrit l'erreur, le signalement est gardé sur l'appareil, puis il
/// peut l'envoyer depuis sa messagerie (mail prérempli). Rien n'est envoyé
/// sans son action.
library;

import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/app_info.dart';
import '../../core/providers.dart';

/// Adresse de réception des signalements, choisie par l'utilisateur.
const String errorReportAddress = 'contact@edelwa.com';

class ErrorReport {
  const ErrorReport({
    required this.subject,
    required this.description,
    required this.contentVersion,
    required this.createdAt,
  });

  /// Ce qui est signalé (par exemple « Fiche de la lettre ب »).
  final String subject;
  final String description;
  final String contentVersion;
  final DateTime createdAt;

  Map<String, Object> toJson() => {
    'sujet': subject,
    'description': description,
    'version_contenu': contentVersion,
    'version_app': appVersion,
    'date': createdAt.toUtc().toIso8601String(),
  };

  /// Mail prérempli à ouvrir dans la messagerie du joueur.
  Uri mailto() => Uri(
    scheme: 'mailto',
    path: errorReportAddress,
    query: _encodeQuery({
      'subject': 'IQURA — signalement : $subject',
      'body':
          '$description\n\n'
          '---\n'
          'Concerne : $subject\n'
          'Version de l\'application : $appVersion\n'
          'Version du contenu : $contentVersion\n'
          'Date : ${createdAt.toUtc().toIso8601String()}',
    }),
  );

  // Uri(queryParameters:) encode les espaces en « + », mal compris par
  // certaines messageries : on encode en %20.
  static String _encodeQuery(Map<String, String> params) => params.entries
      .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

/// Signalements enregistrés dans un fichier de l'appareil, un par ligne.
class ErrorReportStore {
  const ErrorReportStore(this.path);

  final String path;

  Future<void> save(ErrorReport report) async {
    await File(path).writeAsString(
      '${jsonEncode(report.toJson())}\n',
      mode: FileMode.append,
      flush: true,
    );
  }

  List<Map<String, dynamic>> all() {
    final f = File(path);
    if (!f.existsSync()) return const [];
    return [
      for (final line in f.readAsLinesSync())
        if (line.trim().isNotEmpty) jsonDecode(line) as Map<String, dynamic>,
    ];
  }
}

final errorReportStoreProvider = Provider<ErrorReportStore>(
  (ref) => ErrorReportStore(ref.watch(appPathsProvider).errorReports),
);
