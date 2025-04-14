import 'package:flame/components.dart' hide Timer;
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:roguelike_cardgame/main_game.dart';
import 'package:roguelike_cardgame/mixin/world_mixin.dart';
import 'package:roguelike_cardgame/models/enemy_state.dart';
import 'package:roguelike_cardgame/models/player_state.dart';
import 'package:roguelike_cardgame/providers/deck_provider.dart';
import 'package:roguelike_cardgame/providers/enemy_provider.dart';
import 'package:roguelike_cardgame/providers/player_provider.dart';
import 'package:roguelike_cardgame/providers/sizes.dart';

import 'dart:async';

import '../components/button_component.dart';
import '../components/card_area_component.dart';
import '../models/card_effect.dart';
import '../models/enum.dart';
import '../providers/battle_route_provider.dart';
import '../spritesheet/spritesheet.dart';

class BattleEventWorld extends World
    with HasGameRef<MainGame>, RiverpodComponentMixin, WorldMixin {
  Logger log = Logger('BattleEventWorld');

  late SpriteAnimationGroupComponent? playerComponent;
  bool deckInitialized = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
  }

  @override
  Future<void> onMount() async {
    addToGameWidgetBuild(() async {
      BattleRouteState state = ref.read(battleRouteProvider);
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
      if (background != null) {
        if (characterArea.isEmpty &
            background!.isMounted &
            (playerState != null) &
            (enemyState != null)) {
          log.fine("addCharacters");

          await addCharacters(
              loadParallaxComponent: game.loadParallaxComponent, ref: ref);
        }

        if (buttonArea.isEmpty & background!.isMounted) {
          log.fine("addButtons");
          _addButtons();
        }
      }

      // DeckStateNotifier deckNotifier = ref.read(deckProvider.notifier);
      // if((deckNotifier != null ) & !deckInitialized) {
      //   deckNotifier.startTurn();
      //   deckInitialized = true;
      //   log.info("deckNotifier started.");
      // }
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

  void refreshCards() {
    ref.read(playerProvider.notifier).resetMana();
    ref.read(deckProvider.notifier).startTurn();
    // 現在のカードを削除
    children.whereType<CardAreaComponent>().forEach((area) {
      if (area.isMounted) {
        remove(area);
      }
    });
  }

  Future<void> enemyPhase() async {
    await Future.delayed(const Duration(seconds: 1));
    PlayerDamageEffect().call(ref, game);
    startTransition(
      message: 'player-turn',
      next: () async {
        await Future.delayed(const Duration(seconds: 1));
        refreshCards();
      },
    );
  }

  void _addButtons() {
    // カードエリアを作成
    final buttonArea = ButtonAreaComponent(
      position: Sizes().buttonAreaPosition,
      size: Sizes().buttonAreaSize, // カードエリアのサイズ
    );
    add(buttonArea);

    List buttonOnPressedFunctions = [
      () {
        game.router.pushNamed(ROUTE.home.name);
      },
      () {
        ref.read(deckProvider.notifier).startTurn();
        // game.router.pushNamed(ROUTE.explore.name);
      },
      () {
        game.overlays.add(OVERLAY.autoDisappearingOverlay.name);
      },
      () {
        CardAreaComponent cardArea =
            children.whereType<CardAreaComponent>().first as CardAreaComponent;
        cardArea.lock();
        startTransition(
            message: "enemy-turn.",
            next: () {
              enemyPhase();
            });
      },
    ];

    final buttonAreaCenterX = Sizes().buttonAreaWidth / 2;
    final buttonAreaCenterY = Sizes().buttonAreaHeight / 2;
    buttonOnPressedFunctions.asMap().forEach((index, function) {
      final button = OptionButtonComponent(text: '$index', func: function)
        ..position = Vector2(
          buttonAreaCenterX +
              (index - 1.5) * (Sizes().buttonWidth + Sizes().margin), // X 座標を調整
          buttonAreaCenterY, // Y 座標を調整
        )
        ..anchor = Anchor.center;
      buttonArea.add(button);
    });
  }
}
