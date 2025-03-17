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
    final screenSize = size; // ディスプレイサイズを取得
    final screenWidth = screenSize.x;
    final screenHeight = screenSize.y;

    const double margin = 20.0; // 余白のサイズ

    // Player の配置 (左上)
    final playerSize = Vector2(screenWidth * 0.4 - margin * 2, screenHeight * 0.4 - margin * 2);
    add(PlayerComponent()
      ..size = playerSize
      ..position = Vector2(margin, margin));

    // Enemy の配置 (右上)
    final enemySize = Vector2(screenWidth * 0.4 - margin * 2, screenHeight * 0.4 - margin * 2);
    add(EnemyComponent()
      ..size = enemySize
      ..position = Vector2(screenWidth - enemySize.x - margin, margin));

    // Card の配置 (下部)
    final cardSize = Vector2(screenWidth * 0.22 - margin * 2, screenHeight * 0.25 - margin * 2);
    final cardY = screenHeight - cardSize.y - margin;
    for (int i = 0; i < 4; i++) {
      add(CardComponent(
        card: Card_(name: 'Card ${i + 1}', effect: CardEffect(damage: 10, heal: 5)),
      )
        ..size = cardSize
        ..position = Vector2(screenWidth * 0.05 + i * screenWidth * 0.23 + margin, cardY));
    }

    // await draw();
  }

  void setCallback(Function fn) => stateCallbackHandler = fn;


  Future<void> draw() async {
    // add(PlayerComponent()
    //   ..position = Vector2(50, 50)
    //   ..size = Vector2.all(100));
    // add(CardComponent(
    //   card: Card_(name: 'Fireball', effect: CardEffect(damage: 20, heal: 0)),
    // )
    //   ..position = Vector2(100, 100)
    //   ..size = Vector2(100, 50));
    // add(CardComponent(
    //   card: Card_(name: 'Mana Potion', effect: CardEffect(damage: 0, heal: 10)),
    // )
    //   ..position = Vector2(100, 200)
    //   ..size = Vector2(100, 50));

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
