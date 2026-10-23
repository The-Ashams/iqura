/// Éléments d'interface du jeu en pixel art (cahier v3 §8.1) : fenêtres à
/// bord blanc des RPG japonais classiques, images agrandies sans lissage,
/// scènes en grille de 160 × 90.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../engines/audio/audio_service.dart';
import '../widgets/arabic_text.dart';

abstract final class GameColors {
  static const window = Color(0xF0101422);
  static const windowBorder = Color(0xFFF4F1E8);
  static const text = Color(0xFFF4F1E8);
  static const muted = Color(0xFFB9B4C8);
  static const accent = Color(0xFFF2C45A);
  static const good = Color(0xFF6FCF7A);
  static const bad = Color(0xFFE0805A);
  static const night = Color(0xFF14121F);
}

/// Taille d'une scène en pixels d'origine.
const double sceneWidth = 160;
const double sceneHeight = 90;

/// Image pixel art de `assets/art/`, agrandie sans lissage.
class PixelImage extends StatelessWidget {
  const PixelImage(this.name, {super.key, this.fit = BoxFit.contain});

  final String name;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) => Image.asset(
    'assets/art/$name.png',
    filterQuality: FilterQuality.none,
    isAntiAlias: false,
    fit: fit,
    excludeFromSemantics: true,
  );
}

/// Élément placé dans une scène, en pixels d'origine.
class ScenePart {
  const ScenePart({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.child,
  });

  final double x;
  final double y;
  final double width;
  final double height;
  final Widget child;
}

/// Scène 16:9 : une image de fond et des éléments placés dans la grille
/// 160 × 90, le tout agrandi à la taille disponible.
class SceneView extends StatelessWidget {
  const SceneView({super.key, required this.background, this.parts = const []});

  final String background;
  final List<ScenePart> parts;

  @override
  Widget build(BuildContext context) => AspectRatio(
    aspectRatio: sceneWidth / sceneHeight,
    child: LayoutBuilder(
      builder: (context, c) {
        final k = c.maxWidth / sceneWidth;
        return Stack(
          children: [
            Positioned.fill(child: PixelImage(background, fit: BoxFit.fill)),
            for (final p in parts)
              Positioned(
                left: p.x * k,
                top: p.y * k,
                width: p.width * k,
                height: p.height * k,
                child: p.child,
              ),
          ],
        );
      },
    ),
  );
}

/// Fenêtre de jeu : fond sombre, bord blanc.
class PixelWindow extends StatelessWidget {
  const PixelWindow({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: GameColors.window,
      border: Border.all(color: GameColors.windowBorder, width: 3),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Padding(
      padding: padding,
      child: DefaultTextStyle.merge(
        style: const TextStyle(color: GameColors.text, fontSize: 18),
        child: child,
      ),
    ),
  );
}

/// Commande de menu : « ▶ » devant l'élément survolé ou sélectionné au
/// clavier, comme dans les RPG classiques.
class PixelCommand extends StatefulWidget {
  const PixelCommand({
    super.key,
    required this.label,
    required this.onPressed,
    this.detail,
  });

  final String label;

  /// Explication courte (par exemple la raison d'une commande indisponible).
  final String? detail;

  /// Nul : commande indisponible, affichée grisée avec sa raison.
  final VoidCallback? onPressed;

  @override
  State<PixelCommand> createState() => _PixelCommandState();
}

class _PixelCommandState extends State<PixelCommand> {
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null;
    final color = enabled ? GameColors.text : GameColors.muted;
    return Semantics(
      button: true,
      enabled: enabled,
      label: widget.detail == null
          ? widget.label
          : '${widget.label}. ${widget.detail}',
      excludeSemantics: true,
      child: InkWell(
        onTap: widget.onPressed,
        onHover: (v) => setState(() => _active = v),
        onFocusChange: (v) => setState(() => _active = v),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 44),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: Row(
              children: [
                SizedBox(
                  width: 22,
                  child: _active && enabled ? const MenuCursor() : null,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.label,
                        style: TextStyle(color: color, fontSize: 18),
                      ),
                      if (widget.detail != null)
                        Text(
                          widget.detail!,
                          style: const TextStyle(
                            color: GameColors.muted,
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Curseur « ▶ » des menus (la police pixel n'a pas ce symbole).
class MenuCursor extends StatelessWidget {
  const MenuCursor({super.key});

  @override
  Widget build(BuildContext context) =>
      const Icon(Icons.play_arrow, size: 18, color: GameColors.accent);
}

/// Mention « Rédigé par IA » dans le style du jeu.
class AiTag extends StatelessWidget {
  const AiTag({super.key});

  static const String label = 'Rédigé par IA';

  @override
  Widget build(BuildContext context) => const Text(
    label,
    style: TextStyle(color: GameColors.muted, fontSize: 13),
  );
}

/// Texte arabe d'une leçon que l'on touche pour l'entendre. La mention
/// « synthèse » accompagne toujours le son.
class SpokenArabic extends ConsumerWidget {
  const SpokenArabic(
    this.text, {
    super.key,
    this.size = 34,
    this.color = GameColors.text,
  });

  final String text;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final file = ref.watch(contentDatabaseProvider).audioFile(text);
    final word = ArabicText(
      text,
      baseSize: size,
      style: TextStyle(color: color),
    );
    if (file == null) return word;
    return Semantics(
      button: true,
      label: 'Écouter (voix de synthèse)',
      child: InkWell(
        onTap: () => ref.read(audioServiceProvider).playAsset(file),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            word,
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.volume_up, size: 14, color: GameColors.muted),
                SizedBox(width: 4),
                Text(
                  'synthèse',
                  style: TextStyle(color: GameColors.muted, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Largeur maximale du contenu du jeu : sur un grand écran (PC), le contenu
/// est centré au lieu de s'étirer, et la scène ne remplit plus la fenêtre.
const double gameMaxWidth = 760;

/// Corps d'un écran du jeu : centré, largeur limitée à [gameMaxWidth].
class GameBody extends StatelessWidget {
  const GameBody({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.topCenter,
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: gameMaxWidth),
      child: child,
    ),
  );
}

/// Scène de combat 16:9, haute d'au plus un tiers de la fenêtre, pour que
/// la question reste visible sans défiler.
class CombatSceneBox extends StatelessWidget {
  const CombatSceneBox({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.sizeOf(context).height * 0.36;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: child,
          ),
        ),
      ),
    );
  }
}
