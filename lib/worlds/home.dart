import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:roguelike_cardgame/components/button_component.dart';
import 'package:roguelike_cardgame/models/enum.dart';
import 'package:roguelike_cardgame/providers/explore_route_provider.dart';

import '../main_game.dart';

class HomePage extends World
    with HasGameReference<MainGame>, RiverpodComponentMixin {
  late final ButtonComponent button;

  void _start() {
    // ステージを作成し、1つ進める
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
    add(Buttons.basicButton(
        onPressed: () {
          _start();
        }));
  }
}
