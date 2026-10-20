import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/backup/backup_providers.dart';
import '../../features/backup/backup_service.dart';
import 'transfer_actions.dart';

class BackupsScreen extends ConsumerStatefulWidget {
  const BackupsScreen({super.key});

  @override
  ConsumerState<BackupsScreen> createState() => _BackupsScreenState();
}

class _BackupsScreenState extends ConsumerState<BackupsScreen> {
  late List<BackupInfo> _backups;

  BackupService get _service => ref.read(backupServiceProvider);

  @override
  void initState() {
    super.initState();
    _backups = _service.list();
  }

  void _refresh() => setState(() => _backups = _service.list());

  void _snack(String message) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));

  Future<bool> _confirm(String title, String body, String action) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(action),
          ),
        ],
      ),
    );
    return ok ?? false;
  }

  Future<void> _restore(BackupInfo b) async {
    final ok = await _confirm(
      'Restaurer cette sauvegarde ?',
      'Sauvegarde du ${formatDateTime(b.createdAt)}.\n\n'
          'Votre progression actuelle sera d’abord sauvegardée, puis '
          'remplacée par celle-ci.',
      'Restaurer',
    );
    if (!ok || !mounted) return;
    try {
      _service.restore(b);
      reloadUserState(ref);
      _snack('Sauvegarde restaurée.');
    } catch (e) {
      _snack('La restauration a échoué : $e');
    }
    _refresh();
  }

  Future<void> _delete(BackupInfo b) async {
    final ok = await _confirm(
      'Supprimer cette sauvegarde ?',
      'Sauvegarde du ${formatDateTime(b.createdAt)}. Cette action est '
          'définitive.',
      'Supprimer',
    );
    if (!ok || !mounted) return;
    try {
      _service.delete(b);
    } catch (e) {
      _snack('Suppression impossible : $e');
    }
    _refresh();
  }

  void _create() {
    try {
      _service.create(BackupReason.manual);
      _snack('Sauvegarde créée.');
    } catch (e) {
      _snack('Sauvegarde impossible : $e');
    }
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sauvegardes locales')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _create,
        icon: const Icon(Icons.save),
        label: const Text('Sauvegarder maintenant'),
      ),
      body: _backups.isEmpty
          ? const Center(child: Text('Aucune sauvegarde pour l’instant.'))
          : ListView(
              padding: const EdgeInsets.only(bottom: 96),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Les ${_service.keep} sauvegardes les plus récentes sont '
                    'conservées sur cet appareil. Pour changer d’appareil, '
                    'utilisez plutôt « Exporter ma progression ».',
                  ),
                ),
                for (final b in _backups)
                  ListTile(
                    leading: const Icon(Icons.inventory_2_outlined),
                    title: Text(formatDateTime(b.createdAt)),
                    subtitle: Text(
                      '${b.reason.label} · ${(b.sizeBytes / 1024).ceil()} Ko',
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (v) =>
                          v == 'restore' ? _restore(b) : _delete(b),
                      itemBuilder: (_) => const [
                        PopupMenuItem(
                          value: 'restore',
                          child: Text('Restaurer'),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Text('Supprimer'),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }
}
