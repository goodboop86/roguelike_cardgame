import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:roguelike_cardgame/pages/battle.dart';
import 'package:roguelike_cardgame/pages/home.dart';
import 'dart:async';

class MainGame extends FlameGame with HasGameRef, RiverpodGameMixin, HasWorldReference {
  @override
  var debugMode = true;

  @override
  Color backgroundColor() => const Color.fromRGBO(89, 106, 108, 1.0);

  late final RouterComponent router;

  @override
  Future<void> onLoad() async {

    add(
      router = RouterComponent(
        routes: {
          'home': Route(HomePage.new),
          'battle': Route(BattlePage.new, maintainState: false),
        },
        initialRoute: 'home',
      ),
    );


  }
}
