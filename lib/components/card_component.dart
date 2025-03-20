import 'package:flame/events.dart';
import 'package:flame/components.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import '../models/card.dart';
import '../pages/battle.dart';
import '../providers/card_provider.dart';

class CardComponent extends RectangleComponent
    with TapCallbacks, RiverpodComponentMixin, HasGameRef {
  final Card_ card;
  bool isDragging = false;

  CardComponent({required this.card});

  @override
  void onTapUp(TapUpEvent event) {
    ref.read(cardProvider.notifier).setCard(card);
    game.overlays.add('CardOverlay');
    game.pauseEngine();
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    card.effect.effectFunction(ref);

    // カードを削除
    removeFromParent();
    // 残りのカードを再配置
    BattlePage battlePage = findParent<BattlePage>() as BattlePage;
    battlePage.rearrangeCards();
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
