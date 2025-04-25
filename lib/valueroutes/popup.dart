import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';

import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:roguelike_cardgame/components/basic_component.dart';
import 'package:roguelike_cardgame/main_game.dart';

import '../components/background_component.dart';
import '../components/button_component.dart';
import '../components/text_component.dart';
import '../providers/sizes.dart';

class StringRoute extends ValueRoute<String> with HasGameReference<MainGame> {
  StringRoute() : super(value: "empty", transparent: true);

  @override
  Component build() {
    final size = Vector2(250, 130);
    return DialogBackground(
      position: game.size / 2,
      size: size,
      children: [
        ButtonComponent(
          button: RectangleComponent(
              size: Sizes.buttonSize,
              paint: Paint()..color = Colors.brown,
              priority: 0),
          onPressed: () {
            completeWith(
              "complete!", // return value
            );
          },
          children: [
            TextComponent(
              priority: 1,
              text: 'hello',
              position: Sizes.buttonSize / 2,
              anchor: Anchor.center,
              textRenderer:
                  TextPaint(style: const TextStyle(color: Colors.white)),
            ),
          ],
        )
      ],
    );
  }
}

class IntRoute extends ValueRoute<int> with HasGameReference<MainGame> {
  IntRoute() : super(value: -1, transparent: true);

  @override
  Component build() {
    final size = Vector2(250, 130);
    return DialogBackground(
      position: game.size / 2,
      size: size,
      children: [
        ButtonComponent(
          button: RectangleComponent(
              size: Sizes.buttonSize,
              paint: Paint()..color = Colors.brown,
              priority: 0),
          onPressed: () {
            completeWith(
              12345, // return value
            );
          },
          children: [
            TextComponent(
              priority: 1,
              text: 'hello',
              position: Sizes.buttonSize / 2,
              anchor: Anchor.center,
              textRenderer:
                  TextPaint(style: const TextStyle(color: Colors.white)),
            ),
          ],
        )
      ],
    );
  }
}

class NPCDialogRoute extends ValueRoute<int> with HasGameReference<MainGame> {
  NPCDialogRoute() : super(value: -1, transparent: true);

  @override
  Component build() {
    TextBoxComponent textBox = TextBoxes.dialogText()..text="サンプルテキスト";

    return OverlayBackground(
        paint: Paint()..color = Colors.black.withValues(alpha: 0.5),
        size: game.canvasSize,
        children: [
          DialogBackground(
            position: CANVAS.sizes.npcPopupPosition,
            size: CANVAS.sizes.npcPopupSize,
            anchor: Anchor.topCenter,
            children: [
              textBox,
              BasicButtonComponent(
                  position: CANVAS.sizes.npcPopupSize / 2,
                  anchor: Anchor.center,
                  text: 'hello?',
                  func: () {
                    completeWith(
                      12345, // return value
                    );
                  })
            ],
          )
        ]);
  }
}

class MyBoolDialogRoute extends ValueRoute<bool>
    with HasGameReference<MainGame> {
  MyBoolDialogRoute() : super(value: false, transparent: false);

  @override
  Component build() {
    return OverlayBackground(
        paint: Paint()..color = Colors.black.withValues(alpha: 0.5),
        size: game.canvasSize,
        children: [
          DialogBackground(
            position: game.canvasSize / 2,
            size: Sizes.boolDialogSize,
            anchor: Anchor.center,
            children: [
              DialogButtonComponent(
                  position: Vector2(
                      0, Sizes.boolDialogHeight - Sizes.dialogButtonHeight),
                  anchor: Anchor.topLeft,
                  text: 'Yes',
                  func: () {
                    completeWith(
                      true, // return value
                    );
                  },
                  paint: Paint()..color = Colors.yellow.withValues(alpha: 0.6)),
              DialogButtonComponent(
                  position: Vector2(
                      Sizes.boolDialogWidth - Sizes.dialogButtonWidth,
                      Sizes.boolDialogHeight - Sizes.dialogButtonHeight),
                  anchor: Anchor.topLeft,
                  text: 'No',
                  func: () {
                    completeWith(
                      false, // return value
                    );
                  },
                  paint: Paint()..color = Colors.grey.withValues(alpha: 0.6))
            ],
          )
        ]);
  }
}
