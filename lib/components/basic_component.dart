import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

RectangleComponent darkenOverlay = RectangleComponent(
  paint: Paint()..color = Colors.black.withValues(alpha: 0),
  priority: 1000,
);

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
