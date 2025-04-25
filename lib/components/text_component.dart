import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../providers/sizes.dart';

class TextBoxes extends TextBoxComponent {
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
}

class Texts extends TextComponent {
  Texts.transitionText()
      : super(
            priority: 1,
            anchor: Anchor.center,
            textRenderer: TextPaint(
                style: const TextStyle(color: Colors.white, fontSize: 24)));
}
