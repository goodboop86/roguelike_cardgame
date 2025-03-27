import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:roguelike_cardgame/pages/battle.dart';
import 'package:roguelike_cardgame/pages/explore.dart';
import 'package:roguelike_cardgame/pages/home.dart';
import 'dart:async';

import 'package:roguelike_cardgame/providers/sizes.dart';

class MainGame extends FlameGame
    with HasGameRef, RiverpodGameMixin, DragCallbacks {
  @override
  var debugMode = true;

  @override
  Color backgroundColor() => const Color.fromRGBO(89, 106, 108, 1.0);

  late final RouterComponent router;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    Sizes().setScreenSize(size);
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
        size: Vector2(game.size.x, game.size.y/2.7),
      position: Vector2(0, 0),
      velocityMultiplierDelta: Vector2(1.8, 1.0),
    );
    add(parallaxComponent);

    add(
      router = RouterComponent(
        routes: {
          'home': WorldRoute(HomePage.new),
          'battle': WorldRoute(BattlePage.new, maintainState: false),
          'explore': WorldRoute(ExplorePage.new, maintainState: false),
        },
        initialRoute: 'home',
      ),
    );
  }
}
