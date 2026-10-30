import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/profile/profile.dart';
import 'transfer_actions.dart';

/// Premier lancement : création du profil, ou import d'une progression
/// venue d'un autre appareil.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _start() {
    final error = PseudoRules.validate(_controller.text);
    if (error != null) {
      setState(() => _error = error);
      return;
    }
    ref.read(profileProvider.notifier).save(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'IQURA',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displaySmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Apprendre l’arabe classique, la langue du Coran.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: _controller,
                    autofocus: true,
                    maxLength: PseudoRules.maxLength,
                    decoration: InputDecoration(
                      labelText: 'Choisissez un pseudo',
                      errorText: _error,
                      border: const OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _start(),
                  ),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: _start,
                    child: const Text('Commencer'),
                  ),
                  const SizedBox(height: 24),
                  TextButton.icon(
                    icon: const Icon(Icons.download),
                    label: const Text('J’ai déjà une progression : l’importer'),
                    onPressed: () => importProgress(context, ref),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
