import 'dart:convert';

import 'package:flame/components.dart' hide Timer;
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';


import 'components/card_area_component.dart';
import 'components/card_component.dart';
import 'components/enemy_component.dart';
import 'components/player_component.dart';
import 'models/card.dart';
import 'models/card_effect.dart';

class MainGame extends FlameGame with HasGameRef, RiverpodGameMixin {

  @override
  var debugMode = true;

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
    children.whereType<CardAreaComponent>().forEach((area) {
      remove(area);
    });
    _cards.clear();
    print(_cards);

    // 新しいカードを生成して配置
    _addCards(4); // カード枚数を指定
  }

  void _addCards(int cardCount) {

    print("add cards");

    final screenSize = size;
    final screenWidth = screenSize.x;
    final screenHeight = screenSize.y;

    // カードエリアのサイズ
    final cardAreaSize = Vector2(450, 200);

    // カードエリアの位置を計算 (画面中央)
    final cardAreaPosition = Vector2(
      (screenWidth - cardAreaSize.x) / 2,
      (screenHeight - cardAreaSize.y) / 2,
    );

    // カードエリアを作成
    final cardArea = CardAreaComponent(
      position: cardAreaPosition,
      size: cardAreaSize, // カードエリアのサイズ

    );
    add(cardArea);

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


    final cardSize = Vector2(100, 150);
    final cardWidth = cardSize.x;
    const cardMargin = 10;
    // カードコンポーネントを追加
    cards.asMap().forEach((index, card) { // asMap() と forEach() を使用
      final cardComponent = CardComponent(card: card)
        ..size = cardSize
        ..position = Vector2(index * (cardWidth + cardMargin), 0);
      cardArea.add(cardComponent);;
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

  // void removeCard(CardComponent cardComponent) {
  //   cardComponent.removeFromParent();
  //   _cards.remove(cardComponent); // カードリストを更新
  //   rearrangeCards();
  // }

  void setCallback(Function fn) => stateCallbackHandler = fn;


}
