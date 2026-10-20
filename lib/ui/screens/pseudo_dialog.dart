import 'package:flutter/material.dart';

import '../../features/profile/profile.dart';

/// Demande un pseudo. Retourne `null` si l'utilisateur annule.
Future<String?> showPseudoDialog(BuildContext context, {String initial = ''}) {
  return showDialog<String>(
    context: context,
    builder: (_) => _PseudoDialog(initial: initial),
  );
}

class _PseudoDialog extends StatefulWidget {
  const _PseudoDialog({required this.initial});
  final String initial;

  @override
  State<_PseudoDialog> createState() => _PseudoDialogState();
}

class _PseudoDialogState extends State<_PseudoDialog> {
  late final _controller = TextEditingController(text: widget.initial);
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final error = PseudoRules.validate(_controller.text);
    if (error != null) {
      setState(() => _error = error);
      return;
    }
    Navigator.pop(context, _controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pseudo'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        maxLength: PseudoRules.maxLength,
        decoration: InputDecoration(errorText: _error),
        onSubmitted: (_) => _submit(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),
        FilledButton(onPressed: _submit, child: const Text('Enregistrer')),
      ],
    );
  }
}
