import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart' hide Gradient;

import '../providers/sizes.dart';
import 'background_component.dart';

TextComponent transitionText = TextComponent(
  priority: 1,
  anchor: Anchor.center,
  textRenderer:
      TextPaint(style: const TextStyle(color: Colors.white, fontSize: 24)),
);

