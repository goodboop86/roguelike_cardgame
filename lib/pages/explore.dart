import 'package:flame/components.dart' hide Timer;
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:roguelike_cardgame/main_game.dart';
import 'package:roguelike_cardgame/providers/sizes.dart';

import 'dart:async';

import '../components/card_area_component.dart';
import '../components/player_component.dart';
import '../models/enum.dart';
import '../systems/dungeon.dart';
import '../systems/event_probabilities.dart';

class ExplorePage extends World
    with HasGameRef<MainGame>, RiverpodComponentMixin {
  late Function stateCallbackHandler;

  @override
  Future<void> onLoad() async {
    int currentStage = 3;
    super.onLoad();

    await _addCharacters();
    List<List<Event>> stageList = generateNestedListWithFixedLength(11, 1, 3);
    _addMap(stageList, currentStage);
    _addMapCards(stageList, currentStage);
  }



  Future<void> _addCharacters() async {

    final parallaxComponent = await game.loadParallaxComponent(
      [
        ParallaxImageData('parallax/1.png'),
        ParallaxImageData('parallax/2.png'),
        ParallaxImageData('parallax/3.png'),
        ParallaxImageData('parallax/5.png'),
        ParallaxImageData('parallax/6.png'),
        ParallaxImageData('parallax/7.png'),
        ParallaxImageData('parallax/8.png'),
        ParallaxImageData('parallax/10.png'),
      ],
      baseVelocity: Vector2(0.1, 0),
      size: Sizes().characterAreaSize,
      position: Sizes().characterAreaPosition,
      velocityMultiplierDelta: Vector2(1.8, 1.0),
    );

    add(parallaxComponent);


    // カードエリアを作成
    final characterArea = CharacterAreaComponent(
      key: ComponentKey.named('BattleCharacterArea'),
      position: Sizes().characterAreaPosition,
      size: Sizes().characterAreaSize, // カードエリアのサイズ
    );
    add(characterArea);

    // Player の配置 (左上)
    PlayerComponent player = PlayerComponent()
      ..size = Sizes().playerAreaSize
      ..position = Sizes().playerAreaPosition;

    characterArea.addAll([player]);

    var playerAnimation = SpriteAnimationComponent.fromFrameData(
        await Flame.images.load('noBKG_KnightIdle_strip.png'),
        SpriteAnimationData.sequenced(
          textureSize: Vector2.all(64),
          amount: 15,
          stepTime: 0.08,
        ))
      ..anchor = Anchor.bottomCenter
      ..size = Vector2(128, 128)
      ..position =
          Vector2(Sizes().playerAreaWidth / 2, Sizes().playerAreaHeight);

    player.add(playerAnimation);
    player.add(PlayerHpBar());
  }


  void _addMap(List<List<Event>> stageList, int currentStage) {
    final mapArea = MapAreaComponent(
      position: Sizes().mapAreaPosition,
      size: Sizes().mapAreaSize, // カードエリアのサイズ
    );
    add(mapArea);

    int stageNum = stageList.length;
    var totalMapWidth = Sizes().mapWidth + Sizes().mini_margin;

    stageList.asMap().forEach((depth, stages) {
      final int choiceNum = stages.length;
      final totalMapHeight = Sizes().mapHeight + Sizes().mini_margin;

      Color color = depth == currentStage? Colors.green: Colors.black12;
      stages.asMap().forEach((choice, stage) {
        final button = ButtonComponent(
          button: RectangleComponent(
              size: Sizes().mapSize,
              paint: Paint()..color = color,
              priority: 0),
          onPressed: () {},
          children: [
            TextComponent(
              priority: 1,
              text: '$depth $choice',
              position: Sizes().mapSize,
              anchor: Anchor.center,
              textRenderer:
                  TextPaint(style: const TextStyle(color: Colors.white)),
            ),
          ],
        )..position = Vector2(
            depth * totalMapWidth +
                (Sizes().mapAreaWidth - (stageNum * totalMapWidth)) /
                    2, // X 座標を調整
          choice * totalMapHeight +
              (Sizes().mapAreaHeight - (choiceNum * totalMapHeight)) /
                  2
            // choice * (Sizes().mapWidth / 2 + Sizes().mini_margin)
          , // Y 座標を調整
          );
        // ..anchor = Anchor.center;

        mapArea.add(button);
      });
    });
  }

  void _addMapCards(List<List<Event>> stageList, int currentStage) {
    debugPrint("add map cards");

    List<Event> events = stageList[currentStage];


    // カードエリアを作成
    final mapCardArea = MapCardAreaComponent(
      position: Sizes().mapCardAreaPosition,
      size: Sizes().mapCardAreaSize, // カードエリアのサイズ
    );
    add(mapCardArea);

    // カードコンポーネントを作成し、カードエリアの中心に集める
    final cardAreaCenterX = Sizes().mapCardAreaWidth / 2;
    final cardAreaCenterY = Sizes().mapCardAreaHeight / 2;
    events.asMap().forEach((index, event) {

      final row = index ~/ 3;
      final col = index % 3;
      // final cardComponent = MapCardComponent(name: event.name)
      //   ..size = Sizes().mapCardSize
      //   ..anchor = Anchor.center
      //   ..position = Vector2(
      //     cardAreaCenterX +
      //         col * (Sizes().mapCardWidth + Sizes().mapCardMargin) -
      //         (Sizes().mapCardWidth + Sizes().mapCardMargin), // X 座標を調整
      //     cardAreaCenterY +
      //         row * (Sizes().mapCardHeight + Sizes().mapCardMargin) -
      //         (Sizes().mapCardHeight + Sizes().mapCardMargin) / 2, // Y 座標を調整
      //   ); // カードエリアの中心を基準に位置を計算

      final button = ButtonComponent(
        button: RectangleComponent(
            size: Sizes().mapCardSize,
            paint: Paint()..color = Colors.green,
            priority: 0),
        onPressed:() {
          game.router.pushNamed(ROUTE.battle.name);
        },
        children: [
          TextComponent(
            priority: 1,
            text: event.name,
            anchor: Anchor.center,
            position: Sizes().mapCardSize/2,
            textRenderer:
            TextPaint(style: const TextStyle(color: Colors.white)),
          ),
        ],
      )..anchor = Anchor.center
        ..position = Vector2(
          cardAreaCenterX +
              col * (Sizes().mapCardWidth + Sizes().mapCardMargin) -
              (Sizes().mapCardWidth + Sizes().mapCardMargin), // X 座標を調整
          cardAreaCenterY +
              row * (Sizes().mapCardHeight + Sizes().mapCardMargin) -
              (Sizes().mapCardHeight + Sizes().mapCardMargin) / 2, // Y 座標を調整
        );
      mapCardArea.add(button);

    });
  }

  void setCallback(Function fn) => stateCallbackHandler = fn;
}
