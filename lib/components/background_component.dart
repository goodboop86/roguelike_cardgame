import 'dart:ui';

import 'package:flame/components.dart' hide Timer;
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:roguelike_cardgame/main_game.dart';

import '../providers/sizes.dart';

class GradientBackground extends PositionComponent
    with HasGameReference<MainGame> {
  GradientBackground({required super.position, required this.shader})
      : super(anchor: Anchor.topLeft);

  Shader shader;

  @override
  void render(Canvas canvas) {
    Paint paint = Paint()..shader = shader;
    canvas.drawRect(
        Rect.fromLTWH(0, 0, Sizes.gameWidth, Sizes.gameHeight), paint);
  }
}

class OverlayBackground extends RectangleComponent with TapCallbacks {
  OverlayBackground({
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
  });

  @override
  void onTapDown(TapDownEvent event) {
    print("blocked!!!!");
  } // タッチイベントを消費する
}

class DialogBackground extends RectangleComponent with TapCallbacks {
  DialogBackground({super.position, super.size, super.children, super.anchor})
      : super(
          paint: Paint()..color = Colors.black.withValues(alpha: 0.8),
        );
}

class SupportDialog extends RectangleComponent {
  SupportDialog({required text})
      : super(
            position: Sizes.supportDialogPosition,
            size: Sizes.supportDialogSize,
            paint: Paint()..color = Colors.black.withValues(alpha: 0.1),
            children: [
              TextBoxComponent(
                textRenderer: TextPaint(
                    style: const TextStyle(
                  fontSize: 14,
                  color: Colors.yellow,
                  fontFamily: 'monospace', // 等幅フォントが見やすい
                )),
                align: Anchor.center,
                text: text,
                size: Sizes.supportDialogSize,
                anchor: Anchor.topLeft,
                // position: Sizes.supportDialogPosition
              ),
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
