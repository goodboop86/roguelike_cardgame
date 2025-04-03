import 'package:flame/events.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../models/enum.dart';
import '../providers/player_provider.dart';

class PlayerComponent extends PositionComponent
    with RiverpodComponentMixin, TapCallbacks, HasGameRef {
  PlayerComponent({required super.key});

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
    game.overlays.add(OVERLAY.characterOverlay.name);
    game.pauseEngine();
  }
}

class PlayerHpBar extends PositionComponent with RiverpodComponentMixin {
  late double _hp;
  late final double _maxHp;

  PlayerHpBar({required hp, required double maxHp}) {
    _hp = hp;
    _maxHp = maxHp;
    size = Vector2(100, 10);
    position = Vector2(0, 0);
    anchor = Anchor.topLeft;
  }

  set hp(double value) {
    _hp = value.clamp(0, _maxHp);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    hp = ref.watch(playerProvider).health;

    // 背景
    canvas.drawRect(
      size.toRect(),
      Paint()..color = Colors.grey,
    );

    // HPバー
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x * (_hp / _maxHp), size.y),
      Paint()..color = Colors.green,
    );
  }
}
