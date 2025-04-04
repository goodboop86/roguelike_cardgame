import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class OverlayComponent extends RectangleComponent with TapCallbacks {
  @override
  void onTapDown(TapDownEvent event) {
    print("blocked!!!!");
  } // タッチイベントを消費する
}

RectangleComponent darkenOverlay = OverlayComponent()
  ..paint.color = Colors.black.withValues(alpha: 0)
  ..priority = 1000;

TextComponent transitionText = TextComponent(
  priority: 1,
  anchor: Anchor.center,
  textRenderer:
      TextPaint(style: const TextStyle(color: Colors.white, fontSize: 24)),
);

TextComponent buttonText = TextComponent(
  priority: 1,
  anchor: Anchor.center,
  textRenderer: TextPaint(style: const TextStyle(color: Colors.white)),
);
