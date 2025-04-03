import 'package:flame/components.dart' hide Timer;
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:roguelike_cardgame/main_game.dart';
import 'package:roguelike_cardgame/mixin/world_mixin.dart';

import 'dart:async';

import '../components/card_area_component.dart';
import '../models/enemy_state.dart';
import '../models/player_state.dart';
import '../providers/battle_route_provider.dart';
import '../providers/enemy_provider.dart';
import '../providers/player_provider.dart';

class PersonEventWorld extends World
    with HasGameRef<MainGame>, RiverpodComponentMixin, WorldMixin {
  Logger log = Logger('PersonEventWorld');

  @override
  Future<void> onMount() async {
    addToGameWidgetBuild(() async {
      BattleRouteState state = ref.read(battleRouteProvider);
      PlayerState playerState = ref.read(playerProvider);
      EnemyState enemyState = ref.read(enemyProvider);
      log.config(state.toJsonString());

      var characterArea = children.whereType<CharacterAreaComponent>();
      if (characterArea.isEmpty &
          (playerState != null) &
          (enemyState != null)) {
        log.fine("addCharacters");
        await addCharacters(
            loadParallaxComponent: game.loadParallaxComponent,
            playerState: playerState,
            enemyState: enemyState);
      }
    });

    super.onMount();
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
  }
}
