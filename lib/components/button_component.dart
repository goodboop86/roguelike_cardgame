import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import '../providers/sizes.dart';

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
            size: Sizes().buttonSize,
            paint: Paint()..color = Colors.brown,
            priority: 0,
          ),
          children: [
            TextComponent(
              priority: 1,
              text: text,
              position: Sizes().buttonSize / 2,
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
  UIButtonComponent(
      {
        super.button,
        super.buttonDown,
        super.onPressed,
        super.position,
        super.size,
        super.scale,
        super.angle,
        super.anchor,
        super.children,
        super.priority,})
      : super();

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
      size: Sizes().dialogButtonSize,
      paint: paint,
      priority: 0,
    ),
    children: [
      TextComponent(
        priority: 1,
        text: text,
        position: Sizes().dialogButtonSize / 2,
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
              size: Sizes().buttonSize,
              paint: Paint()..color = Colors.brown,
              priority: 0),
          onPressed: func,
          anchor: Anchor.center,
          children: [
            TextComponent(
              priority: 1,
              text: text,
              position: Sizes().buttonSize / 2,
              anchor: Anchor.center,
              textRenderer:
                  TextPaint(style: const TextStyle(color: Colors.white)),
            ),
          ],
        );
}

class ChoiceButtonComponent<T> extends ToggleButtonComponent {
  ChoiceButtonComponent(
      {super.onPressed,
      super.onSelectedChanged,
      super.onChangeState,
      super.defaultSkin,
      super.downSkin,
      super.disabledSkin,
      super.defaultSelectedSkin,
      super.downAndSelectedSkin,
      super.disabledAndSelectedSkin,
      super.defaultLabel,
      super.disabledLabel,
      super.defaultSelectedLabel,
      super.disabledAndSelectedLabel,
      super.size,
      super.position,
      super.scale,
      super.angle,
      super.anchor,
      super.children,
      super.priority,
      required this.value,
      required this.key});

  @override
  ComponentKey key;

  T value;
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
