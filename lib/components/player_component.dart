import 'package:flame/events.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:roguelike_cardgame/components/text_component.dart';
import 'package:roguelike_cardgame/main_game.dart';
import 'package:roguelike_cardgame/providers/enemy_provider.dart';

import '../models/enum.dart';
import '../providers/player_provider.dart';
import '../providers/sizes.dart';
import '../spritesheet/spritesheet.dart';
import 'button_component.dart';

class PlayerComponent extends PositionComponent
    with RiverpodComponentMixin, TapCallbacks, HasGameRef {
  PlayerComponent({required super.key, required String path})
      : super(priority: 10, children: [
          AssetSource().getAnimation(name: path)!
            ..anchor = Anchor.bottomCenter
            ..position =
                Vector2(Sizes.playerAreaWidth / 2, Sizes.playerAreaHeight),
          PlayerHpBar()
        ]);

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void onTapUp(TapUpEvent event) {
    game.overlays.add(OVERLAY.characterOverlay.name);
    game.pauseEngine();
  }
}

class PlayerHpBar extends PositionComponent with RiverpodComponentMixin, HasGameRef<MainGame> {
  late double _hp;
  late double _maxHp;
  late String? currentRouteName;
  bool _isInitialized = false;

  PlayerHpBar({hp, maxHp}) {
    size = Vector2(100, 10);
    position = Vector2((Sizes.playerAreaWidth-size.x)/2, 0);
    anchor = Anchor.topLeft;
  }

  @override
  Future<void> onMount() async {
    currentRouteName = game.router.currentRoute.name;

    addToGameWidgetBuild(() async {
      _maxHp = ref.read(playerProvider).maxHealth;
      _hp = ref.read(playerProvider).maxHealth;
      _isInitialized = true;
    });
    super.onMount();
  }

  set hp(double value) {
    _hp = value.clamp(0, _maxHp);
  }

  double get hp => _hp;

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (_isInitialized && currentRouteName == ROUTE.battle.name) {
      hp = ref.watch(playerProvider).health;

      // 背景
      final backgroundPaint = Paint()..color = Colors.grey;
      canvas.drawRect(
        size.toRect(),
        backgroundPaint,
      );

      // HPバー
      final hpPaint = Paint()..color = Colors.green;
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.x * (hp / _maxHp), size.y),
        hpPaint,
      );

      // HPバーの枠線 (同じ Rect を使用)
      final borderPaint = Paint()
        ..color = Colors.black // 枠線の色
        ..style = PaintingStyle.stroke // 枠線スタイル (塗りつぶしではなく線)
        ..strokeWidth = 1; // 枠線の太さ

      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.x * (_hp / _maxHp), size.y),
        borderPaint,
      );

      // 全体の枠線 (背景と同じ Rect を使用)
      canvas.drawRect(
        size.toRect(),
        borderPaint,
      );

    }
  }
}

class PlayerStatus extends PositionComponent with RiverpodComponentMixin, HasGameRef<MainGame> {
  bool _isInitialized = false;

  final heartButton = SpriteButtons.heartButton(onPressed: () {});
  final manaButton = SpriteButtons.manaButton(onPressed: () {});
  final enemyIcon = SpriteButtons.enemyIconButton(onPressed: () {});
  final TextPaint _textPaint = TextPaints.base();

  PlayerStatus() {
    // size = Vector2(100, 10);
    position = Vector2(0, 0);
    anchor = Anchor.topLeft;
  }

  @override
  Future<void> onMount() async {

    addAll([heartButton, manaButton]);

    addToGameWidgetBuild(() async {
      _isInitialized = true;
    });
    super.onMount();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (_isInitialized) {
      var playerState = ref.watch(playerProvider);
      _textPaint.render(canvas,
          '${playerState.health.toInt()} / ${playerState.maxHealth.toInt()}',
          heartButton.position + Vector2(Sizes.blockLength / 1.5, 0));
      _textPaint.render(canvas, '${playerState.mana} / ${playerState.maxMana}',
          manaButton.position + Vector2(Sizes.blockLength / 1.5, 0));
    }
  }
}


class CharacterAnimationComponent<SpriteType>
    extends SpriteAnimationGroupComponent
    with RiverpodComponentMixin, TapCallbacks, HasGameRef {
  Logger log = Logger('CharacterAnimationComponent');

  CharacterAnimationComponent({
    required super.key,
    required sheet,
    super.size,
    super.position,
    super.anchor,
    super.priority,
    super.current,
  }) {
    super.animations = {
      CharState.idle: sheet.createAnimation(row: 0, stepTime: 0.3, to: 2),
      CharState.ready: sheet.createAnimation(row: 1, stepTime: 0.3, to: 2),
      CharState.run: sheet.createAnimation(row: 2, stepTime: 0.15, to: 4),
      CharState.crawl: sheet.createAnimation(row: 3, stepTime: 0.15, to: 4),
      CharState.climb: sheet.createAnimation(row: 4, stepTime: 0.3, to: 2),
      CharState.jump:
          sheet.createAnimation(row: 5, stepTime: 0.2, to: 3, loop: false),
      CharState.push:
          sheet.createAnimation(row: 6, stepTime: 0.2, to: 3, loop: false),
      CharState.jab:
          sheet.createAnimation(row: 7, stepTime: 0.2, to: 3, loop: true),
      CharState.slash:
          sheet.createAnimation(row: 8, stepTime: 0.15, to: 4, loop: false),
      CharState.shot:
          sheet.createAnimation(row: 9, stepTime: 0.15, to: 4, loop: false),
      CharState.fire:
          sheet.createAnimation(row: 10, stepTime: 0.3, to: 2, loop: false),
      CharState.block:
          sheet.createAnimation(row: 11, stepTime: 0.3, to: 2, loop: false),
      CharState.death:
          sheet.createAnimation(row: 12, stepTime: 0.2, to: 3, loop: false),
      CharState.roll:
          sheet.createAnimation(row: 13, stepTime: 0.067, to: 9, loop: false)
    };

    animationTickers?[CharState.jump]?.onComplete = () {
      log.info("jumped!");
      current = CharState.slash;
    };
    animationTickers?[CharState.slash]?.onComplete = () {
      log.info("slashed!");
      current = CharState.jump;
    };
    animationTickers?[CharState.idle]?.onStart = () {
      log.info("idle!");
    };
  }
}
