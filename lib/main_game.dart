import 'dart:convert';

import 'package:flame/components.dart' hide Timer;
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roguelike_cardgame/providers/sizes.dart';

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
    Sizes().setScreenSize(size);
    final screenSize = size; // ディスプレイサイズを取得
    final screenWidth = screenSize.x;
    final screenHeight = screenSize.y;

    const double margin = 20.0; // 余白のサイズ

    _addCharacters();
    _addCards(4);
    _addButtons();
  }

  void _addCharacters() {
    // Player の配置 (左上)
    add(PlayerComponent()
      ..size = Vector2(Sizes().characterWidth, Sizes().characterHeight)
      ..position = Vector2(Sizes().playerX, Sizes().playerY));

    // Enemy の配置 (右上)
    add(EnemyComponent()
      ..size = Vector2(Sizes().characterWidth, Sizes().characterHeight)
      ..position = Vector2(Sizes().enemyX, Sizes().enemyY));
  }

  void _addButtons() {
    // ButtonComponent を追加
    add(
      ButtonComponent(
        button: PositionComponent() // ボタンの見た目を定義
          ..size = Vector2(100, 100)
          ..add(RectangleComponent(
              size: Vector2(50, 50), paint: Paint()..color = Colors.red)),
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

    // 新しいカードを生成して配置
    _addCards(4); // カード枚数を指定
  }

  void _addCards(int cardCount) {
    print("add cards");

    // カードエリアを作成
    final cardArea = CardAreaComponent(
      position: Vector2(
        Sizes().cardAreaX,
        Sizes().cardAreaY,
      ),
      size:
          Vector2(Sizes().cardAreaWidth, Sizes().cardAreaHeight), // カードエリアのサイズ
    );
    add(cardArea);

    // カードのリストを作成
    final cards = <Card_>[];
    final effectFunctions = [
      damageEffect,
      healEffect,
      buffEffect,
      debuffEffect
    ];
    effectFunctions.asMap().forEach((index, effectFunction) {
      // asMap() と forEach() を使用
      final card = Card_(
        name: 'Card ${index + 1}',
        effect: CardEffect(effectFunction: effectFunction),
      );
      cards.add(card);
    });

    // カードコンポーネントを作成し、カードエリアの中心に集める
    final cardAreaCenterX = Sizes().cardAreaWidth / 2;
    final cardAreaCenterY = Sizes().cardAreaHeight / 2;
    cards.asMap().forEach((index, card) {
      final row = index ~/ 2;
      final col = index % 2;
      final cardComponent = CardComponent(card: card)
        ..size = Vector2(Sizes().cardWidth, Sizes().cardHeight)
        ..position = Vector2(
          cardAreaCenterX -
              Sizes().cardWidth / 2 +
              col * (Sizes().cardWidth + Sizes().cardMargin) -
              (Sizes().cardWidth + Sizes().cardMargin) / 2, // X 座標を調整
          cardAreaCenterY -
              Sizes().cardHeight / 2 +
              row * (Sizes().cardHeight + Sizes().cardMargin) -
              (Sizes().cardHeight + Sizes().cardMargin) / 2, // Y 座標を調整
        ); // カードエリアの中心を基準に位置を計算
      cardArea.add(cardComponent);
    });
  }

  void rearrangeCards() {
    final totalCardWidth = _cards.length * Sizes().cardWidth;
    final totalMarginWidth = (_cards.length - 1) * Sizes().cardMargin;
    final totalWidth = totalCardWidth + totalMarginWidth;

    final startX = (Sizes().screenWidth - totalWidth) / 2;

    for (int i = 0; i < _cards.length; i++) {
      _cards[i].position = Vector2(
          startX + i * (Sizes().cardWidth + Sizes().cardMargin),
          Sizes().cardHeight);
    }
  }

  void setCallback(Function fn) => stateCallbackHandler = fn;
}
