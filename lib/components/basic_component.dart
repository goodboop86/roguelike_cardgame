import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart' hide Gradient;

import '../providers/sizes.dart';
import 'background_component.dart';

class OverlayComponent extends RectangleComponent with TapCallbacks {
  OverlayComponent({
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
  }) {}
  @override
  void onTapDown(TapDownEvent event) {
    print("blocked!!!!");
  } // タッチイベントを消費する
}

RectangleComponent darkenOverlay = OverlayComponent()
  ..size = Sizes.gameSize
  ..anchor = Anchor.center
  ..paint.color = Colors.black.withValues(alpha: 0.5)
  ..priority = 1000;

TextComponent transitionText = TextComponent(
  priority: 1,
  anchor: Anchor.center,
  textRenderer:
      TextPaint(style: const TextStyle(color: Colors.white, fontSize: 24)),
);

GradientBackground topGradient = GradientBackground(
    position: Sizes.gameTopLeft,
    shader: Gradient.linear(
      Offset(Sizes.gameWidth / 2, 0),
      Offset(Sizes.gameWidth / 2, Sizes.blockLength),
      [
        Colors.black,
        Colors.transparent,
      ],
    ));

GradientBackground bottomGradient = GradientBackground(
  position: Sizes.bottomGradientPosition,
  shader: Gradient.linear(
    Offset(Sizes.gameWidth / 2, 0),
    Offset(Sizes.gameWidth / 2, Sizes.blockLength),
    [
      Colors.transparent,
      Colors.black,
    ],
  ),
);
