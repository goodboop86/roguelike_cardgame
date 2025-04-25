import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:roguelike_cardgame/components/text_component.dart';
import 'package:roguelike_cardgame/main_game.dart';

import '../models/enum.dart';
import '../providers/sizes.dart';
import '../spritesheet/spritesheet.dart';
import '../valueroutes/popup.dart';

class Buttons extends SpriteButtonComponent {
  Buttons();

  Buttons.basicButton({super.onPressed, super.position})
      : super(
          anchor: Anchor.center,
          button: AssetSource().getSprite(name: "button.png"),
          size: Sizes.buttonSize,
        );

  Buttons.npcDialogButton({super.onPressed})
      : super(
            position: CANVAS.sizes.npcPopupSize / 2,
            anchor: Anchor.center,
            button: AssetSource().getSprite(name: "button.png"),
            size: Sizes.buttonSize);

  Buttons.optionButton({super.onPressed})
      : super(
          priority: 20,
          button: AssetSource().getSprite(name: "button.png"),
          size: Sizes.buttonSize,
          anchor: Anchor.center,
        );

  Buttons.homeButton({super.onPressed})
      : super(
    priority: 100,
    button: AssetSource().getSprite(name: "home.png"),
    size: Sizes.blockSize,
    anchor: Anchor.topLeft,
  );

  Buttons.questionButton({super.onPressed})
      : super(
    priority: 100,
    button: AssetSource().getSprite(name: "question.png"),
    size: Sizes.blockSize,
    anchor: Anchor.topLeft,
  );

  Buttons.dialogNextButton({super.onPressed})
      : super(
    priority: 100,
    button: AssetSource().getSprite(name: "right_arrow.png"),
    size: Sizes.blockSize * 0.8,
    position: Sizes.npcDialogSize - Sizes.blockSize,
    anchor: Anchor.topLeft,
  );
}


class DialogButtonComponent extends ButtonComponent {
  DialogButtonComponent.yes({super.onPressed})
      : super(
          anchor: Anchor.topLeft,
          position:
              Vector2(0, Sizes.boolDialogHeight - Sizes.dialogButtonHeight),
          button: RectangleComponent(
            size: Sizes.dialogButtonSize,
            paint: Paint()..color = Colors.yellow.withValues(alpha: 0.6),
            priority: 0,
          ),
          children: [
            Texts.buttonText()..text = "yes",
          ],
        );

  DialogButtonComponent.no({
    super.onPressed,
  }) : super(
          anchor: Anchor.topLeft,
          position: Vector2(Sizes.boolDialogWidth - Sizes.dialogButtonWidth,
              Sizes.boolDialogHeight - Sizes.dialogButtonHeight),
          button: RectangleComponent(
            size: Sizes.dialogButtonSize,
            paint: Paint()..color = Colors.grey.withValues(alpha: 0.6),
            priority: 0,
          ),
          children: [
            Texts.buttonText()..text = "no",
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
    bool isYes = await game.router.pushAndWait(YesNoPopupRoute());

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
