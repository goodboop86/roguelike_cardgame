import 'dart:ui';

import 'package:flame/components.dart' hide Timer;
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:roguelike_cardgame/main_game.dart';

import '../providers/sizes.dart';

class GradientBackground extends PositionComponent
    with HasGameReference<MainGame> {
  GradientBackground({required super.position, required this.shader})
      : super(anchor: Anchor.topLeft);

  Shader shader;

  @override
  void render(Canvas canvas) {
    Paint paint = Paint()..shader = shader;
    canvas.drawRect(
        Rect.fromLTWH(0, 0, Sizes.gameWidth, Sizes.gameHeight), paint);
  }
}

class OverlayBackground extends RectangleComponent with TapCallbacks {
  OverlayBackground({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority,
    super.paint,
    super.paintLayers,
    super.key,
  });
  @override
  void onTapDown(TapDownEvent event) {
    print("blocked!!!!");
  } // タッチイベントを消費する
}

class DialogBackground extends RectangleComponent with TapCallbacks {
  DialogBackground({super.position, super.size, super.children, super.anchor})
      : super(
    paint: Paint()..color = Colors.black.withValues(alpha: 0.8),
  );
}
