import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import '../providers/sizes.dart';

class TextBoxes extends TextBoxComponent with RiverpodComponentMixin {
  TextBoxes();

  TextBoxes.dialogText() {
    size = Sizes.npcDialogSize;
    boxConfig = const TextBoxConfig(
        timePerChar: 0.03,
        maxWidth: 30.0,
        growingBox: true,
        margins: EdgeInsets.fromLTRB(10, 10, 10, 10));

    textRenderer = TextPaint(
        style: const TextStyle(
      fontSize: 14,
      color: Colors.white,
      fontFamily: 'monospace', // 等幅フォントが見やすい
    ));
  }

  TextBoxes.supportText()
      : super(
            align: Anchor.center,
            size: Sizes.supportDialogSize,
            anchor: Anchor.topLeft,
            textRenderer: TextPaint(
                style: const TextStyle(
              fontSize: 14,
              color: Colors.yellow,
              fontFamily: 'monospace', // 等幅フォントが見やすい
            )));

  TextBoxes.cardText()
      : super(
            size: Sizes.cardTextSize,
            position: Sizes.cardTextPosition,
            anchor: Anchor.topLeft,
            boxConfig: TextBoxConfig(
                maxWidth: Sizes.cardTextWidth,
                growingBox: true,
                margins: const EdgeInsets.fromLTRB(4, 4, 4, 4)),
            textRenderer: TextPaint(
                style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
              fontFamily: 'monospace', // 等幅フォントが見やすい
            )));
}

class Texts extends TextComponent {
  Texts.transitionText()
      : super(
            priority: 1,
            anchor: Anchor.center,
            textRenderer: TextPaint(
                style: const TextStyle(color: Colors.white, fontSize: 24)));

  Texts.buttonText()
      : super(
            priority: 1,
            anchor: Anchor.center,
            position: Sizes.dialogButtonSize / 2,
            textRenderer:
                TextPaint(style: const TextStyle(color: Colors.white)));

  Texts.healthText()
      : super(
            priority: 100,
            anchor: Anchor.center,
            position: Vector2(Sizes.blockLength, Sizes.topUiAreaHeight / 2),
            textRenderer: TextPaint(
                style: const TextStyle(color: Colors.white, fontSize: 12)));

  Texts.manaText()
      : super(
            priority: 100,
            anchor: Anchor.center,
            position:
                Vector2(Sizes.blockLength * 2.5, Sizes.topUiAreaHeight / 2),
            textRenderer: TextPaint(
                style: const TextStyle(color: Colors.white, fontSize: 12)));

  Texts.tinyMapText()
      : super(
            priority: 1,
            anchor: Anchor.center,
            position: Sizes.mapSize / 2,
            textRenderer: TextPaint(
                style: const TextStyle(color: Colors.white, fontSize: 12)));
}

class TextPaints extends TextPaint {
  TextPaints.base()
      : super(
            style: const TextStyle(
                color: Colors.white, fontSize: 14, fontFamily: 'monospace', fontWeight: FontWeight.bold));
}
