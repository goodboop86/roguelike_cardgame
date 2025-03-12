import 'package:flame/components.dart' hide Timer;
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'dart:async';


class MainGame extends FlameGame with KeyboardEvents, HasGameRef {
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
    // 画面中央に100x100の赤いボックスを表示
    final player = RectangleComponent(
      position: Vector2(size.x / 3 - 50, size.y / 3 - 50),
      size: Vector2.all(200),
      paint: Paint()..color = Colors.blue,
      children: [TextComponent(
        text: 'Hello, Flame',
        position: Vector2.all(16.0),
      )]
    );

    final enemy = RectangleComponent(
        position: Vector2(size.x / 1.5 - 50, size.y / 3 - 50),
        size: Vector2.all(200),
        paint: Paint()..color = Colors.red,
        children: [TextComponent(
          text: 'Hello, Flame',
          position: Vector2.all(16.0),
        )]
    );

    add(player);
    add(enemy);



  }









}
