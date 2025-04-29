import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:roguelike_cardgame/main_game.dart';

import '../providers/sizes.dart';

class CardAreaComponent extends RectangleComponent with HasGameRef<MainGame> {
  CardAreaComponent()
      : super(
            position: Sizes.cardAreaPosition,
            size: Sizes.cardAreaSize,
            paint: Paint()..color = Colors.black.withValues(alpha: 0.3));

  Logger log = Logger('CardAreaComponent');
}

class MapCardAreaComponent extends RectangleComponent
    with HasGameRef<MainGame> {
  MapCardAreaComponent()
      : super(
            position: Sizes.mapCardAreaPosition,
            size: Sizes.mapCardAreaSize,
            anchor: Anchor.topLeft,
            paint: Paint()..color = Colors.black.withValues(alpha: 0.0));

  Logger log = Logger('MapCardAreaComponent');
}

class CharacterAreaComponent extends RectangleComponent {
  CharacterAreaComponent({required super.key})
      : super(
            position: Sizes.characterAreaPosition,
            size: Sizes.characterAreaSize,
      paint:  Paint()..color = Colors.transparent,
            priority: 20);


  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), paint);
  }

  void changeColor(Color color) {
    paint.color = color;
  }
}

class ButtonAreaComponent extends RectangleComponent {
  ButtonAreaComponent()
      : super(
            position: Sizes.buttonAreaPosition,
            size: Sizes.buttonAreaSize,
            paint: Paint()..color = Colors.black.withValues(alpha: 0.0));
// カードエリアの描画やその他の処理
}

class MapAreaComponent extends RectangleComponent {
  MapAreaComponent()
      : super(
            position: Sizes.mapAreaPosition,
            size: Sizes.mapAreaSize,
            paint: Paint()..color = Colors.black.withValues(alpha: 0.0));
}

class TopUiAreaComponent extends RectangleComponent {
  TopUiAreaComponent()
      : super(
            position: Sizes.topUiAreaPosition,
            size: Sizes.topUiAreaSize,
            paint: Paint()..color = Colors.black.withValues(alpha: 0.0));
}

class BottomUiAreaComponent extends RectangleComponent {
  BottomUiAreaComponent()
      : super(
            position: Sizes.bottomUiAreaPosition,
            size: Sizes.bottomUiAreaSize,
            paint: Paint()..color = Colors.black.withValues(alpha: 0.0));
}

class NPCDialogAreaComponent extends RectangleComponent {
  NPCDialogAreaComponent({required Vector2 position, required Vector2 size})
      : super(
            position: position,
            size: size,
            paint: Paint()..color = Colors.black.withValues(alpha: 0.0));
}
