import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'dart:async';

import 'package:roguelike_cardgame/providers/sizes.dart';
import 'package:roguelike_cardgame/spritesheet/spritesheet.dart';
import 'package:roguelike_cardgame/worlds/battle_event_world.dart';
import 'package:roguelike_cardgame/worlds/explore_world.dart';
import 'package:roguelike_cardgame/worlds/home.dart';
import 'package:roguelike_cardgame/worlds/person_event_world.dart';

import 'components/background_component.dart';
import 'components/basic_component.dart';
import 'models/enum.dart';

class MainGame extends FlameGame
    with HasGameRef, RiverpodGameMixin, DragCallbacks {
  MainGame()
      : super(
            camera: CameraComponent.withFixedResolution(
                width: Sizes.gameWidth, height: Sizes.gameHeight));

  Logger log = Logger('MainGame');
  @override
  var debugMode = true;

  @override
  // Color backgroundColor() => const Color.fromRGBO(89, 106, 108, 1.0);
  Color backgroundColor() => Colors.black;

  late final RouterComponent router;

  @override
  Future<void> onLoad() async {
    // Singleton
    CANVAS.initialize(game.canvasSize);

    log.info(size);
    log.info(camera.viewport.virtualSize);
    log.info(camera.viewport.size);

    // animation
    await AssetSource().storeAnimation(
      path: 'player.png',
      key: ComponentKey.named("PlayerAnimation"),
      size: Vector2(128, 128),
      onStart: CharState.idle,
      srcSize: Vector2(64.0, 64.0),
    );

    await AssetSource().storeAnimation(
        path: 'dragon.png',
        key: ComponentKey.named("EnemyAnimation"),
        size: Vector2(128, 128),
        onStart: CharState.idle,
        srcSize: Vector2(64.0, 64.0),
        flip: true);

    // sprite
    await AssetSource().storeSpriteComponent(
        path: 'background.png',
        key: ComponentKey.named("Background"),
        size: Sizes.backgroundSize);

    await AssetSource().storeSprite(
        path: 'home.png',
        key: ComponentKey.named("home"),
        size: Sizes.blockSize);

    await AssetSource().storeSprite(
        path: 'question.png',
        key: ComponentKey.named("question"),
        size: Sizes.blockSize);

    await AssetSource().storeSprite(
        path: 'right_arrow.png',
        key: ComponentKey.named("right_arrow"),
        size: Sizes.blockSize);

    // parallax
    ParallaxComponent parallax = await loadParallaxComponent(
      [
        'parallax/1.png',
        'parallax/2.png',
        'parallax/3.png',
        'parallax/5.png',
        'parallax/6.png',
        'parallax/7.png',
        'parallax/8.png',
        'parallax/10.png'
      ].map((path) => ParallaxImageData(path)).toList(),
      baseVelocity: Vector2(1, 0),
      size: Sizes.gameSize,
      position: Sizes.gameTopLeft,
      velocityMultiplierDelta: Vector2(1.8, 1.0),
    );

    AssetSource().storeParallax(name: 'default', parallaxComponent: parallax);

    add(
      router = RouterComponent(
        routes: {
          ROUTE.home.name: WorldRoute(HomePage.new),
          ROUTE.battle.name:
              WorldRoute(BattleEventWorld.new, maintainState: false),
          ROUTE.person.name:
              WorldRoute(PersonEventWorld.new, maintainState: false),
          ROUTE.rest.name:
              WorldRoute(PersonEventWorld.new, maintainState: false),
          ROUTE.treasureChest.name:
              WorldRoute(PersonEventWorld.new, maintainState: false),
          ROUTE.explore.name:
              WorldRoute(ExploreWorld.new, maintainState: false),
        },
        initialRoute: ROUTE.home.name,
      ),
    );

    super.onLoad();
  }

  Future<void> routeWithFadeOut(
      {required String message, required Event event}) async {
    log.info("start FadeOut.");

    final localDarkenOverlay = OverlayBackground.fadeOut();

    // SequenceEffect を使用して、複数のエフェクトを順番に実行
    localDarkenOverlay.add(
      SequenceEffect(
        [
          OpacityEffect.to(
            1.0,
            EffectController(startDelay: 0.2, duration: 0.5),
          ),
          RemoveEffect(delay: 1.0)
        ],
        onComplete: () {
          router.currentRoute.remove(localDarkenOverlay);
          router.pushNamed(event.name);
        },
      ),
    );

    router.currentRoute.add(localDarkenOverlay);

  }

  Future<void> fadeIn(
      {required String message, required Function onComplete}) async {
    log.info("start fadeIn.");

    RectangleComponent darkenOverlay = OverlayBackground()
      ..size = canvasSize
      ..anchor = Anchor.center
      ..position = canvasSize / 2
      ..paint.color = Colors.black.withValues(alpha: 1.0)
      ..priority = 1000;

    router.currentRoute.add(darkenOverlay);
    darkenOverlay.add(transitionText
      ..text = message
      ..position = canvasSize / 2);

    // SequenceEffect を使用して、複数のエフェクトを順番に実行
    await darkenOverlay.add(
      SequenceEffect(
        [
          // 暗転アニメーション
          OpacityEffect.to(
            0.0,
            EffectController(startDelay: 0.2, duration: 0.5),
          ),
        ],
        onComplete: () {
          router.currentRoute.remove(darkenOverlay);
          onComplete();
        },
      ),
    );
  }
}
