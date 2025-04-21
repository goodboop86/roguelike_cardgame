import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:roguelike_cardgame/main_game.dart';


class CardAreaComponent extends RectangleComponent with HasGameRef<MainGame> {
  CardAreaComponent({required Vector2 position, required Vector2 size})
      : super(position: position, size: size) {
    super.paint = Paint()..color = Colors.black.withValues(alpha: 0.6);
  }

  bool locked = true;

  Logger log = Logger('CardAreaComponent');

  void lock() {
    locked = true;
  }

  void unlock() {
    locked = false;
  }

  @override
  void onMount() {
    log.info("mounted");
    unlock();
  }

  @override
  void onRemove() {
    log.info("removed");
  }
}

class MapCardAreaComponent extends PositionComponent with HasGameRef<MainGame> {
  MapCardAreaComponent(
      {required Vector2 super.position,
      required Vector2 super.size,
      required super.anchor})
      : super();

  Logger log = Logger('MapCardAreaComponent');
}

class CharacterAreaComponent extends PositionComponent {
  CharacterAreaComponent(
      {required Vector2 position,
      required Vector2 size,
      required ComponentKey key})
      : super(position: position, size: size, key: key, priority: 20);

  final Paint paint = Paint()..color = Colors.transparent;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), paint);
  }

  void changeColor(Color color) {
    paint.color = color;
  }

// カードエリアの描画やその他の処理
}

class ButtonAreaComponent extends PositionComponent {
  ButtonAreaComponent({required Vector2 position, required Vector2 size})
      : super(position: position, size: size);

// カードエリアの描画やその他の処理
}

class MapAreaComponent extends PositionComponent {
  MapAreaComponent({required Vector2 position, required Vector2 size})
      : super(position: position, size: size);

// カードエリアの描画やその他の処理
}

class UiAreaComponent extends PositionComponent {
  UiAreaComponent({required Vector2 position, required Vector2 size})
      : super(position: position, size: size);

// カードエリアの描画やその他の処理
}

class NPCDialogAreaComponent extends PositionComponent {
  NPCDialogAreaComponent({required Vector2 position, required Vector2 size})
      : super(position: position, size: size);

// カードエリアの描画やその他の処理
}
