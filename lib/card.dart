import 'dart:convert';
import 'dart:ui';

import 'package:flame/events.dart';
import 'package:flame/components.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';

import 'character_state.dart';

abstract interface class Jsonable {
  Map<String, dynamic> toJson();

  String toJsonString() {
    return jsonEncode(toJson());
  }
}

// カードの効果を定義するクラス
class CardEffect implements Jsonable {
  final int damage;
  final int heal;

  CardEffect({required this.damage, required this.heal});

  @override
  Map<String, dynamic> toJson() {
    return {
      'damage': damage,
      'heal': heal,
    };
  }

  @override
  String toJsonString() {
    return jsonEncode(toJson());
  }
}

// カードの情報を保持するクラス
class Card_ implements Jsonable {
  final String name;
  final CardEffect effect;

  Card_({required this.name, required this.effect});

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'effect': effect.toJson(), // CardEffect の toJson() を呼び出す
    };
  }

  @override
  String toJsonString() {
    return jsonEncode(toJson());
  }
}

class CardComponent extends RectangleComponent
    with TapCallbacks, RiverpodComponentMixin {
  final Card_ card;

  CardComponent({required this.card});

  @override
  void onTapDown(TapDownEvent event) {
    ref.read(playerProvider.notifier).applyCardEffect(card.effect);
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
