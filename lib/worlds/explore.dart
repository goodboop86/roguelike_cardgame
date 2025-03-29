import 'package:flame/components.dart' hide Timer;
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:logging/logging.dart';
import 'package:roguelike_cardgame/main_game.dart';
import 'package:roguelike_cardgame/mixin/world_mixin.dart';
import 'package:roguelike_cardgame/providers/player_provider.dart';
import 'package:roguelike_cardgame/providers/sizes.dart';

import 'dart:async';

import '../components/card_area_component.dart';
import '../components/player_component.dart';
import '../models/enum.dart';
import '../providers/explore_route_provider.dart';
import '../systems/dungeon.dart';
import '../systems/event_probabilities.dart';

class ExplorePage extends World
    with HasGameRef<MainGame>, RiverpodComponentMixin, WorldMixin {
  Logger log = Logger('ExplorePage');
  late Function stateCallbackHandler;

  @override
  void onMount(){
    addToGameWidgetBuild(() async {
      ExploreRouteState state = ref.read(exploreRouteProvider);
      var mapArea = children.whereType<MapAreaComponent>();
      if(mapArea.isEmpty){
        log.fine("addMap");
        addMap(state.stageList, state.stage);
      }
      var mapCardArea = children.whereType<MapCardAreaComponent>();
      if(mapCardArea.isEmpty){
        log.fine("addMapCards");
        addMapCards(state.stageList, state.stage, game.router);
      }
      var characterArea = children.whereType<CharacterAreaComponent>();
      if(characterArea.isEmpty){
        log.fine("addCharacters");
        await addSingleCharacters(game.loadParallaxComponent);
        // await _addCharacters();
      }
    });

    super.onMount();
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
  }


  void setCallback(Function fn) => stateCallbackHandler = fn;
}
