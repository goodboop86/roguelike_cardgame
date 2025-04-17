import 'package:flame/components.dart' hide Timer;
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:roguelike_cardgame/main_game.dart';
import 'package:roguelike_cardgame/mixin/has_common_area.dart';
import 'package:roguelike_cardgame/mixin/has_battle_area.dart';
import 'package:roguelike_cardgame/models/enemy_state.dart';
import 'package:roguelike_cardgame/models/player_state.dart';
import 'package:roguelike_cardgame/providers/deck_provider.dart';
import 'package:roguelike_cardgame/providers/enemy_provider.dart';
import 'package:roguelike_cardgame/providers/player_provider.dart';

import 'dart:async';

import '../components/card_area_component.dart';

class BattleEventWorld extends World
    with
        HasGameRef<MainGame>,
        RiverpodComponentMixin,
        HasBattleArea,
        HasCommonArea {
  @override
  Logger log = Logger('BattleEventWorld');

  late SpriteAnimationGroupComponent? playerComponent;
  bool deckInitialized = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
  }

  @override
  Future<void> onMount() async {
    startTransition(
      message: 'player-turn',
      next: () async {
        await Future.delayed(const Duration(seconds: 0));
        refreshCards();
      },
    );

    addToGameWidgetBuild(() async {
      // BattleRouteState state = ref.read(battleRouteProvider);
      PlayerState playerState = ref.read(playerProvider);
      EnemyState enemyState = ref.read(enemyProvider);
      // TODO: 受け取ったEventに従ってEnemyを設置する

      Component? background = game.findByKey(ComponentKey.named("Background"));
      if (background == null) {
        log.fine("addBackgrounds");
        addBackgrounds();
      }

      var characterArea = children.whereType<CharacterAreaComponent>();
      var buttonArea = children.whereType<ButtonAreaComponent>();
      var uiArea = children.whereType<UiAreaComponent>();

      if (background != null) {
        if (characterArea.isEmpty &
            background.isMounted &
            (playerState != null) &
            (enemyState != null)) {
          log.fine("addCharacters");

          await addCharacters(
              loadParallaxComponent: game.loadParallaxComponent, ref: ref);
        }

        if (buttonArea.isEmpty & background.isMounted) {
          log.fine("addButtons");
          addBattleButtons();
        }

        if (uiArea.isEmpty & background.isMounted) {
          log.fine("addUI");
          addUi();
        }
      }
    });

    addToGameWidgetBuild(() async {
      DeckState state = ref.watch(deckProvider);
      log.info("check deck exists");

      if (state.deck.hand.isNotEmpty) {
        final cardArea = children.whereType<CardAreaComponent>();
        // characterエリアより後にaddして描画が上に来るようにする。
        var characterArea = children.whereType<CharacterAreaComponent>();
        if (cardArea.isEmpty & characterArea.isNotEmpty) {
          log.fine("addCards");
          addCards(state.deck.hand);
        }
      }
    });

    super.onMount();
  }
}
