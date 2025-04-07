import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:roguelike_cardgame/main_game.dart';

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
              size: Sizes().buttonSize,
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
              position: Sizes().buttonSize / 2,
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
              size: Sizes().buttonSize,
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
              position: Sizes().buttonSize / 2,
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

class DialogBackground extends RectangleComponent with TapCallbacks {
  DialogBackground({super.position, super.size, super.children})
      : super(
          anchor: Anchor.center,
          paint: Paint()..color = const Color(0xee858585),
        );
}
