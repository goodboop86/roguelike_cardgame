import 'package:flame/components.dart' hide Timer;
import 'package:flame/input.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:logging/logging.dart';
import 'package:roguelike_cardgame/main_game.dart';
import 'package:roguelike_cardgame/mixin/world_mixin.dart';
import 'package:roguelike_cardgame/providers/sizes.dart';

import 'dart:async';

import '../components/card_area_component.dart';
import '../models/card.dart';
import '../models/card_effect.dart';
import '../models/enum.dart';
import '../providers/battle_route_provider.dart';

class PersonEventWorld extends World
    with HasGameRef<MainGame>, RiverpodComponentMixin, WorldMixin {
  Logger log = Logger('PersonEventWorld');

  @override
  Future<void> onMount() async {
    addToGameWidgetBuild(() async {
      BattleRouteState state = ref.read(battleRouteProvider);
      log.config(state.toJsonString());

      var characterArea = children.whereType<CharacterAreaComponent>();
      if (characterArea.isEmpty) {
        log.fine("addCharacters");
        await addCharacters(game.loadParallaxComponent);
      }


    });

    super.onMount();
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

  }

}
