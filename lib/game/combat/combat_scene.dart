/// Scène de combat dessinée avec Flame : fond, héros et brume d'oubli, en
/// pixels d'origine (160 × 90) agrandis sans lissage. Aucun texte n'est
/// dessiné dans la scène : les questions sont dans un panneau Flutter séparé
/// et neutre (cahier v3 §3.1).
library;

import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flutter/animation.dart';

class CombatScene extends FlameGame {
  CombatScene({required this.animations, this.boss = false, this.region = 1})
    : super(
        camera: CameraComponent.withFixedResolution(width: 160, height: 90),
      );

  /// Animations désactivées dans les réglages : aucun effet.
  final bool animations;

  /// Boss de région : le Gardien de l'Oubli (région 1) ou le Grand Mirage
  /// (région 2) au lieu d'une brume ou d'un mirage.
  final bool boss;

  /// Région : 1, brumes d'oubli dans la Faille ; 2, mirages de la
  /// Confusion dans les Sables du mirage.
  final int region;

  // Nuls tant que la scène charge : un coup reçu avant ne fait rien.
  SpriteComponent? _hero;
  SpriteComponent? _foe;

  static Paint _pixelPaint() => Paint()..filterQuality = FilterQuality.none;

  @override
  Future<void> onLoad() async {
    images.prefix = 'assets/art/';
    camera.viewfinder.anchor = Anchor.topLeft;
    world.add(
      SpriteComponent(
        sprite: await loadSprite(
          region == 2 ? 'scene_mirage.png' : 'scene_faille.png',
        ),
        size: Vector2(160, 90),
        paint: _pixelPaint(),
      ),
    );
    final hero = SpriteComponent(
      sprite: await loadSprite('voyageur_combat.png'),
      position: Vector2(20, 30),
      size: Vector2(17, 32),
      paint: _pixelPaint(),
    );
    final foe = SpriteComponent(
      sprite: await loadSprite(
        boss
            ? (region == 2 ? 'grand_mirage.png' : 'gardien.png')
            : region == 2
            ? 'mirage.png'
            : 'brume.png',
      ),
      position: boss
          ? (region == 2 ? Vector2(88, 4) : Vector2(96, 8))
          : Vector2(98, 14),
      size: boss
          ? (region == 2 ? Vector2(64, 66) : Vector2(48, 56))
          : Vector2(43, 46),
      paint: _pixelPaint(),
    );
    world
      ..add(hero)
      ..add(foe);
    _hero = hero;
    _foe = foe;
    if (animations) {
      foe.add(
        MoveEffect.by(
          Vector2(0, -3),
          EffectController(
            duration: 1.2,
            reverseDuration: 1.2,
            infinite: true,
            curve: Curves.easeInOut,
          ),
        ),
      );
    }
  }

  void foeHit() => _flash(_foe);

  void heroHit() => _flash(_hero);

  void _flash(SpriteComponent? target) {
    if (!animations || target == null) return;
    target.add(
      OpacityEffect.to(
        0.2,
        EffectController(duration: 0.08, reverseDuration: 0.08, repeatCount: 2),
      ),
    );
  }
}
