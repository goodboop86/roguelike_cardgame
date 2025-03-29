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
import '../components/card_component.dart';
import '../models/card.dart';
import '../models/card_effect.dart';
import '../models/enum.dart';
import '../providers/battle_route_provider.dart';

class BattlePage extends World
    with HasGameRef<MainGame>, RiverpodComponentMixin, WorldMixin {
  late Function stateCallbackHandler;
  final List<MapCardComponent> _cards = []; // カードリストをキャッシュ
  Logger log = Logger('BattlePage');
  bool isReflected = false; // 状態に基づいてMountが反映されたか

  set setReflected(bool val) {
    isReflected = val;
    print("$BattlePage Reflected -> $isReflected");
  }

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

      final cardArea = children.whereType<CardAreaComponent>();
      if (cardArea.isEmpty) {
        log.fine("addCards");
        addCards(4);
      }

      var buttonArea = children.whereType<ButtonAreaComponent>();
      if (buttonArea.isEmpty) {
        log.fine("addButtons");
        _addButtons();
      }
    });

    super.onMount();
  }

  @override
  Future<void> onLoad() async {
    Sizes().setScreenSize(game.size);
    super.onLoad();

  }



  void _addButtons() {
    void _playerTurn() {
      final timerComponent = TimerComponent(
        period: 1,
        onTick: () {
          debugPrint("PlayerTurn start!");
        },
        removeOnFinish: true,
      );

      // RectangleComponentをTimerComponentの子として追加
      timerComponent.add(RectangleComponent(
        size: Vector2(200, 200),
        position: Sizes().screenSize / 2,
        anchor: Anchor.center,
        paint: Paint()..color = Colors.black87,
      ));

      // TextComponentをTimerComponentの子として追加
      timerComponent.add(TextComponent(
        text: 'Player Turn',
        position: Sizes().screenSize / 2,
        anchor: Anchor.center,
        textRenderer: TextPaint(style: const TextStyle(color: Colors.white)),
      ));

      // TimerComponentをゲームに追加
      add(timerComponent);

      // タイマーを開始
      timerComponent.timer.start();
    }
    void _enemyTurn() {
      final card = ActionCard(
        name: 'EnemyCard',
        effect: PlayerDamageEffect(),
      );

      final timerComponent = TimerComponent(
        period: 1,
        onTick: () async {
          card.effect.call(ref);

          await Future.delayed(const Duration(seconds: 1));

          _playerTurn();
        },
        removeOnFinish: true,
      );

      // RectangleComponentをTimerComponentの子として追加
      timerComponent.add(RectangleComponent(
        size: Vector2(200, 200),
        position: Sizes().screenSize / 2,
        anchor: Anchor.center,
        paint: Paint()..color = Colors.black87,
      ));

      // TextComponentをTimerComponentの子として追加
      timerComponent.add(TextComponent(
        text: 'Enemy Turn',
        position: Sizes().screenSize / 2,
        anchor: Anchor.center,
        textRenderer: TextPaint(style: const TextStyle(color: Colors.white)),
      ));

      // TimerComponentをゲームに追加
      add(timerComponent);

      // タイマーを開始
      timerComponent.timer.start();
    }

    void refreshCards() {
      // 現在のカードを削除
      children.whereType<CardAreaComponent>().forEach((area) {
        if (area.isMounted) {
          remove(area);
        }
      });

      // 新しいカードを生成して配置
      addCards(4); // カード枚数を指定
    }

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
        refreshCards();
        _enemyTurn();
      },
      () {
        game.router.pushNamed(ROUTE.explore.name);
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



  void setCallback(Function fn) => stateCallbackHandler = fn;
}
