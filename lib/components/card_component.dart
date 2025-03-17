import 'package:flame/events.dart';
import 'package:flame/components.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';

import '../main_game.dart';
import '../models/card.dart';
import '../models/player_state.dart';
import '../providers/player_provider.dart';

class CardComponent extends RectangleComponent
    with TapCallbacks, RiverpodComponentMixin, HasGameRef {
  final Card_ card;

  CardComponent({required this.card});

  @override
  void onTapDown(TapDownEvent event) {
    ref.read(playerProvider.notifier).applyCardEffect(card.effect);
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
          text: card.toJsonString(),
          style: const TextStyle(color: Colors.white)),
      textDirection: TextDirection.ltr,
    )
      ..layout(maxWidth: size.x)
      ..paint(canvas, Vector2(0, 0).toOffset());
  }
}

// class CardInfoOverlay extends PositionComponent with TapCallbacks {
//   final Map<String, dynamic> cardData;
//
//   CardInfoOverlay({required this.cardData})
//       : super(
//     position: Vector2.all(50),
//     size: Vector2(300, 200),
//   );
//
//   @override
//   void render(Canvas canvas) {
//     super.render(canvas);
//     canvas.drawRect(size.toRect(), Paint()..color = Colors.black.withOpacity(0.8));
//     TextPainter(
//       text: TextSpan(text: JsonEncoder.withIndent('  ').convert(cardData), style: TextStyle(color: Colors.white)),
//       textDirection: TextDirection.ltr,
//     )..layout(maxWidth: size.x)
//       ..paint(canvas, Vector2.all(10).toOffset());
//   }
//
//   @override
//   void onTapDown(TapDownEvent event) {
//     game.overlays.remove('cardInfo'); // オーバーレイを削除
//   }
// }
