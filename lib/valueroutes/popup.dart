import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:roguelike_cardgame/main_game.dart';

import '../components/background_component.dart';
import '../components/button_component.dart';
import '../components/text_component.dart';
import '../providers/sizes.dart';

class MyPopupRoute extends ValueRoute<int> with HasGameReference<MainGame> {
  MyPopupRoute() : super(value: -1, transparent: true);

  @override
  Component build() {
    return BlockTapOverlay.transparent(children: [
      PopupWindow.choice(
        children: [
          TextBoxes.dialogText()..text = "サンプルテキスト",
          Buttons.npcDialogButton(onPressed: () {
            completeWith(
              12345, // return value
            );
          })
        ],
      )
    ]);
  }
}

class YesNoPopupRoute extends ValueRoute<bool> with HasGameReference<MainGame> {
  YesNoPopupRoute() : super(value: false, transparent: false);

  @override
  Component build() {
    return BlockTapOverlay.halfBlack(
        children: [
          PopupWindow.yesNo(
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
