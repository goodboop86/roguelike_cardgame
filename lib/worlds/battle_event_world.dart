import 'package:flame/components.dart' hide Timer;
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:roguelike_cardgame/main_game.dart';
import 'package:roguelike_cardgame/mixin/has_common_area.dart';
import 'package:roguelike_cardgame/mixin/has_battle_area.dart';
import 'package:roguelike_cardgame/models/enum.dart';
import 'package:roguelike_cardgame/providers/deck_provider.dart';

import 'dart:async';

import '../components/card_area_component.dart';
import '../models/enemy_state.dart';
import '../models/player_state.dart';
import '../providers/battle_route_provider.dart';
import '../providers/enemy_provider.dart';
import '../providers/player_provider.dart';

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
    game.fadeIn(message: '', onComplete: startPhase);

    // 各種Componentの配置
    addToGameWidgetBuild(() async {
      BattleRouteState state = ref.read(battleRouteProvider);
      PlayerState playerState = ref.read(playerProvider);
      EnemyState enemyState = ref.read(enemyProvider);

      Component? background = game.findByKey(ComponentKey.named("Background"));
      if (background == null) {
        log.fine("addBackgrounds");
        addBackgrounds();
      }


      if (background != null) {
        var characterArea = children.whereType<CharacterAreaComponent>();
        if (characterArea.isEmpty & background.isMounted) {
          log.fine("addCharacters");
          await addCharacters();
        }

        var buttonArea = children.whereType<ButtonAreaComponent>();
        if (buttonArea.isEmpty & background.isMounted) {
          log.fine("addButtons");
          addBattleButtons();
        }

        var bottomUiArea = children.whereType<BottomUiAreaComponent>();

        if (bottomUiArea.isEmpty & background.isMounted) {
          log.fine("addBottomUI");
          addBottomUi();
        }

        var topUiArea = children.whereType<TopUiAreaComponent>();
        if (topUiArea.isEmpty & background.isMounted) {
          log.fine("addTopUI");
          addTopUi(hasEnemy: true);
        }
      }
    });


    // Deckの更新
    addToGameWidgetBuild(() async {
      DeckState deckState = ref.watch(deckProvider);
      BattleRouteState battleState = ref.watch(battleRouteProvider);
      log.info("check deck exists");

      final cardArea = children.whereType<CardAreaComponent>();
      var characterArea = children.whereType<CharacterAreaComponent>();

      if (deckState.deck.hand.isNotEmpty &&
          battleState.phase == BattlePhase.playerPhase) {
        // characterエリアより後にaddして描画が上に来るようにする。
        if (cardArea.isEmpty & characterArea.isNotEmpty) {
          log.fine("addCards");
          addCards(deckState.deck.hand);
        }
      } else if (cardArea.isNotEmpty &&
          battleState.phase == BattlePhase.playerEndPhase) {
        removeCardArea();
      }
    });

    // Player/Enemyの管理
    addToGameWidgetBuild(() async {
      BattleRouteState state = ref.read(battleRouteProvider);
      PlayerState playerState = ref.read(playerProvider);
      EnemyState enemyState = ref.read(enemyProvider);

      if(playerState.isDead()){
        log.info("player is dead");
        playerIsDead();
      }

      if(enemyState.isDead()){
        log.info("enemy is dead");
        enemyIsDead();
      }

    });

    super.onMount();
  }
}
