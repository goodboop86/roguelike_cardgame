import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'dart:async';

import 'package:roguelike_cardgame/providers/sizes.dart';
import 'package:roguelike_cardgame/spritesheet/spritesheet.dart';
import 'package:roguelike_cardgame/valueroutes/popup.dart';
import 'package:roguelike_cardgame/worlds/battle_event_world.dart';
import 'package:roguelike_cardgame/worlds/explore_world.dart';
import 'package:roguelike_cardgame/worlds/home.dart';
import 'package:roguelike_cardgame/worlds/person_event_world.dart';

import 'models/enum.dart';

class MainGame extends FlameGame
    with HasGameRef, RiverpodGameMixin, DragCallbacks {
  MainGame()
      : super(
      camera: CameraComponent.withFixedResolution(
          width: Sizes().gameWidth, height: Sizes().gameHeight));
  @override
  var debugMode = true;

  @override
  Color backgroundColor() => const Color.fromRGBO(89, 106, 108, 1.0);

  late final RouterComponent router;

  @override
  Future<void> onLoad() async {
    // animation
    await AssetSource().storeAnimation(
      path: 'dragon.png',
      key: ComponentKey.named("PlayerAnimation"),
      size: Vector2(128, 128),
      onStart: CharState.idle,
      srcSize: Vector2(64.0, 64.0),);

    // animation
    await AssetSource().storeSprite(
        path: 'background.png',
        key: ComponentKey.named("Background"),
        size: Vector2(416, 576));

    Sizes().gameSize;

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
      baseVelocity: Vector2(0.1, 0),
      size: Sizes().gameSize,
      position: Sizes().origin,
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
}
