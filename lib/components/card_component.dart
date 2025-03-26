import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/components.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:roguelike_cardgame/components/card_area_component.dart';
import '../models/card.dart';
import '../pages/battle.dart';
import '../providers/card_provider.dart';

class CardComponent extends RectangleComponent
    with TapCallbacks, RiverpodComponentMixin, HasGameRef, DragCallbacks {
  final ActionCard card;
  Vector2? initialPosition;
  CharacterAreaComponent? target;
  bool isOverlapping = false;

  CardComponent({required this.card});

  @override
  void onTapUp(TapUpEvent event) {
    add(SequenceEffect([
      ScaleEffect.to(
        Vector2.all(0.95), // 1.05倍に拡大
        EffectController(duration: 0.1), // 0.05秒かけて拡大
      ),
      ScaleEffect.to(
        Vector2.all(1.0), // 元の大きさに戻す
        EffectController(duration: 0.1), // 0.05秒かけて縮小
      ),
    ], onComplete: () {
      overLay();
    }));
  }

  void overLay() {
    // overlayでカード情報を表示するために、タップされたカードをアクティブにする。
    ref.read(cardProvider.notifier).setCard(card);
    game.overlays.add('CardOverlay');
    game.pauseEngine();
  }

  @override
  void onDragStart(DragStartEvent event) {
    initialPosition = position.clone(); // ドラッグ開始時の位置を保存
    target = game.findByKey(
        ComponentKey.named("BattleCharacterArea")); // TargetComponentを直接取得
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position.add(event.localDelta); // ドラッグに応じてコンポーネントの位置を更新
    checkOverlap();
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (isOverlapping) {
      process();
    } else {
      if (initialPosition != null) {
        // 元の位置までアニメーションで移動
        add(MoveToEffect(
          initialPosition!,
          EffectController(duration: 0.2, curve: Curves.easeInOut),
        ));
        initialPosition = null;
      }
    }
    target!.changeColor(Colors.transparent);
    target = null;
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    if (initialPosition != null) {
      // 元の位置までアニメーションで移動
      add(MoveToEffect(
        initialPosition!,
        EffectController(duration: 0.2, curve: Curves.easeInOut),
      ));
      initialPosition = null;
    }
    target!.changeColor(Colors.transparent);
    target = null;
  }

  // @override
  // void onLongTapDown(TapDownEvent event) {
  //   process();
  // }

  void process() {
    add(SequenceEffect([
      ScaleEffect.to(
        Vector2.all(0.95),
        EffectController(duration: 0.05), // 0.05秒かけて拡大
      ),
      ScaleEffect.to(
        Vector2.all(1.0), // 元の大きさに戻す
        EffectController(duration: 0.05), // 0.05秒かけて縮小
      ),
    ], onComplete: () {
      activate();
    }));
  }

  void activate() {
    card.effect.call(ref);

    // カードを削除
    removeFromParent();
    // 残りのカードを再配置
    BattlePage battlePage = findParent<BattlePage>() as BattlePage;
    battlePage.rearrangeCards();
  }

  // 重なり判定
  void checkOverlap() {
    if (target != null) {
      isOverlapping = toAbsoluteRect().overlaps(target!.toAbsoluteRect());
      if (isOverlapping) {
        // print(target);
        target?.changeColor(Colors.red.withOpacity(0.5));
      } else {
        target?.changeColor(Colors.transparent);
      }
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), Paint()..color = Colors.green);
    TextPainter(
      text: TextSpan(
          text: card.name, style: const TextStyle(color: Colors.white)),
      textDirection: TextDirection.ltr,
    )
      ..layout(maxWidth: size.x)
      ..paint(canvas, Vector2(0, 0).toOffset());
  }
}

class MapCardComponent extends RectangleComponent
    with RiverpodComponentMixin, HasGameRef {
  String name;

  MapCardComponent({required this.name});

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), Paint()..color = Colors.green);
    TextPainter(
      text: TextSpan(text: name, style: const TextStyle(color: Colors.white)),
      textDirection: TextDirection.ltr,
    )
      ..layout(maxWidth: size.x)
      ..paint(canvas, Vector2(0, 0).toOffset());
  }
}
