import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../providers/sizes.dart';

class DialogText extends TextBoxComponent {
  DialogText() {
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
}


class SupportText extends TextBoxComponent {
  SupportText() {
    size = Sizes.supportDialogSize;
    align = Anchor.center;
    boxConfig = const TextBoxConfig(
        timePerChar: 0.03,
        maxWidth: 300.0,
        growingBox: true,
        margins: EdgeInsets.fromLTRB(10, 10, 10, 10));

    textRenderer = TextPaint(
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontFamily: 'monospace', // 等幅フォントが見やすい
        ));
  }
}
