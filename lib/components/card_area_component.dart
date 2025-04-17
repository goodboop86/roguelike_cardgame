import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:roguelike_cardgame/main_game.dart';

import '../models/enum.dart';
import '../providers/sizes.dart';
import '../valueroutes/popup.dart';
import 'basic_component.dart';
import 'button_component.dart';

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

  void disableAllStageExclusive({required ComponentKey key}) {
    // 受け取ったkey以外のコンポーネントをinactiveにする。
    Iterable<ChoiceButtonComponent> buttons =
        children.whereType<ChoiceButtonComponent>();
    for (var button in buttons) {
      if (button.key != key) {
        button.isSelected = false;
      }
    }
  }

  void updateExecuteButton({required bool isSelected}) {
    // stageSelectが1つでもactiveであれば、executeButtonもactiveにする
    // 全て無効ならdisableする。
    Iterable<AdvancedButtonComponent> button =
        children.whereType<AdvancedButtonComponent>();
    final executeButton = button.first;
    if (isSelected) {
      executeButton.isDisabled = false;
    } else {
      Iterable<ChoiceButtonComponent> buttons =
          children.whereType<ChoiceButtonComponent>();
      bool anySelected =
          buttons.map((button) => button.isSelected).any((val) => val == true);
      if (!anySelected) {
        executeButton.isDisabled = true;
      }
    }
  }

  Future<void> pupUp() async {
    Iterable<ChoiceButtonComponent> buttons =
        children.whereType<ChoiceButtonComponent>();
    Event event = buttons.where((button) => button.isSelected).first.value;
    log.info(event);

    final overlay = OverlayComponent()
      ..size = Sizes().gameSize
      ..anchor = Anchor.center
      ..paint.color = Colors.black.withValues(alpha: 0.5)
      ..priority = 20;

    final button = ButtonComponent(
        // position: Vector2(0,0),
        anchor: Anchor.center,
        onReleased: () => {game.router.pushNamed(event.name)},
        button: RectangleComponent(
          size: Vector2(200, 200),
          paint: Paint()..color = Colors.red,
        ),
        children: [
          TextComponent(
            priority: 100,
            text: '$event',
            anchor: Anchor.center,
            position: Vector2(200, 200) / 2,
            textRenderer:
                TextPaint(style: const TextStyle(color: Colors.white)),
          ),
        ]);

    // parent!.add(overlay);
    // parent!.add(button..priority = 40);
    bool value = await game.router.pushAndWait(MyBoolDialogRoute());

    if (value) {
      game.router.pushNamed(event.name);
    }

    // game.router.currentRoute.add(button);
    // game.router.pushNamed(event.name);
  }
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
