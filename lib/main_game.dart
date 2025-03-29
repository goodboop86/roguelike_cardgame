import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'dart:async';

import 'package:roguelike_cardgame/providers/sizes.dart';
import 'package:roguelike_cardgame/worlds/battle.dart';
import 'package:roguelike_cardgame/worlds/explore.dart';
import 'package:roguelike_cardgame/worlds/home.dart';

import 'models/enum.dart';

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

    add(
      router = RouterComponent(
        routes: {
          ROUTE.home.name: WorldRoute(HomePage.new),
          ROUTE.battle.name: WorldRoute(BattlePage.new, maintainState: false),
          ROUTE.explore.name: WorldRoute(ExplorePage.new, maintainState: false),
        },
        initialRoute: ROUTE.home.name,
      ),
    );
  }
}
