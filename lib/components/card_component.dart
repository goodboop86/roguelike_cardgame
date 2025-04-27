import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/components.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:roguelike_cardgame/components/card_area_component.dart';
import 'package:roguelike_cardgame/providers/deck_provider.dart';
import 'package:roguelike_cardgame/providers/player_provider.dart';
import '../models/card.dart';
import '../models/enum.dart';
import '../providers/card_provider.dart';
import '../providers/sizes.dart';
import '../spritesheet/spritesheet.dart';

class CardComponent extends PositionComponent
    with TapCallbacks, RiverpodComponentMixin, HasGameRef, DragCallbacks {
  CardComponent({required this.card, required this.sprite})
      : super(
      priority: 0,
      size: Sizes.cardSize,
      anchor: Anchor.center,);

  SpriteComponent sprite;
  Logger log = Logger('CardComponent');
  final Card_ card;
  Vector2? initialPosition;
  CharacterAreaComponent? target;

  bool isOverlapping = false;

  @override
  Future<void> onMount() async{
    super.onMount();

    // final sprite= AssetSource().getSpriteComponent(name: sprite)!;

    add(sprite..anchor=Anchor.topLeft); //これを追加するとエラー

    add(CardDesignComponent());
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (!(parent as CardAreaComponent).locked) {
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
        discriptionOverLay();
      }));
    }
  }

  void discriptionOverLay() {
    // overlayでカード情報を表示するために、タップされたカードをアクティブにする。
    ref.read(cardProvider.notifier).setCard(card);
    game.overlays.add(OVERLAY.cardOverlay.name);
    game.pauseEngine();
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    initialPosition = position.clone(); // ドラッグ開始時の位置を保存
    target = game.findByKey(
        ComponentKey.named("BattleCharacterArea")); // TargetComponentを直接取得
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (!(parent as CardAreaComponent).locked) {
      position.add(event.localDelta); // ドラッグに応じてコンポーネントの位置を更新
      checkOverlap();
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    int mana = ref
        .read(playerProvider)
        .mana;
    super.onDragEnd(event);
    if (isOverlapping & (mana >= card.effect.manaCost)) {
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
    super.onDragCancel(event);
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
    log.info("card-effect activate");
    ref.read(playerProvider.notifier).useMana(card.effect.manaCost);
    ref.read(deckProvider.notifier).playCard(card, ref, game);

    // カードを削除
    if (isMounted) {
      removeFromParent();
    }
  }

  // 重なり判定
  void checkOverlap() {
    if (target != null) {
      isOverlapping = toAbsoluteRect().overlaps(target!.toAbsoluteRect());
      if (isOverlapping) {
        target?.changeColor(Colors.red.withValues(alpha: 0.5));
      } else {
        target?.changeColor(Colors.transparent);
      }
    }
  }
}

class CardDesignComponent extends RectangleComponent
    with RiverpodComponentMixin, HasGameRef {
  CardDesignComponent({this.borderRadius = 1.0,
    this.strokeWidth = 1.0,
    this.fillColor = Colors.black,
    this.strokeColor = Colors.white})
      : super(priority: -1, size: Sizes.cardSize);

  @override
  Color get backgroundColor => Colors.black;

  Logger log = Logger('CardDesignComponent');
  final double borderRadius;
  final double strokeWidth;
  final Color fillColor; // 塗りつぶし色を受け取る
  final Color strokeColor; // 輪郭線の色を受け取る

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // 塗りつぶし
    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    // 輪郭線
    final strokePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final rrect = RRect.fromRectAndRadius(
      size.toRect(),
      Radius.circular(borderRadius),
    );

    canvas.drawRRect(rrect, fillPaint); // まず塗りつぶし
    canvas.drawRRect(rrect, strokePaint); // 次に輪郭線
  }
}

class MapCardComponent extends RectangleComponent
    with RiverpodComponentMixin, HasGameRef {
  String name;

  MapCardComponent({required this.name});

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), Paint()
      ..color = Colors.green);
    TextPainter(
      text: TextSpan(text: name, style: const TextStyle(color: Colors.white)),
      textDirection: TextDirection.ltr,
    )
      ..layout(maxWidth: size.x)
      ..paint(canvas, Vector2(0, 0).toOffset());
  }
}
