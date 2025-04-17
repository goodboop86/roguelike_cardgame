import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:roguelike_cardgame/main_game.dart';
import '../components/basic_component.dart';
import '../components/card_area_component.dart';
import '../components/card_component.dart';
import '../models/card.dart';
import '../providers/sizes.dart';

mixin HasBattleArea on Component, HasGameRef<MainGame>, RiverpodComponentMixin {
  Logger log = Logger('HasBattleArea');

  void addCards(List<Card_> cards) {
    // カードエリアを作成
    final cardArea = CardAreaComponent(
      position: Sizes().cardAreaPosition,
      size: Sizes().cardAreaSize, // カードエリアのサイズ
    );
    add(cardArea);

    // カードコンポーネントを作成し、カードエリアの中心に集める
    final cardAreaCenterX = Sizes().cardAreaWidth / 2;
    final cardAreaCenterY = Sizes().cardAreaHeight / 2;
    const colSize = 3; // 横方向のコンポーネントの数
    cards.asMap().forEach((index, card) {
      final row = index ~/ colSize;
      final col = index % colSize;
      final cardComponent = CardComponent(card: card)
        ..size = Sizes().cardSize
        ..anchor = Anchor.center
        ..position = Vector2(
          cardAreaCenterX +
              (col - 1) * (Sizes().cardWidth + Sizes().cardMargin), // X 座標を調整
          cardAreaCenterY +
              (row - 0.5) *
                  (Sizes().cardHeight + Sizes().cardMargin), // Y 座標を調整
        ); // カードエリアの中心を基準に位置を計算
      cardArea.add(cardComponent);
    });
  }

  Future<void> startTransition(
      {required String message, required Function next}) async {
    log.info("startTransition.");

    add(darkenOverlay);

    // SequenceEffect を使用して、複数のエフェクトを順番に実行
    await darkenOverlay.add(
      SequenceEffect(
        [
          // 暗転アニメーション
          OpacityEffect.to(
              0.6, EffectController(startDelay: 0.2, duration: 0.5),
              onComplete: () => {
                    darkenOverlay.add(transitionText
                      ..text = message
                      ..position = Sizes().gameSize / 2)
                  }),
          // 待機
          OpacityEffect.to(0.6, EffectController(duration: 0.5),
              onComplete: () => {darkenOverlay.remove(transitionText)}),
          // 明転アニメーション
          OpacityEffect.to(0, EffectController(duration: 0.5)),
        ],
        onComplete: () {
          next();
          remove(darkenOverlay);
          // 画面遷移処理
          // ...
        },
      ),
    );
  }

  Future<T> pushAndWait<T>(ValueRoute<T> route) async {
    return await game.router.pushAndWait(route) as T;
  }
}
