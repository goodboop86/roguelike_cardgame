import 'dart:convert';

import 'package:flame/components.dart' hide Timer;
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';


import 'components/card_component.dart';
import 'components/enemy_component.dart';
import 'components/player_component.dart';
import 'models/card.dart';
import 'models/card_effect.dart';

class MainGame extends FlameGame with HasGameRef, RiverpodGameMixin {
  late Function stateCallbackHandler;
  final List<CardComponent> _cards = []; // カードリストをキャッシュ

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

    _addCards(4);

    // ButtonComponent を追加
    add(
      ButtonComponent(
        button: PositionComponent() // ボタンの見た目を定義
          ..size = Vector2(100, 100)
          ..add(RectangleComponent(size: Vector2(50, 50), paint: Paint()..color = Colors.red)),
        onPressed: () {
          // カードをリフレッシュして再配置
          refreshCards();
        },
      )..position = Vector2(10, 10), // ボタンの位置
    );

  }

  void refreshCards() {
    // 現在のカードを削除
    // 現在のカードを削除
    children.whereType<CardComponent>().forEach((card) {
      remove(card);
    });
    _cards.clear();

    // 新しいカードを生成して配置
    _addCards(4); // カード枚数を指定
  }

  void _addCards(int cardCount) {

    final screenSize = size;
    final screenWidth = screenSize.x;
    final screenHeight = screenSize.y;
    final cardSize = Vector2(screenWidth * 0.2 - 20, screenHeight * 0.15 - 20);
    final cardY = screenHeight - cardSize.y - 10;
    final cardWidth = cardSize.x;
    final cardMargin = 10.0;

    final totalCardWidth = cardCount * cardWidth;
    final totalMarginWidth = (cardCount - 1) * cardMargin;
    final totalWidth = totalCardWidth + totalMarginWidth;

    final startX = (screenWidth - totalWidth) / 2;

    // カードのリストを作成
    final cards = <Card_>[];
    final effectFunctions = [damageEffect, healEffect, buffEffect, debuffEffect];
    effectFunctions.asMap().forEach((index, effectFunction) { // asMap() と forEach() を使用
      final card = Card_(
        name: 'Card ${index + 1}',
        effect: CardEffect(effectFunction: effectFunction),
      );
      cards.add(card);
    });

    // カードコンポーネントを追加
    cards.asMap().forEach((index, card) { // asMap() と forEach() を使用
      final cardComponent = CardComponent(card: card)
        ..size = cardSize
        ..position = Vector2(startX + index * (cardWidth + cardMargin), cardY);
      add(cardComponent);
    });
  }

  void rearrangeCards() {
    final screenSize = size;
    final screenWidth = screenSize.x;
    final screenHeight = screenSize.y;
    final cardSize = Vector2(screenWidth * 0.2 - 20, screenHeight * 0.15 - 20);
    final cardY = screenHeight - cardSize.y - 10;
    final cardWidth = cardSize.x;
    final cardMargin = 10.0;

    final totalCardWidth = _cards.length * cardWidth;
    final totalMarginWidth = (_cards.length - 1) * cardMargin;
    final totalWidth = totalCardWidth + totalMarginWidth;

    final startX = (screenWidth - totalWidth) / 2;

    for (int i = 0; i < _cards.length; i++) {
      _cards[i].position = Vector2(startX + i * (cardWidth + cardMargin), cardY);
    }
  }

  void removeCard(CardComponent cardComponent) {
    cardComponent.removeFromParent();
    _cards.remove(cardComponent); // カードリストを更新
    rearrangeCards();
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
