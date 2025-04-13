import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class CardAreaComponent extends PositionComponent {
  CardAreaComponent({required Vector2 position, required Vector2 size})
      : super(position: position, size: size);

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

class MapCardAreaComponent extends PositionComponent {
  MapCardAreaComponent({required Vector2 position, required Vector2 size})
      : super(position: position, size: size);
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
