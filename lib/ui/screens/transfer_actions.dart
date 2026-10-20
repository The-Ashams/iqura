/// Parcours d'export et d'import de la progression (boîtes de dialogue).
library;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../engines/sync/export_archive.dart';
import '../../features/backup/backup_providers.dart';
import '../../features/profile/profile.dart';
import '../../features/settings/settings.dart';
import '../../features/transfer/transfer_service.dart';

void _snack(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

String formatDateTime(DateTime t) {
  final l = t.toLocal();
  String two(int v) => v.toString().padLeft(2, '0');
  return '${two(l.day)}/${two(l.month)}/${l.year} à ${two(l.hour)}h${two(l.minute)}';
}

/// Relit tout ce qui vient de la base après un import ou une restauration.
void reloadUserState(WidgetRef ref) {
  ref.invalidate(settingsProvider);
  ref.invalidate(profileProvider);
}

Future<void> exportProgress(BuildContext context, WidgetRef ref) async {
  final service = ref.read(transferServiceProvider);
  try {
    final bytes = service.buildExport();
    final uri = await FilePicker.saveFile(
      dialogTitle: 'Exporter ma progression',
      fileName: service.suggestedFileName(),
      bytes: bytes,
      mimeType: 'application/zip',
      type: FileType.custom,
      allowedExtensions: const ['zip'],
    );
    if (!context.mounted || uri == null) return;
    _snack(context, 'Progression exportée.');
  } catch (e) {
    if (!context.mounted) return;
    _snack(context, "L'export a échoué : $e");
  }
}

/// Retourne vrai si un import a été appliqué.
Future<bool> importProgress(BuildContext context, WidgetRef ref) async {
  final service = ref.read(transferServiceProvider);
  final List<PlatformFile> files;
  try {
    files = await FilePicker.pickFiles(
      dialogTitle: 'Importer une progression',
      type: FileType.custom,
      allowedExtensions: const ['zip'],
    );
  } catch (e) {
    if (context.mounted) _snack(context, "Impossible d'ouvrir le fichier : $e");
    return false;
  }
  if (files.isEmpty || !context.mounted) return false;

  final ExportData data;
  try {
    final size = await files.first.length();
    if (size != null && size > const ArchiveLimits().maxArchiveBytes) {
      throw const ExportArchiveException(
        'Fichier trop volumineux pour être une sauvegarde IQURA.',
      );
    }
    data = service.read(await files.first.readAsBytes());
  } on ExportArchiveException catch (e) {
    if (context.mounted) {
      await _showMessage(context, 'Import impossible', e.message);
    }
    return false;
  } catch (e) {
    if (context.mounted) {
      await _showMessage(
        context,
        'Import impossible',
        'Lecture du fichier : $e',
      );
    }
    return false;
  }
  if (!context.mounted) return false;

  final ownDevice =
      data.manifest.deviceId == ref.read(userDatabaseProvider).deviceId;
  final mode = await showDialog<ImportMode>(
    context: context,
    builder: (_) => _ImportDialog(data: data, fromThisDevice: ownDevice),
  );
  if (mode == null || !context.mounted) return false;

  try {
    final result = service.apply(data, mode);
    reloadUserState(ref);
    if (!context.mounted) return true;
    final report = result.report;
    final summary = switch (mode) {
      ImportMode.replace => 'Progression remplacée par celle de l’archive.',
      ImportMode.merge =>
        'Fusion terminée : ${report!.inserted} élément(s) '
            'ajouté(s), ${report.replaced} mis à jour, ${report.kept} '
            'conservé(s) tels quels.',
    };
    await _showMessage(
      context,
      'Import réussi',
      '$summary\n\nVotre progression précédente a été sauvegardée '
          '(${result.backup.fileName}). Vous pouvez la restaurer depuis '
          '« Sauvegardes locales ».',
    );
    return true;
  } catch (e) {
    if (context.mounted) {
      await _showMessage(
        context,
        "L'import a échoué",
        'Aucune modification n’a été appliquée. Détail : $e',
      );
    }
    return false;
  }
}

Future<void> _showMessage(BuildContext context, String title, String body) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(child: Text(body)),
      actions: [
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

class _ImportDialog extends StatefulWidget {
  const _ImportDialog({required this.data, required this.fromThisDevice});

  final ExportData data;
  final bool fromThisDevice;

  @override
  State<_ImportDialog> createState() => _ImportDialogState();
}

class _ImportDialogState extends State<_ImportDialog> {
  ImportMode _mode = ImportMode.merge;

  @override
  Widget build(BuildContext context) {
    final m = widget.data.manifest;
    final tables = widget.data.tables;
    final profileRows = tables['profile'] ?? const [];
    final pseudo = profileRows
        .where((r) => r['deleted'] == 0)
        .map((r) => r['pseudo'])
        .firstOrNull;
    return AlertDialog(
      title: const Text('Importer cette progression ?'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Profil : ${pseudo ?? 'aucun'}'),
            Text('Exportée le ${formatDateTime(m.createdAt)}'),
            Text('Version d’IQURA : ${m.appVersion}'),
            Text('Éléments : ${widget.data.rowCount}'),
            if (widget.fromThisDevice)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text('Cette archive a été créée sur cet appareil.'),
              ),
            const SizedBox(height: 16),
            RadioGroup<ImportMode>(
              groupValue: _mode,
              onChanged: (v) => setState(() => _mode = v ?? _mode),
              child: const Column(
                children: [
                  RadioListTile<ImportMode>(
                    value: ImportMode.merge,
                    title: Text('Fusionner (recommandé)'),
                    subtitle: Text(
                      'Garde la version la plus récente de chaque élément et '
                      'réunit les historiques des deux appareils.',
                    ),
                  ),
                  RadioListTile<ImportMode>(
                    value: ImportMode.replace,
                    title: Text('Restauration complète'),
                    subtitle: Text(
                      'Remplace toute la progression de cet appareil par '
                      'celle de l’archive.',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Votre progression actuelle sera sauvegardée automatiquement '
              'avant l’import.',
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, _mode),
          child: const Text('Importer'),
        ),
      ],
    );
  }
}
