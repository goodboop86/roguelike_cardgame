import 'dart:convert';

import 'package:flame/components.dart' hide Timer;
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';

import 'package:roguelike_cardgame/character_state.dart';

import 'card.dart';
import 'charactor.dart';

class MainGame extends FlameGame with HasGameRef, RiverpodGameMixin {
  late Function stateCallbackHandler;

  @override
  Color backgroundColor() => const Color.fromRGBO(89, 106, 108, 1.0);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await draw();
  }

  void setCallback(Function fn) => stateCallbackHandler = fn;

  Future<void> draw() async {
    add(PlayerComponent()
      ..position = Vector2(50, 50)
      ..size = Vector2.all(100));
    add(CardComponent(
      'Fireball',
      20,
      10,
    )
      ..position = Vector2(50, 200)
      ..size = Vector2.all(100));
    add(CardComponent(
      'Heal',
      -15,
      5,
    )
      ..position = Vector2(200, 200)
      ..size = Vector2.all(100));

    // // 画面中央に100x100の赤いボックスを表示
    // final playerBox = RectangleComponent(
    //     position: Vector2(size.x / 3 - 50, size.y / 3 - 50),
    //     size: Vector2.all(200),
    //     paint: Paint()..color = Colors.blue,
    //     children: [
    //       TextComponent(
    //         text: jsonEncode(player),
    //         position: Vector2.all(16.0),
    //       )
    //     ]);
    //
    // final enemyBox = RectangleComponent(
    //     position: Vector2(size.x / 1.5 - 50, size.y / 3 - 50),
    //     size: Vector2.all(200),
    //     paint: Paint()..color = Colors.red,
    //     children: [
    //       TextComponent(
    //         text: jsonEncode(enemy),
    //         position: Vector2.all(16.0),
    //       )
    //     ]);

    // add(playerBox);
    // add(enemyBox);
  }
}
