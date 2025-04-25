import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:roguelike_cardgame/main_game.dart';

import '../components/background_component.dart';
import '../components/button_component.dart';
import '../components/text_component.dart';
import '../providers/sizes.dart';


class NPCDialogRoute extends ValueRoute<int> with HasGameReference<MainGame> {
  NPCDialogRoute() : super(value: -1, transparent: true);

  @override
  Component build() {
    TextBoxComponent textBox = TextBoxes.dialogText()..text = "サンプルテキスト";

    return OverlayBackground(
        paint: Paint()..color = Colors.black.withValues(alpha: 0.5),
        size: game.canvasSize,
        children: [
          PopupBackground(
            position: CANVAS.sizes.npcPopupPosition,
            size: CANVAS.sizes.npcPopupSize,
            anchor: Anchor.topCenter,
            children: [
              textBox,
              BasicButtonComponent.npcDialogButton(onPressed: () {
                completeWith(
                  12345, // return value
                );
              })
            ],
          )
        ]);
  }
}

class YesNoPopupRoute extends ValueRoute<bool>
    with HasGameReference<MainGame> {
  YesNoPopupRoute() : super(value: false, transparent: false);

  @override
  Component build() {
    return OverlayBackground(
        paint: Paint()..color = Colors.black.withValues(alpha: 0.5),
        size: game.canvasSize,
        children: [
          PopupBackground.yesNoPopup(
            children: [
              DialogButtonComponent.yes(
                onPressed: () {
                  completeWith(
                    true, // return value
                  );
                },
              ),
              DialogButtonComponent.no(
                onPressed: () {
                  completeWith(
                    false, // return value
                  );
                },
              )
            ],
          )
        ]);
  }
}
