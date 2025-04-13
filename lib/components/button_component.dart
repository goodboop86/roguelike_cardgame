import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import '../providers/sizes.dart';

class BasicButtonComponent extends ButtonComponent {
  final String text;
  final VoidCallback? func;

  BasicButtonComponent({required this.text, this.func})
      : super(
          button: RectangleComponent(
            size: Sizes().buttonSize,
            paint: Paint()..color = Colors.brown,
            priority: 0,
          ),
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

  @override
  Future<void> onLoad() async {
    // 必要であれば、ボタン固有のアセットロードや初期化処理をここで行う
    // 例: ボタンの画像スプライトをロードするなど
    await super.onLoad();
  }
}
