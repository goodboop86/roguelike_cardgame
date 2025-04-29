import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:roguelike_cardgame/components/enemy_component.dart';
import 'package:roguelike_cardgame/components/player_component.dart';
import 'package:roguelike_cardgame/main_game.dart';
import 'package:roguelike_cardgame/providers/battle_route_provider.dart';
import '../components/background_component.dart';
import '../components/button_component.dart';
import '../components/card_area_component.dart';
import '../components/card_component.dart';
import '../components/text_component.dart';
import '../models/card.dart';
import '../models/card_effect.dart';
import '../models/enum.dart';
import '../providers/deck_provider.dart';
import '../providers/player_provider.dart';
import '../providers/sizes.dart';
import '../valueroutes/popup.dart';

mixin HasBattleArea on Component, HasGameRef<MainGame>, RiverpodComponentMixin {
  Logger log = Logger('HasBattleArea');

  void addCards(List<Card_> cards) {
    // カードエリアを作成
    final cardArea = CardAreaComponent(
      position: Sizes.cardAreaPosition,
      size: Sizes.cardAreaSize, // カードエリアのサイズ
    );
    add(cardArea);

    // カードコンポーネントを作成し、カードエリアの中心に集める
    final cardAreaCenterX = Sizes.cardAreaWidth / 2;
    final cardAreaCenterY = Sizes.cardAreaHeight / 2;
    const colSize = 3; // 横方向のコンポーネントの数
    cards.asMap().forEach((index, card) {
      final row = index ~/ colSize;
      final col = index % colSize;

      final cardComponent = CardComponent(
          card: card, spriteName: "fireball_48_32.png")
        ..position = Vector2(
          cardAreaCenterX +
              (col - 1) * (Sizes.cardWidth + Sizes.cardMargin), // X 座標を調整
          cardAreaCenterY +
              (row - 0.5) * (Sizes.cardHeight + Sizes.cardMargin), // Y 座標を調整
        ); // カードエリアの中心を基準に位置を計算
      cardArea.add(cardComponent);
    });
  }

  Future<void> startTransition(
      {required String message, required Function next}) async {
    log.info("startTransition.");

    final darkenOverlay = BlockTapOverlay.transparent_();

    final transitionText = Texts.transitionText()
      ..text = message
      ..position = Sizes.gameSize / 2;

    // SequenceEffect を使用して、複数のエフェクトを順番に実行
    darkenOverlay.add(
      SequenceEffect(
        [
          // 暗転アニメーション
          OpacityEffect.to(
              0.6, EffectController(startDelay: 0.2, duration: 0.5),
              onComplete: () => {darkenOverlay.add(transitionText)}),
          // 待機
          OpacityEffect.to(0.6, EffectController(duration: 0.5),
              onComplete: () => {darkenOverlay.remove(transitionText)}),
          // 明転アニメーション
          OpacityEffect.to(0, EffectController(duration: 0.5)),
          RemoveEffect(delay: 0.5)
        ],
        onComplete: () {
          next();
          // 画面遷移処理
          // ...
        },
      ),
    );
    add(darkenOverlay);
  }

  void removeCardArea() {
    // 現在のカードを削除
    children.whereType<CardAreaComponent>().forEach((area) {
      if (area.isMounted) {
        remove(area);
      }
    });
  }

  void startPhase() {
    ref.read(battleRouteProvider.notifier).startPhase();
    playerPhase();
  }

  void playerPhase() {
    ref.read(battleRouteProvider.notifier).playerPhase();

    ref.read(playerProvider.notifier).refresh();
    ref.read(deckProvider.notifier).refresh();
  }

  Future<void> playerEndPhase() async {
    ref.read(battleRouteProvider.notifier).playerEndPhase();
    CardAreaComponent cardArea = children.whereType<CardAreaComponent>().first;
    startTransition(
        message: "enemy-phase.",
        next: () {
          enemyPhase();
        });
  }

  Future<void> enemyPhase() async {
    ref.read(battleRouteProvider.notifier).enemyPhase();

    await Future.delayed(const Duration(milliseconds: 500));
    PlayerDamageEffect().call(ref, game);

    startTransition(
      message: 'player-turn',
      next: () async {
        await Future.delayed(const Duration(milliseconds: 500));
        removeCardArea();
        endPhase();
      },
    );
  }

  Future<void> endPhase() async {
    ref.read(battleRouteProvider.notifier).endPhase();
    startPhase();
  }



  void addBattleButtons() {
    final buttonArea = ButtonAreaComponent(
      position: Sizes.buttonAreaPosition,
      size: Sizes.buttonAreaSize, // カードエリアのサイズ
    );
    add(buttonArea);

    List buttonOnPressedFunctions = [
      () {
        game.overlays.add(OVERLAY.autoDisappearingOverlay.name);
      },
      () {
        playerEndPhase();
      },
    ];

    final buttonAreaCenterX = Sizes.buttonAreaWidth / 2;
    final buttonAreaCenterY = Sizes.buttonAreaHeight / 2;
    buttonOnPressedFunctions.asMap().forEach((index, function) {
      final button = SpriteButtons.optionButton(onPressed: function)
        ..position = Vector2(
          buttonAreaCenterX +
              (index - 1.5) * (Sizes.buttonWidth + Sizes.margin), // X 座標を調整
          buttonAreaCenterY, // Y 座標を調整
        )
        ..anchor = Anchor.center;
      buttonArea.add(button);
    });
  }

  Future<void> win()async {
    final enemy = game.findByKey(ComponentKey.named("Enemy")) as EnemyComponent;
    enemy.animation.current = CharacterState.death;
    int value = await game.router.pushAndWait(MyPopupRoute());
  }

  Future<void> lose()async {
    final player = game.findByKey(ComponentKey.named("Player")) as PlayerComponent;
    player.animation.current = CharacterState.death;
    int value = await game.router.pushAndWait(MyPopupRoute());

  }
}
