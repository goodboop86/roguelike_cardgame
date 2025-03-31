
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

import '../components/card_area_component.dart';
import '../components/card_component.dart';
import '../components/enemy_component.dart';
import '../components/player_component.dart';
import '../models/card.dart';
import '../models/card_effect.dart';
import '../models/enum.dart';
import '../providers/sizes.dart';

mixin WorldMixin on Component {
  Future<void> addSingleCharacters(loadParallaxComponent) async {
    final parallaxComponent = await loadParallaxComponent(
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

  Future<void> addCharacters(loadParallaxComponent) async {
    final parallaxComponent = await loadParallaxComponent(
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
      ..size = Vector2(128, 128)
      ..position =
      Vector2(Sizes().playerAreaWidth / 2, Sizes().playerAreaHeight);

    var enemyAnimation = SpriteAnimationComponent.fromFrameData(
        await Flame.images.load('noBKG_KnightIdle_strip.png'),
        SpriteAnimationData.sequenced(
          textureSize: Vector2.all(64),
          amount: 15,
          stepTime: 0.08,
        ))
      ..anchor = Anchor.bottomCenter
      ..size = Vector2(128, 128)
      ..position = Vector2(Sizes().enemyAreaWidth / 2, Sizes().enemyAreaHeight)
      ..flipHorizontally();

    player.add(playerAnimation);
    player.add(PlayerHpBar());
    enemy.add(enemyAnimation);
    enemy.add(EnemyHpBar());
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

  void addMapCards(List<List<Event>> stageList, int currentStage, router) {

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

      final button = ButtonComponent(
        button: RectangleComponent(
            size: Sizes().mapCardSize,
            paint: Paint()..color = Colors.green,
            priority: 0),
        onPressed: () {
          router.pushNamed(event.name);
        },
        children: [
          TextComponent(
            priority: 1,
            text: event.name,
            anchor: Anchor.center,
            position: Sizes().mapCardSize / 2,
            textRenderer:
            TextPaint(style: const TextStyle(color: Colors.white)),
          ),
        ],
      )
        ..anchor = Anchor.center
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


  void addCards(int _) {

    // カードエリアを作成
    final cardArea = CardAreaComponent(
      position: Sizes().cardAreaPosition,
      size: Sizes().cardAreaSize, // カードエリアのサイズ
    );
    add(cardArea);

    // カードのリストを作成
    final cards = <Card_>[];
    final cardDetails = [
      AllDamageEffect(),
      AllDamageEffect(),
      AllDamageEffect(),
      PlayerHealEffect(),
      BuffEffect(),
      DebuffEffect(),
    ];
    cardDetails.asMap().forEach((index, effect) {
      // asMap() と forEach() を使用
      final card = Card_(
        effect: effect,
      );
      cards.add(card);
    });

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


  Future<void> startTransition(Vector2 size) async {
    print("called.");
    final darkenOverlay = RectangleComponent(
      size: size,
      paint: Paint()
        ..color = Colors.black.withValues(alpha: 0),
      priority: 1000,
      position: Sizes().origin
    );

    add(darkenOverlay);
    // SequenceEffect を使用して、複数のエフェクトを順番に実行
    await darkenOverlay.add(
      SequenceEffect(
        [
          // 暗転アニメーション
          OpacityEffect.to(1, EffectController(duration: 0.5)),
          // 待機
          OpacityEffect.to(1, EffectController(duration: 0.5), onComplete: () => (print("wait complete"))),
          // 明転アニメーション
          OpacityEffect.to(0, EffectController(duration: 0.5)),
        ],
        onComplete: () {
          remove(darkenOverlay);
          // 画面遷移処理
          // ...
        },
      ),
    );
  }



}