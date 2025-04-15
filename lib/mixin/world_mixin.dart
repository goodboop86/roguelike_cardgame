import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:roguelike_cardgame/main_game.dart';
import 'package:roguelike_cardgame/models/enemy_state.dart';
import 'package:roguelike_cardgame/models/player_state.dart';
import 'package:roguelike_cardgame/providers/deck_provider.dart';
import 'package:roguelike_cardgame/providers/player_provider.dart';

import '../components/BackgroundComponent.dart';
import '../components/basic_component.dart';
import '../components/button_component.dart';
import '../components/card_area_component.dart';
import '../components/card_component.dart';
import '../components/enemy_component.dart';
import '../components/player_component.dart';
import '../models/card.dart';
import '../models/enum.dart';
import '../providers/enemy_provider.dart';
import '../providers/sizes.dart';
import '../spritesheet/spritesheet.dart';

mixin WorldMixin on Component, HasGameRef<MainGame> {
  Logger log = Logger('WorldMixin');

  Future<void> addBackgrounds() async {
    add(AssetSource().getParallax(name: "default")!);

    log.info("---> ${Sizes().gameEndY}");
    add(AssetSource().getSprite(name: "background.png")!
      ..position = Sizes().backgroundPosition
      ..priority = 0);
    addAll([topGradient, bottomGradient]);
  }

  Future<void> addCharacters(
      {required Function loadParallaxComponent,
      required ComponentRef ref}) async {
    // add(SpriteSource().getParallax(name: "default")!);

    final characterArea = CharacterAreaComponent(
      key: ComponentKey.named('BattleCharacterArea'),
      position: Sizes().characterAreaPosition,
      size: Sizes().characterAreaSize, // カードエリアのサイズ
    );
    add(characterArea);

    bool playerExists =
        characterArea.children.any((component) => component is PlayerComponent);
    if (!playerExists) {
      // Player の配置 (左上)
      PlayerComponent player =
          PlayerComponent(key: ComponentKey.named('Player'), path: 'player.png')
            ..size = Sizes().playerAreaSize
            ..position = Sizes().playerAreaPosition;

      characterArea.add(player);
    }

    bool enemyExists =
        characterArea.children.any((component) => component is EnemyComponent);
    if (!enemyExists) {
      // Player の配置 (左上)
      EnemyComponent enemy =
          EnemyComponent(key: ComponentKey.named('Enemy'), path: 'dragon.png')
            ..size = Sizes().enemyAreaSize
            ..position = Sizes().enemyAreaPosition;
      characterArea.add(enemy);
    }
  }

  void addMap(List<List<Event>> stageList, int currentStage) {
    final mapArea = MapAreaComponent(
      position: Sizes().mapAreaPosition,
      size: Sizes().mapAreaSize, // カードエリアのサイズ
    );
    add(mapArea);

    int stageNum = stageList.length;
    var totalMapWidth = Sizes().mapWidth + Sizes().miniMargin;

    stageList.asMap().forEach((depth, stages) {
      final int choiceNum = stages.length;
      final totalMapHeight = Sizes().mapHeight + Sizes().miniMargin;

      Color color = depth == currentStage ? Colors.green : Colors.black12;
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
                (Sizes().mapAreaHeight - (choiceNum * totalMapHeight)) / 2
            // choice * (Sizes().mapWidth / 2 + Sizes().mini_margin)
            , // Y 座標を調整
          );
        // ..anchor = Anchor.center;

        mapArea.add(button);
      });
    });
  }

  void addMapCards(List<List<Event>> stageList, int currentStage,
      RouterComponent router, ComponentRef ref) {
    // カードコンポーネントを作成し、カードエリアの中心に集める
    // final cardAreaCenterX = Sizes().mapCardAreaWidth / 2;
    // final cardAreaCenterY = Sizes().mapCardAreaHeight / 2;
    // events.asMap().forEach((index, event) {
    //   final row = index ~/ 3;
    //   final col = index % 3;
    //
    //   final button = ButtonComponent(
    //     button: RectangleComponent(
    //         size: Sizes().mapCardSize,
    //         paint: Paint()..color = Colors.green,
    //         priority: 0),
    //     onReleased: () {
    //       game.router.pushNamed(event.name);
    //     },
    //     children: [
    //       TextComponent(
    //         priority: 1,
    //         text: event.name,
    //         anchor: Anchor.center,
    //         position: Sizes().mapCardSize / 2,
    //         textRenderer:
    //             TextPaint(style: const TextStyle(color: Colors.white)),
    //       ),
    //     ],
    //   )
    //     ..anchor = Anchor.center
    //     ..position = Vector2(
    //       cardAreaCenterX +
    //           col * (Sizes().mapCardWidth + Sizes().mapCardMargin) -
    //           (Sizes().mapCardWidth + Sizes().mapCardMargin), // X 座標を調整
    //       cardAreaCenterY +
    //           (Sizes().blockSize + Sizes().mapCardMargin) / 2, // Y 座標を調整
    //     );
    //   mapCardArea.add(button);
    // });

    List<Event> events = stageList[currentStage];

    // カードエリアを作成
    double mapCardWidth_ = Sizes().mapCardWidth + Sizes().mapCardMargin;
    double mapCardAreaWidth =
        events.length * mapCardWidth_ - Sizes().mapCardMargin;

    Vector2 mapCardAreaSize =
        Vector2(mapCardAreaWidth, Sizes().mapCardAreaHeight);

    double mapCardAreaX =
        Sizes().gameOriginX + (Sizes().gameWidth - mapCardAreaWidth) / 2;
    Vector2 mapCardAreaPosition = Vector2(mapCardAreaX, Sizes().mapCardAreaY);

    final mapCardArea = MapCardAreaComponent(
      position: mapCardAreaPosition,
      size: mapCardAreaSize,
      anchor: Anchor.topLeft,
    );
    add(mapCardArea);

    // Debug
    AdvancedButtonComponent executeButton = AdvancedButtonComponent(
        defaultLabel: TextComponent(
          priority: 1,
          text: "default",
          anchor: Anchor.center,
          position: Sizes().mapCardSize / 2,
          textRenderer: TextPaint(style: const TextStyle(color: Colors.white)),
        ),
        disabledLabel: TextComponent(
          priority: 1,
          text: "disable",
          anchor: Anchor.center,
          position: Sizes().mapCardSize / 2,
          textRenderer: TextPaint(style: const TextStyle(color: Colors.white)),
        ),
        defaultSkin: RectangleComponent(
          size: Sizes().wideButtonSize,
          paint: Paint()..color = Colors.red,
          position: Vector2(0, 0),
        ),
        disabledSkin: RectangleComponent(
          size: Sizes().wideButtonSize,
          paint: Paint()..color = Colors.grey,
          position: Vector2(0, 0),
        ),
        onPressed: () {
          mapCardArea.pupUp();
        })
      ..position = Vector2((mapCardAreaWidth - Sizes().wideButtonWidth) / 2,
          5 * Sizes().blockSize)
      ..isDisabled = true;

    mapCardArea.add(executeButton);

    events.asMap().forEach((index, event) {
      // debug
      RectangleComponent noSelected = RectangleComponent(
        size: Sizes().mapCardSize,
        paint: Paint()..color = Colors.blue, // 青色で塗りつぶし
        position: Vector2(0, 0), // 描画位置 (左上隅の座標)
      );

      RectangleComponent selected = RectangleComponent(
        size: Sizes().mapCardSize,
        paint: Paint()..color = Colors.red, // 青色で塗りつぶし
        position: Vector2(0, 0), // 描画位置 (左上隅の座標)
      );

      final key = ComponentKey.unique();

      ChoiceButtonComponent button = ChoiceButtonComponent<Event>(
          priority: 30,
          position: Vector2(0, 0),
          defaultSkin: noSelected,
          defaultSelectedSkin: selected,
          key: key,
          value: event)
        ..position = Vector2(mapCardWidth_ * index, Sizes().blockSize);

      mapCardArea.add(button
        ..onSelectedChanged = (bool val) {
          if (val) {
            mapCardArea.disableAllStageExclusive(key: key);
          }
          mapCardArea.updateExecuteButton(isSelected: val);
        });

      log.info("add ToggleButtonComponent");
    });

    // toggleButton.isSelected = true;
  }

  void addCards(List<Card_> cards) {
    // カードエリアを作成
    final cardArea = CardAreaComponent(
      position: Sizes().cardAreaPosition,
      size: Sizes().cardAreaSize, // カードエリアのサイズ
    );
    add(cardArea);

    // カードコンポーネントを作成し、カードエリアの中心に集める
    final cardAreaCenterX = Sizes().cardAreaWidth / 2;
    final cardAreaCenterY = Sizes().cardAreaHeight / 2;
    const colSize = 3; // 横方向のコンポーネントの数
    cards.asMap().forEach((index, card) {
      final row = index ~/ colSize;
      final col = index % colSize;
      final cardComponent = CardComponent(card: card)
        ..size = Sizes().cardSize
        ..anchor = Anchor.center
        ..position = Vector2(
          cardAreaCenterX +
              (col - 1) * (Sizes().cardWidth + Sizes().cardMargin), // X 座標を調整
          cardAreaCenterY +
              (row - 0.5) *
                  (Sizes().cardHeight + Sizes().cardMargin), // Y 座標を調整
        ); // カードエリアの中心を基準に位置を計算
      cardArea.add(cardComponent);
    });
  }

  Future<void> startTransition(
      {required String message, required Function next}) async {
    log.info("startTransition.");

    add(darkenOverlay);

    // SequenceEffect を使用して、複数のエフェクトを順番に実行
    await darkenOverlay.add(
      SequenceEffect(
        [
          // 暗転アニメーション
          OpacityEffect.to(
              0.6, EffectController(startDelay: 0.2, duration: 0.5),
              onComplete: () => {
                    darkenOverlay.add(transitionText
                      ..text = message
                      ..position = Sizes().gameSize / 2)
                  }),
          // 待機
          OpacityEffect.to(0.6, EffectController(duration: 0.5),
              onComplete: () => {darkenOverlay.remove(transitionText)}),
          // 明転アニメーション
          OpacityEffect.to(0, EffectController(duration: 0.5)),
        ],
        onComplete: () {
          next();
          remove(darkenOverlay);
          // 画面遷移処理
          // ...
        },
      ),
    );
  }
}
