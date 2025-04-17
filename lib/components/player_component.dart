import 'package:flame/events.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../models/enum.dart';
import '../providers/player_provider.dart';
import '../providers/sizes.dart';
import '../spritesheet/spritesheet.dart';

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
    final playerState = ref.watch(playerProvider);
    TextPainter(
      text: TextSpan(
          text: playerState.toJsonString(),
          style: const TextStyle(color: Colors.white)),
      textDirection: TextDirection.ltr,
    )
      ..layout(maxWidth: size.x)
      ..paint(canvas, Vector2(0, 0).toOffset());
  }

  @override
  void onTapUp(TapUpEvent event) {
    game.overlays.add(OVERLAY.characterOverlay.name);
    game.pauseEngine();
  }
}

class PlayerHpBar extends PositionComponent with RiverpodComponentMixin {
  late double _hp;
  late double _maxHp;
  bool _isInitialized = false;

  PlayerHpBar({hp, maxHp}) {
    size = Vector2(100, 10);
    position = Vector2(0, 0);
    anchor = Anchor.topLeft;
  }

  @override
  Future<void> onMount() async {
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

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (_isInitialized) {
      hp = ref.watch(playerProvider).health;

      // 背景
      canvas.drawRect(
        size.toRect(),
        Paint()..color = Colors.grey,
      );

      // HPバー
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.x * (_hp / _maxHp), size.y),
        Paint()..color = Colors.green,
      );
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
