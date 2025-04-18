import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:roguelike_cardgame/main_game.dart';

import '../models/enum.dart';
import '../providers/sizes.dart';
import '../valueroutes/popup.dart';

class BasicButtonComponent extends ButtonComponent {
  final String text;
  final VoidCallback? func;

  BasicButtonComponent(
      {required this.text,
      this.func,
      // super.button,
      super.buttonDown,
      // super.onPressed,
      super.onReleased,
      super.onCancelled,
      super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      // super.children,
      super.priority})
      : super(
          button: RectangleComponent(
            size: Sizes.buttonSize,
            paint: Paint()..color = Colors.brown,
            priority: 0,
          ),
          children: [
            TextComponent(
              priority: 1,
              text: text,
              position: Sizes.buttonSize / 2,
              anchor: Anchor.center,
              textRenderer:
                  TextPaint(style: const TextStyle(color: Colors.white)),
            ),
          ],
          onPressed: func,
        );

  @override
  Future<void> onLoad() async {
    // 必要であれば、ボタン固有のアセットロードや初期化処理をここで行う
    // 例: ボタンの画像スプライトをロードするなど
    await super.onLoad();
  }
}

class UIButtonComponent extends SpriteButtonComponent {
  UIButtonComponent({
    super.button,
    super.buttonDown,
    super.onPressed,
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority,
  }) : super();

  @override
  Future<void> onLoad() async {
    // 必要であれば、ボタン固有のアセットロードや初期化処理をここで行う
    // 例: ボタンの画像スプライトをロードするなど
    await super.onLoad();
  }
}

class DialogButtonComponent extends ButtonComponent {
  final String text;
  final VoidCallback? func;

  DialogButtonComponent(
      {required this.text,
      this.func,
      // super.button,
      super.buttonDown,
      // super.onPressed,
      super.onReleased,
      super.onCancelled,
      super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      // super.children,
      required paint,
      super.priority})
      : super(
          button: RectangleComponent(
            size: Sizes.dialogButtonSize,
            paint: paint,
            priority: 0,
          ),
          children: [
            TextComponent(
              priority: 1,
              text: text,
              position: Sizes.dialogButtonSize / 2,
              anchor: Anchor.center,
              textRenderer:
                  TextPaint(style: const TextStyle(color: Colors.white)),
            ),
          ],
          onPressed: func,
        );

  @override
  Future<void> onLoad() async {
    // 必要であれば、ボタン固有のアセットロードや初期化処理をここで行う
    // 例: ボタンの画像スプライトをロードするなど
    await super.onLoad();
  }
}

class OptionButtonComponent extends ButtonComponent {
  final String text;
  final VoidCallback? func;

  OptionButtonComponent({required this.text, this.func})
      : super(
          priority: 20,
          button: RectangleComponent(
              size: Sizes.buttonSize,
              paint: Paint()..color = Colors.brown,
              priority: 0),
          onPressed: func,
          anchor: Anchor.center,
          children: [
            TextComponent(
              priority: 1,
              text: text,
              position: Sizes.buttonSize / 2,
              anchor: Anchor.center,
              textRenderer:
                  TextPaint(style: const TextStyle(color: Colors.white)),
            ),
          ],
        );
}

class ChoiceButtonComponent extends RectangleComponent
    with TapCallbacks, HasGameRef<MainGame> {
  ChoiceButtonComponent({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority,
    super.paint,
    super.paintLayers,
    super.key,
    required this.value,
  });
  Event value;

  @override
  Future<void> onTapUp(TapUpEvent event) async {
    bool isYes = await game.router.pushAndWait(MyBoolDialogRoute());

    if (isYes) {
      game.routeWithFadeOut(message: '', event: value);
    }
    super.onTapUp(event);
  }
}

class ExecuteButtonComponent<T> extends AdvancedButtonComponent {
  ExecuteButtonComponent(
      {super.onPressed,
      super.onChangeState,
      super.defaultSkin,
      super.downSkin,
      super.disabledSkin,
      super.defaultLabel,
      super.disabledLabel,
      super.size,
      super.position,
      super.scale,
      super.angle,
      super.anchor,
      super.children,
      super.priority,
      required this.value});

  T value;
}
