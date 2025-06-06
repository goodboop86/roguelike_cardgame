import 'package:flame/components.dart' hide Timer;
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:roguelike_cardgame/main_game.dart';
import 'package:roguelike_cardgame/mixin/has_common_area.dart';
import 'package:roguelike_cardgame/mixin/has_battle_area.dart';

import 'dart:async';

import '../components/card_area_component.dart';
import '../mixin/has_explore_area.dart';
import '../providers/explore_route_provider.dart';

class ExploreWorld extends World
    with
        HasGameRef<MainGame>,
        RiverpodComponentMixin,
        HasBattleArea,
        HasCommonArea,
        HasExploreArea {
  Logger log = Logger('ExplorePage');

  @override
  Future<void> onLoad() async {
    super.onLoad();
  }

  @override
  void onMount() {
    game.fadeIn(message: '', onComplete: () {});

    addToGameWidgetBuild(() async {
      ExploreRouteState state = ref.read(exploreRouteProvider);

      Component? background = game.findByKey(ComponentKey.named("Background"));
      if (background == null) {
        log.fine("addBackgrounds");
        addBackgrounds();
      }

      var characterArea = children.whereType<CharacterAreaComponent>();
      var mapArea = children.whereType<MapAreaComponent>();
      var mapCardArea = children.whereType<MapCardAreaComponent>();
      var bottomArea = children.whereType<BottomUiAreaComponent>();
      var topUiArea = children.whereType<TopUiAreaComponent>();


      if (background != null) {
        if (characterArea.isEmpty & background.isMounted) {
          log.fine("addCharacters");
          await addCharacters();
        }
        if (mapArea.isEmpty & background.isMounted) {
          log.fine("addMap");
          addMap(state.stageList, state.stage);
        }
        if (mapCardArea.isEmpty & background.isMounted) {
          log.fine("addMapCards");
          addMapCards(state.stageList, state.stage);
        }
        if (bottomArea.isEmpty & background.isMounted) {
          log.fine("addBottomUI");
          addBottomUi();
        }
        if (topUiArea.isEmpty & background.isMounted) {
          log.fine("addTopUI");
          addTopUi();
        }
      }
    });

    super.onMount();
  }
}
