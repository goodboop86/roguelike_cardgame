import 'package:flame/components.dart' hide Timer;
import 'package:flame/input.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart' hide Image;
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

import '../components/card_area_component.dart';
import '../models/card_effect.dart';
import '../models/enum.dart';
import '../providers/battle_route_provider.dart';

class BattleEventWorld extends World
    with HasGameRef<MainGame>, RiverpodComponentMixin, WorldMixin {
  Logger log = Logger('BattleEventWorld');

  @override
  Future<void> onMount() async {
    addToGameWidgetBuild(() async {
      BattleRouteState state = ref.read(battleRouteProvider);
      PlayerState playerState = ref.read(playerProvider);
      EnemyState enemyState = ref.read(enemyProvider);
      // TODO: 受け取ったEventに従ってEnemyを設置する

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

      var buttonArea = children.whereType<ButtonAreaComponent>();
      if (buttonArea.isEmpty) {
        log.fine("addButtons");
        _addButtons();
      }
    });

    addToGameWidgetBuild(() async {
      DeckState state = ref.read(deckProvider);

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

  @override
  Future<void> onLoad() async {
    Sizes().setScreenSize(game.size);
    super.onLoad();
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
        game.router.pushNamed(ROUTE.explore.name);
      },
      () {
        game.overlays.add(OVERLAY.autoDisappearingOverlay.name);
      },
      () {
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
      final button = ButtonComponent(
        button: RectangleComponent(
            size: Sizes().buttonSize,
            paint: Paint()..color = Colors.brown,
            priority: 0),
        onPressed: function,
        children: [
          TextComponent(
            priority: 1,
            text: '$index',
            position: Sizes().buttonSize / 2,
            anchor: Anchor.center,
            textRenderer:
                TextPaint(style: const TextStyle(color: Colors.white)),
          ),
        ],
      )
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
