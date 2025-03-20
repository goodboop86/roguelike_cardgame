import 'package:flame/events.dart';
import 'package:flame/components.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:roguelike_cardgame/providers/enemy_provider.dart';

import '../main_game.dart';
import '../models/card.dart';
import '../models/player_state.dart';
import '../providers/player_provider.dart';

class CardComponent extends RectangleComponent
    with TapCallbacks, RiverpodComponentMixin, HasGameRef {
  final Card_ card;

  CardComponent({required this.card});

  @override
  void onTapUp(TapUpEvent event) {
    game.overlays.add('myOverlay');
    game.pauseEngine();

  }

  @override
  void onLongTapDown(TapDownEvent event) {
    card.effect.effectFunction(ref);

    // カードを削除
    removeFromParent();
    // 残りのカードを再配置
    (gameRef as MainGame).rearrangeCards();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), Paint()..color = Colors.green);
    TextPainter(
      text: TextSpan(
          text: card.name, style: const TextStyle(color: Colors.white)),
      textDirection: TextDirection.ltr,
    )
      ..layout(maxWidth: size.x)
      ..paint(canvas, Vector2(0, 0).toOffset());
  }
}

