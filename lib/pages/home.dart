import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:roguelike_cardgame/models/enum.dart';
import 'package:roguelike_cardgame/providers/explore_route_provider.dart';

import '../main_game.dart';

class HomePage extends World
    with HasGameReference<MainGame>, RiverpodComponentMixin {
  late final ButtonComponent button;

  void _start() {
    ref.read(exploreRouteProvider.notifier).initialize(
          stageLength: 11,
          minChoice: 1,
          maxChoice: 3,
        );
    ref.read(exploreRouteProvider.notifier).incrementStage();
    game.router.pushNamed(ROUTE.explore.name);
  }

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
        paint: BasicPalette.lightBlue.paint(),
        anchor: Anchor.topLeft,
      ),
      anchor: Anchor.topLeft,
      onPressed: () {
        _start();
      },
    )..anchor = Anchor.center;

    add(button);
  }
}
