import 'package:flame/components.dart' hide Timer;
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
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

    _addCharacters();
    _addCards(4);
    _addButtons();
  }

  void _addCharacters() {
    // カードエリアを作成
    final characterArea = CharacterAreaComponent(
      position: Sizes().characterAreaPosition,
      size: Sizes().characterAreaSize, // カードエリアのサイズ
    );
    add(characterArea);

    // Player の配置 (左上)
    characterArea.add(PlayerComponent()
      ..size = Sizes().characterSize
      ..position = Sizes().playerPosition);

    // Enemy の配置 (右上)
    characterArea.add(EnemyComponent()
      ..size = Sizes().characterSize
      ..position = Sizes().enemyPosition);
  }

  void _addButtons() {
    void refreshCards() {
      // 現在のカードを削除
      children.whereType<CardAreaComponent>().forEach((area) {
        remove(area);
      });
      _cards.clear();

      // 新しいカードを生成して配置
      _addCards(4); // カード枚数を指定
    }

    // カードエリアを作成
    final buttonArea = ButtonAreaComponent(
      position: Sizes().buttonAreaPosition,
      size: Sizes().buttonAreaSize, // カードエリアのサイズ
    );
    add(buttonArea);

    List buttonOnPressedFunctions = [
      () {debugPrint('Button 1 pressed');},
      () {debugPrint('Button 2 pressed');},
      () {debugPrint('Button 3 pressed');},
      () {
        refreshCards();
      }
    ];
    int buttonNum = buttonOnPressedFunctions.length;
    buttonOnPressedFunctions.asMap().forEach((index, function) {
      final buttonWidth = buttonArea.size.x * 0.2;
      final buttonMargin = (buttonArea.size.x - buttonWidth * buttonNum) / (buttonNum+1);
      final buttonPosition = Vector2(
        buttonMargin + index * (buttonWidth + buttonMargin),
        (Sizes().buttonAreaHeight - Sizes().buttonHeight) / 2,
      );
      final button = ButtonComponent(
        button: RectangleComponent(
          size: Sizes().buttonSize,
          paint: Paint()..color = Colors.red,
        ),
        onPressed: function,
      );
      button.position= buttonPosition;
      buttonArea.add(button);
    });
  }

  void _addCards(int cardCount) {
    debugPrint("add cards");

    // カードエリアを作成
    final cardArea = CardAreaComponent(
      position: Sizes().cardAreaPosition,
      size: Sizes().cardAreaSize, // カードエリアのサイズ
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
        ..size = Sizes().cardSize
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
