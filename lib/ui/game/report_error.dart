import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/providers.dart';
import '../../features/reports/error_report.dart';
import 'pixel.dart';

/// Bouton « Signaler une erreur » présent sur chaque fiche.
class ReportErrorButton extends ConsumerWidget {
  const ReportErrorButton({super.key, required this.subject});

  /// Ce qui est signalé, repris dans le mail (« Fiche de la lettre ب »).
  final String subject;

  @override
  Widget build(BuildContext context, WidgetRef ref) => TextButton.icon(
    style: TextButton.styleFrom(foregroundColor: GameColors.accent),
    onPressed: () => showDialog<void>(
      context: context,
      builder: (_) => _ReportDialog(subject: subject),
    ),
    icon: const Icon(Icons.flag_outlined),
    label: const Text('Signaler une erreur'),
  );
}

class _ReportDialog extends ConsumerStatefulWidget {
  const _ReportDialog({required this.subject});

  final String subject;

  @override
  ConsumerState<_ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends ConsumerState<_ReportDialog> {
  final _controller = TextEditingController();
  ErrorReport? _saved;
  String? _message;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    final report = ErrorReport(
      subject: widget.subject,
      description: text,
      contentVersion: ref.read(contentDatabaseProvider).contentVersion,
      createdAt: DateTime.now(),
    );
    await ref.read(errorReportStoreProvider).save(report);
    setState(() {
      _saved = report;
      _message = 'Signalement enregistré sur cet appareil.';
    });
  }

  Future<void> _send() async {
    final ok = await launchUrl(_saved!.mailto());
    if (!ok && mounted) {
      setState(
        () => _message =
            'Aucune messagerie trouvée. Le signalement reste enregistré sur '
            "l'appareil ; vous pouvez écrire à $errorReportAddress.",
      );
    }
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Signaler une erreur'),
    content: SizedBox(
      width: 420,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Concerne : ${widget.subject}'),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            enabled: _saved == null,
            minLines: 3,
            maxLines: 6,
            decoration: const InputDecoration(
              labelText: "Qu'est-ce qui ne va pas ?",
              border: OutlineInputBorder(),
            ),
          ),
          if (_message != null) ...[
            const SizedBox(height: 12),
            Text(_message!),
          ],
          const SizedBox(height: 8),
          Text(
            "Rien n'est envoyé sans votre action. L'envoi ouvre votre "
            'messagerie avec un mail prérempli pour $errorReportAddress.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(_saved == null ? 'Annuler' : 'Fermer'),
      ),
      if (_saved == null)
        FilledButton(onPressed: _save, child: const Text('Enregistrer'))
      else
        FilledButton.icon(
          onPressed: _send,
          icon: const Icon(Icons.mail_outline),
          label: const Text('Envoyer par mail'),
        ),
    ],
  );
}
