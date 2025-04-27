import 'package:flame/components.dart' hide Timer;
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:roguelike_cardgame/main_game.dart';
import 'package:roguelike_cardgame/mixin/has_common_area.dart';

import 'dart:async';

import '../components/card_area_component.dart';
import '../mixin/has_person_area.dart';
import '../models/enemy_state.dart';
import '../models/player_state.dart';
import '../providers/battle_route_provider.dart';
import '../providers/enemy_provider.dart';
import '../providers/player_provider.dart';

class PersonEventWorld extends World
    with
        HasGameRef<MainGame>,
        RiverpodComponentMixin,
        HasPersonArea,
        HasCommonArea {
  Logger log = Logger('PersonEventWorld');

  @override
  Future<void> onMount() async {
    game.fadeIn(
        message: '',
        onComplete: () async {
          await startDialog();
        });

    // final value = await game.router.pushAndWait(MyDialogRoute());
    // print(value);

    addToGameWidgetBuild(() async {
      BattleRouteState state = ref.read(battleRouteProvider);
      PlayerState playerState = ref.read(playerProvider);
      EnemyState enemyState = ref.read(enemyProvider);

      log.config(state.toJsonString());

      Component? background = game.findByKey(ComponentKey.named("Background"));
      if (background == null) {
        log.fine("addBackgrounds");
        addBackgrounds();
      }

      if (background != null) {
        var characterArea = children.whereType<CharacterAreaComponent>();
        if (characterArea.isEmpty &
            (playerState != null) &
            (enemyState != null)) {
          log.fine("addCharacters");
          await addCharacters();
        }

        var bottomUiArea = children.whereType<BottomUiAreaComponent>();
        var topUiArea = children.whereType<TopUiAreaComponent>();

        if (bottomUiArea.isEmpty & background.isMounted) {
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

  @override
  Future<void> onLoad() async {
    super.onLoad();
  }
}
