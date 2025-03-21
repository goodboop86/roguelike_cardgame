import 'package:flame/components.dart' hide Timer;
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:roguelike_cardgame/main_game.dart';
import 'package:roguelike_cardgame/providers/sizes.dart';
import 'package:flame/parallax.dart';

import 'dart:async';

import '../components/card_area_component.dart';
import '../components/card_component.dart';
import '../components/enemy_component.dart';
import '../components/player_component.dart';
import '../models/card.dart';
import '../models/card_effect.dart';

class BattlePage extends Component
    with HasGameRef<MainGame>, RiverpodComponentMixin {
  late Function stateCallbackHandler;
  final List<CardComponent> _cards = []; // カードリストをキャッシュ

  @override
  Future<void> onLoad() async {
    super.onLoad();
    Sizes().setScreenSize(game.size);

    await _addCharacters();
    _addCards(4);
    _addButtons();
  }

  Future<void> _addCharacters() async {
    // カードエリアを作成
    final characterArea = CharacterAreaComponent(
      position: Sizes().characterAreaPosition,
      size: Sizes().characterAreaSize, // カードエリアのサイズ
    );
    add(characterArea);

    // Player の配置 (左上)
    PlayerComponent player = PlayerComponent()
      ..size = Sizes().playerAreaSize
      ..position = Sizes().playerAreaPosition;

    // Player の配置 (左上)
    EnemyComponent enemy = EnemyComponent()
      ..size = Sizes().enemyAreaSize
      ..position = Sizes().enemyAreaPosition;
    characterArea.addAll([player, enemy]);

    var playerAnimation = SpriteAnimationComponent.fromFrameData(
        await Flame.images.load('noBKG_KnightIdle_strip.png'),
        SpriteAnimationData.sequenced(
          textureSize: Vector2.all(64),
          amount: 15,
          stepTime: 0.08,
        ))
      ..anchor = Anchor.bottomCenter
      ..size = Vector2(128,128)
    ..position = Vector2(Sizes().playerAreaWidth/2,Sizes().playerAreaHeight);

    var enemyAnimation = SpriteAnimationComponent.fromFrameData(
        await Flame.images.load('noBKG_KnightIdle_strip.png'),
        SpriteAnimationData.sequenced(
          textureSize: Vector2.all(64),
          amount: 15,
          stepTime: 0.08,
        ))..anchor = Anchor.bottomCenter
      ..size = Vector2(128,128)
      ..position = Vector2(Sizes().enemyAreaWidth/2,Sizes().enemyAreaHeight)..flipHorizontally();


    player.add(playerAnimation);
    enemy.add(enemyAnimation);
    // var player_ = PlayerComponent()
    //   ..animation = SpriteAnimation.fromFrameData(
    //       await Flame.images.load('noBKG_KnightIdle_strip.png'),
    //       SpriteAnimationData.sequenced(
    //         textureSize: Vector2.all(64),
    //         amount: 15,
    //         stepTime: 0.08,
    //       ))
    //   ..size = Sizes().characterSize
    //   ..position = Sizes().playerPosition;

    // var enemy_ = EnemyComponent()
    //   ..animation = SpriteAnimation.fromFrameData(
    //       await Flame.images.load('noBKG_KnightIdle_strip.png'),
    //       SpriteAnimationData.sequenced(
    //         textureSize: Vector2.all(64),
    //         amount: 15,
    //         stepTime: 0.08,
    //       ))
    //   ..size = Sizes().characterSize
    //   ..position = Sizes().enemyPosition
    //   ..flipHorizontally();

    // Enemy の配置 (右上)
    // characterArea.add(enemy_);
    //
    // characterArea.add(player);
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
      () {
        game.router.pushNamed('home');
      },
      () {
        debugPrint('Button 2 pressed');
      },
      () {
        debugPrint('Button 3 pressed');
      },
      () {
        refreshCards();
      }
    ];
    int buttonNum = buttonOnPressedFunctions.length;
    buttonOnPressedFunctions.asMap().forEach((index, function) {
      final buttonWidth = buttonArea.size.x * 0.2;
      final buttonMargin =
          (buttonArea.size.x - buttonWidth * buttonNum) / (buttonNum + 1);
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
      button.position = buttonPosition;
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
    final effectFunctions = [emptyEffect, healEffect, buffEffect, debuffEffect];
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
