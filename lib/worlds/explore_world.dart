import 'package:flame/components.dart' hide Timer;
import 'package:flame/parallax.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:roguelike_cardgame/main_game.dart';
import 'package:roguelike_cardgame/mixin/world_mixin.dart';

import 'dart:async';

import '../components/card_area_component.dart';
import '../models/enum.dart';
import '../providers/explore_route_provider.dart';
import '../providers/sizes.dart';
import '../spritesheet/spritesheet.dart';

class ExploreWorld extends World
    with HasGameRef<MainGame>, RiverpodComponentMixin, WorldMixin {
  Logger log = Logger('ExplorePage');

  @override
  Future<void> onLoad() async {
    super.onLoad();
  }

  @override
  void onMount() {
    addToGameWidgetBuild(() async {
      ExploreRouteState state = ref.read(exploreRouteProvider);
      var mapArea = children.whereType<MapAreaComponent>();
      if (mapArea.isEmpty) {
        log.fine("addMap");
        addMap(state.stageList, state.stage);
      }
      var mapCardArea = children.whereType<MapCardAreaComponent>();
      if (mapCardArea.isEmpty) {
        log.fine("addMapCards");
        addMapCards(state.stageList, state.stage, game.router, ref);
      }
      var characterArea = children.whereType<CharacterAreaComponent>();
      if (characterArea.isEmpty) {
        log.fine("addCharacters");
        await addCharacters(
            loadParallaxComponent: game.loadParallaxComponent, ref: ref);
      }
    });

    super.onMount();
  }
}
