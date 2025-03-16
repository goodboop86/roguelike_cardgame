
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'character_state.dart';

class PlayerComponent extends PositionComponent with RiverpodComponentMixin {
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), Paint()..color = Colors.blue);
    final playerState = ref.watch(playerProvider);
    TextPainter(
      text: TextSpan(text: "Player: ${playerState['name']}, health: ${playerState['health']}, mana: ${playerState['mana']}", style: const TextStyle(color: Colors.white)),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.x)
      ..paint(canvas, Vector2(0, 0).toOffset());
  }
}