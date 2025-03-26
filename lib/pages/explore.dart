import 'package:flame/components.dart' hide Timer;
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:roguelike_cardgame/main_game.dart';
import 'package:roguelike_cardgame/providers/sizes.dart';

import 'dart:async';

import '../components/card_area_component.dart';
import '../components/card_component.dart';
import '../components/player_component.dart';
import '../models/card.dart';
import '../models/card_effect.dart';
import '../systems/dungeon.dart';
import '../systems/event_probabilities.dart';

class ExplorePage extends Component
    with HasGameRef<MainGame>, RiverpodComponentMixin {
  late Function stateCallbackHandler;
  final List<MapCardComponent> _cards = []; // カードリストをキャッシュ

  @override
  Future<void> onLoad() async {
    int currentStage = 3;
    super.onLoad();
    Sizes().setScreenSize(game.size);

    await _addCharacters();
    _addButtons();
    List<List<Event>> stageList = generateNestedListWithFixedLength(11, 1, 3);
    _addMap(stageList);
    _addMapCards(stageList, currentStage);
  }

  void _enemyTurn() {
    final card = ActionCard(
      name: 'EnemyCard',
      effect: PlayerDamageEffect(),
    );

    final timerComponent = TimerComponent(
      period: 1,
      onTick: () async {
        card.effect.call(ref);

        await Future.delayed(const Duration(seconds: 1));

        _playerTurn();
      },
      removeOnFinish: true,
    );

    // RectangleComponentをTimerComponentの子として追加
    timerComponent.add(RectangleComponent(
      size: Vector2(200, 200),
      position: Sizes().screenSize / 2,
      anchor: Anchor.center,
      paint: Paint()..color = Colors.black87,
    ));

    // TextComponentをTimerComponentの子として追加
    timerComponent.add(TextComponent(
      text: 'Enemy Turn',
      position: Sizes().screenSize / 2,
      anchor: Anchor.center,
      textRenderer: TextPaint(style: const TextStyle(color: Colors.white)),
    ));

    // TimerComponentをゲームに追加
    add(timerComponent);

    // タイマーを開始
    timerComponent.timer.start();
  }

  void _playerTurn() {
    final timerComponent = TimerComponent(
      period: 1,
      onTick: () {
        debugPrint("PlayerTurn start!");
      },
      removeOnFinish: true,
    );

    // RectangleComponentをTimerComponentの子として追加
    timerComponent.add(RectangleComponent(
      size: Vector2(200, 200),
      position: Sizes().screenSize / 2,
      anchor: Anchor.center,
      paint: Paint()..color = Colors.black87,
    ));

    // TextComponentをTimerComponentの子として追加
    timerComponent.add(TextComponent(
      text: 'Player Turn',
      position: Sizes().screenSize / 2,
      anchor: Anchor.center,
      textRenderer: TextPaint(style: const TextStyle(color: Colors.white)),
    ));

    // TimerComponentをゲームに追加
    add(timerComponent);

    // タイマーを開始
    timerComponent.timer.start();
  }

  Future<void> _addCharacters() async {
    final characterArea = CharacterAreaComponent(
        key: ComponentKey.named('ExploreCharacterArea'),
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

  void _addButtons() {
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
        _enemyTurn();
      }
    ];

    final buttonAreaCenterX = Sizes().buttonAreaWidth / 2;
    final buttonAreaCenterY = Sizes().buttonAreaHeight / 2;
    buttonOnPressedFunctions.asMap().forEach((index, function) {
      final button = ButtonComponent(
        button: RectangleComponent(
            size: Sizes().buttonSize,
            paint: Paint()..color = Colors.brown,
            priority: 0),
        onPressed: function,
        children: [
          TextComponent(
            priority: 1,
            text: '$index',
            position: Sizes().buttonSize / 2,
            anchor: Anchor.center,
            textRenderer:
                TextPaint(style: const TextStyle(color: Colors.white)),
          ),
        ],
      )
        ..position = Vector2(
          buttonAreaCenterX +
              index * (Sizes().buttonWidth + Sizes().margin) -
              (Sizes().buttonWidth + Sizes().margin), // X 座標を調整
          buttonAreaCenterY, // Y 座標を調整
        )
        ..anchor = Anchor.center;
      buttonArea.add(button);
    });
  }

  void _addMap(List<List<Event>> stageList) {
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
      stages.asMap().forEach((choice, stage) {
        final button = ButtonComponent(
          button: RectangleComponent(
              size: Sizes().mapSize,
              paint: Paint()..color = Colors.amber,
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
      position: Sizes().cardAreaPosition,
      size: Sizes().cardAreaSize, // カードエリアのサイズ
    );
    add(mapCardArea);

    // カードコンポーネントを作成し、カードエリアの中心に集める
    final cardAreaCenterX = Sizes().cardAreaWidth / 2;
    final cardAreaCenterY = Sizes().cardAreaHeight / 2;
    events.asMap().forEach((index, event) {

      final row = index ~/ 3;
      final col = index % 3;
      final cardComponent = MapCardComponent(name: event.name)
        ..size = Sizes().cardSize
        ..anchor = Anchor.center
        ..position = Vector2(
          cardAreaCenterX +
              col * (Sizes().cardWidth + Sizes().cardMargin) -
              (Sizes().cardWidth + Sizes().cardMargin), // X 座標を調整
          cardAreaCenterY +
              row * (Sizes().cardHeight + Sizes().cardMargin) -
              (Sizes().cardHeight + Sizes().cardMargin) / 2, // Y 座標を調整
        ); // カードエリアの中心を基準に位置を計算
      mapCardArea.add(cardComponent);

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
