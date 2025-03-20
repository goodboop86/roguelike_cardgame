import 'package:flame/events.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../providers/player_provider.dart';

class PlayerComponent extends SpriteAnimationComponent with RiverpodComponentMixin, TapCallbacks, HasGameRef {
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // canvas.drawRect(size.toRect(), Paint()..color = Colors.blue);
    final playerState = ref.watch(playerProvider);
    TextPainter(
      text: TextSpan(
          text: playerState.toJsonString(),
          style: const TextStyle(color: Colors.white)),
      textDirection: TextDirection.ltr,
    )
      ..layout(maxWidth: size.x)
      ..paint(canvas, Vector2(0, 0).toOffset());
  }

  @override
  void onTapUp(TapUpEvent event) {
    game.overlays.add('CharacterOverlay');
    game.pauseEngine();
  }
}
