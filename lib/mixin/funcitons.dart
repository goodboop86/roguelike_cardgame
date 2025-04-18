
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:roguelike_cardgame/models/enum.dart';

import '../components/basic_component.dart';
import '../main_game.dart';
import '../singleton/sizes.dart';

mixin Funcs on Component, HasGameRef<MainGame>, RiverpodComponentMixin {

  Function(ROUTE) routeWithTransition = (ROUTE route) {
    final overlay = OverlayComponent(size: Sizes.gameSize, anchor: Anchor.center, paint: Paint()..color = Colors.black.withValues(alpha: 0.5), priority: 1000);


    print("Foo button pressed (singleton)!");
    // その他の foo ボタンの処理
  };

  VoidCallback onBarPressed = () {
    print("Bar button pressed (singleton)!");
    // その他の bar ボタンの処理
  };

  Function(String) onValueChanged = (newValue) {
    print("Value changed to: $newValue (singleton)");
    // 値が変更されたときの処理
  };
}
