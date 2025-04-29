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

class SpriteButtons extends SpriteButtonComponent {
  SpriteButtons();

  SpriteButtons.basicButton({super.onPressed, super.position})
      : super(
          anchor: Anchor.center,
          button: AssetSource().getSprite(name: "button.png"),
          size: Sizes.buttonSize,
        );

  SpriteButtons.npcDialogButton({super.onPressed})
      : super(
            position: CANVAS.sizes.npcPopupSize / 2,
            anchor: Anchor.center,
            button: AssetSource().getSprite(name: "button.png"),
            size: Sizes.buttonSize);

  SpriteButtons.optionButton({super.onPressed})
      : super(
          priority: 20,
          button: AssetSource().getSprite(name: "button.png"),
          size: Sizes.buttonSize,
          anchor: Anchor.center,
        );

  SpriteButtons.homeButton({super.onPressed})
      : super(
          priority: 100,
          button: AssetSource().getSprite(name: "home.png"),
          size: Sizes.blockSize,
          anchor: Anchor.topLeft,
        );

  SpriteButtons.questionButton({super.onPressed})
      : super(
          priority: 100,
          button: AssetSource().getSprite(name: "question.png"),
          size: Sizes.blockSize,
    position: Vector2(Sizes.bottomUiAreaWidth - Sizes.blockLength, 0),
          anchor: Anchor.topLeft,
        );

  SpriteButtons.dialogNextButton({super.onPressed})
      : super(
          priority: 100,
          button: AssetSource().getSprite(name: "right_arrow.png"),
          size: Sizes.blockSize * 0.8,
          position: Sizes.npcDialogSize - Sizes.blockSize,
          anchor: Anchor.topLeft,
        );

  SpriteButtons.heartButton({super.onPressed})
      : super(
          priority: 100,
          button: AssetSource().getSprite(name: "heart.png"),
          size: Sizes.blockSize * 0.5,
          anchor: Anchor.topLeft,
        );

  SpriteButtons.manaButton({super.onPressed})
      : super(
          priority: 100,
          button: AssetSource().getSprite(name: "mana.png"),
          position: Vector2(3 * Sizes.blockLength, 0),
          size: Sizes.blockSize * 0.5,
          anchor: Anchor.topLeft,
        );

  SpriteButtons.enemyIconButton({super.onPressed})
      : super(
          priority: 100,
          button: AssetSource().getSprite(name: 'heart.png'),
          position: Vector2(4.5 * Sizes.blockLength, 0),
          size: Sizes.blockSize * 0.5,
          anchor: Anchor.topLeft,
        );
}

class Buttons extends ButtonComponent {
  Buttons.yes({super.onPressed})
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

  Buttons.no({
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

class MapCardComponent extends PositionComponent
    with TapCallbacks, HasGameRef<MainGame> {
  MapCardComponent({
    super.position,
    super.anchor,
    super.children,
    super.key,
    required this.value,
  }) : super(
          size: Sizes.mapCardSize,
          priority: 30,
        );

  Event value;

  @override
  Future<void> onMount() async {
    super.onMount();

    final animation = AssetSource().getAnimation(name: "containers.png")!;
    Sprite? sprite = animation
        .animations?[ContainerState.goldenChestBoxIdle]!.frames.first.sprite;

    add(SpriteComponent(
      size: Sizes.mapCardSpriteSize,
      position: Sizes.mapCardSpritePosition,
      sprite: sprite,
      priority: 10,
      anchor: Anchor.topLeft,
    ));

    add(RectangleComponent(
        size: Sizes.mapCardSize, paint: Paint()..color = Colors.black54, priority: 0));
  }

  @override
  Future<void> onTapUp(TapUpEvent event) async {
    bool isYes = await game.router.pushAndWait(YesNoPopupRoute());

    if (isYes) {
      game.routeWithFadeOut(message: '', event: value);
    }
    super.onTapUp(event);
  }
}
