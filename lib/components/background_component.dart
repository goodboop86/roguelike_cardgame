import 'dart:ui';

import 'package:flame/components.dart' hide Timer;
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:roguelike_cardgame/components/text_component.dart';
import 'package:roguelike_cardgame/main_game.dart';

import 'package:flame/components.dart';
import 'package:flutter/material.dart' hide Gradient;

import '../providers/sizes.dart';

class GradientBackground extends PositionComponent
    with HasGameReference<MainGame> {
  GradientBackground.topGradient() {
    position = Sizes.gameTopLeft;
    paint = Paint()
      ..shader = Gradient.linear(
        Offset(Sizes.gameWidth / 2, 0),
        Offset(Sizes.gameWidth / 2, Sizes.blockLength*2),
        [
          Colors.black,
          Colors.transparent,
        ],
      );
  }

  GradientBackground.bottomGradient() {
    position = Sizes.bottomGradientPosition;
    paint = Paint()
      ..shader = Gradient.linear(
        Offset(Sizes.gameWidth / 2, 0),
        Offset(Sizes.gameWidth / 2, Sizes.blockLength),
        [
          Colors.transparent,
          Colors.black,
        ],
      );
  }

  late Paint paint;

  @override
  void render(Canvas canvas) {
    // Paint paint = Paint()..shader = shader;
    canvas.drawRect(
        Rect.fromLTWH(0, 0, Sizes.gameWidth, Sizes.gameHeight), paint);
  }
}

class BlockTapOverlay extends RectangleComponent with TapCallbacks {
  BlockTapOverlay();

  BlockTapOverlay.transparent({super.children})
      : super(
            size: CANVAS.sizes.size,
            anchor: Anchor.center,
            position: CANVAS.sizes.size / 2,
            paint: Paint()..color = Colors.black.withValues(alpha: 0.0),
            priority: 1000);

  BlockTapOverlay.transparent_({super.children})
      : super(
            size: Sizes.gameSize,
            anchor: Anchor.center,
            position: Vector2(0, 0),
            paint: Paint()..color = Colors.black.withValues(alpha: 0.0),
            priority: 1000);

  BlockTapOverlay.halfBlack({super.children})
      : super(
            size: CANVAS.sizes.size,
            anchor: Anchor.center,
            position: CANVAS.sizes.size / 2,
            paint: Paint()..color = Colors.black.withValues(alpha: 0.5),
            priority: 1000);

  BlockTapOverlay.black({super.children})
      : super(
            size: CANVAS.sizes.size,
            anchor: Anchor.center,
            position: CANVAS.sizes.size / 2,
            paint: Paint()..color = Colors.black.withValues(alpha: 1.0),
            priority: 1000);

  @override
  void onTapDown(TapDownEvent event) {
    print("blocked!!!!");
  } // タッチイベントを消費する
}

class PopupWindow extends RectangleComponent with TapCallbacks {
  PopupWindow({super.position, super.size, super.children, super.anchor})
      : super(
          paint: Paint()..color = Colors.black.withValues(alpha: 0.8),
        );

  PopupWindow.choice({super.children})
      : super(
            paint: Paint()..color = Colors.black.withValues(alpha: 0.8),
            size: CANVAS.sizes.npcPopupSize,
            anchor: Anchor.topCenter,
            position: CANVAS.sizes.npcPopupPosition);

  PopupWindow.npcDialog({super.children})
      : super(
      paint: Paint()..color = Colors.black.withValues(alpha: 0.3),
      position: Sizes.npcDialogPosition,
      size: Sizes.npcDialogSize,
      anchor: Anchor.topLeft,);

  PopupWindow.yesNo({super.children})
      : super(
            paint: Paint()..color = Colors.black.withValues(alpha: 0.8),
            size: Sizes.boolDialogSize,
            anchor: Anchor.center,
            position: CANVAS.sizes.size / 2);
}

class SupportDialog extends RectangleComponent {
  SupportDialog({required text})
      : super(
            position: Sizes.supportDialogPosition,
            size: Sizes.supportDialogSize,
            paint: Paint()..color = Colors.black.withValues(alpha: 0.1),
            children: [
              TextBoxes.supportText()..text = text,
              MoveEffect.by(
                Vector2(0, -5), // 上方向に50ピクセル移動
                EffectController(
                  duration: 1.0, // 2秒かけて移動
                  curve: Curves.easeInOut, // イーズイン・アウトのアニメーションカーブ
                ),
              ),
              OpacityEffect.to(
                0.8, // 最終的な透明度（完全に不透明）
                EffectController(
                  duration: 1.0, // 2秒かけて透明度を変化
                  curve: Curves.easeInOut,
                ),
              ),
              RemoveEffect(delay: 5.0)
            ]);
}
