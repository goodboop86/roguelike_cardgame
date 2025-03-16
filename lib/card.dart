import 'dart:ui';

import 'package:flame/events.dart';
import 'package:flame/components.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';

import 'character_state.dart';


class CardComponent extends RectangleComponent with TapCallbacks, RiverpodComponentMixin {
  String name;
  int damage;
  int heal;

  @override
  void onTapDown(TapDownEvent event) {
    ref.read(playerProvider.notifier).takeDamage(damage);
    ref.read(playerProvider.notifier).healDamage(heal);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), Paint()..color = Colors.green);
    TextPainter(
      text: TextSpan(text: "$name\nDamage: $damage\nHeal: $heal", style: const TextStyle(color: Colors.white)),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.x)
      ..paint(canvas, Vector2(0, 0).toOffset());
  }

  CardComponent(this.name, this.damage, this.heal);
}