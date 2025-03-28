
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:roguelike_cardgame/models/enum.dart';
import 'package:roguelike_cardgame/providers/explore_route_provider.dart';

import '../main_game.dart';
import '../providers/battle_route_provider.dart';

class HomePage extends World with HasGameReference<MainGame>, RiverpodComponentMixin {
  late final ButtonComponent button;

  @override
  Future<void> onLoad() async {
    button = ButtonComponent(
      button: RectangleComponent(
        size: Vector2(150, 50),
        paint: BasicPalette.blue.paint(),
        anchor: Anchor.topLeft,
      ),
      buttonDown: RectangleComponent(
        size: Vector2(150, 50),
        paint: BasicPalette.blue.paint(),
        anchor: Anchor.topLeft,
      ),
      anchor: Anchor.topLeft,
      onPressed: () {
        ref.read(exploreRouteProvider.notifier).initialize();
        ref.read(exploreRouteProvider.notifier).incrementStage();
        game.router.pushNamed(ROUTE.explore.name);
      },
    )..anchor = Anchor.center;

    add(button);
  }
}
