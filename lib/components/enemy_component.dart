import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:roguelike_cardgame/components/text_component.dart';

import '../main_game.dart';
import '../models/enum.dart';
import '../providers/enemy_provider.dart';
import '../providers/sizes.dart';
import '../spritesheet/spritesheet.dart';
import 'button_component.dart';

class EnemyComponent extends PositionComponent with RiverpodComponentMixin {
  EnemyComponent({required super.key, required String path})
      : super(
  size: Sizes.enemyAreaSize,
  position: Sizes.enemyAreaPosition,
      priority: 10, children: [
          EnemyHpBar()
        ]) {
    animation = AssetSource().getAnimation(name: path)!
      ..anchor = Anchor.bottomCenter
      ..position =
      Vector2(Sizes.playerAreaWidth / 2, Sizes.playerAreaHeight);
  }

  late SpriteAnimationGroupComponent animation;

  @override
  Future<void> onMount() async {
    super.onMount();
    add(animation);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }
}

class EnemyHpBar extends HpBar {
  late double _hp;
  late double _maxHp;
  late String? currentRouteName;
  bool _isInitialized = false;

  EnemyHpBar() {
    size = Vector2(100, 10);
    position = Vector2((Sizes.enemyAreaWidth - size.x) / 2, 0);
    anchor = Anchor.topLeft;
  }

  @override
  Future<void> onMount() async {
    currentRouteName = game.router.currentRoute.name;

    addToGameWidgetBuild(() async {
      _maxHp = ref.read(enemyProvider).maxHealth;
      _hp = ref.read(enemyProvider).maxHealth;
      _isInitialized = true;
    });
    super.onMount();
  }

  set hp(double value) {
    _hp = value.clamp(0, _maxHp);
  }

  double get hp => _hp;



  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (_isInitialized && currentRouteName == ROUTE.battle.name) {
      hp = ref.watch(enemyProvider).health;

      // 背景
      final backgroundPaint = Paint()..color = Colors.grey;
      canvas.drawRect(
        size.toRect(),
        backgroundPaint,
      );

      // HPバー
      final hpPaint = Paint()..color = Colors.green;
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.x * (hp / _maxHp), size.y),
        hpPaint,
      );

      // HPバーの枠線 (同じ Rect を使用)
      final borderPaint = Paint()
        ..color = Colors.black // 枠線の色
        ..style = PaintingStyle.stroke // 枠線スタイル (塗りつぶしではなく線)
        ..strokeWidth = 1; // 枠線の太さ

      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.x * (_hp / _maxHp), size.y),
        borderPaint,
      );

      // 全体の枠線 (背景と同じ Rect を使用)
      canvas.drawRect(
        size.toRect(),
        borderPaint,
      );
    }
  }
}

abstract class HpBar extends PositionComponent with RiverpodComponentMixin, HasGameRef<MainGame> {
  late double _hp;
  late double _maxHp;
  late String? currentRouteName;
  bool _isInitialized = false;

  HpBar() ;

  set hp(double value) {
    _hp = value.clamp(0, _maxHp);
  }
}

class EnemyStatus extends PositionComponent
    with RiverpodComponentMixin, HasGameRef<MainGame> {
  bool _isInitialized = false;

  final enemyIcon = SpriteButtons.enemyIconButton(onPressed: () {});
  final TextPaint _textPaint = TextPaints.base();

  EnemyStatus() {
    position = enemyIcon.position;
    anchor = Anchor.topLeft;
  }

  @override
  Future<void> onMount() async {
    addAll([enemyIcon]);

    addToGameWidgetBuild(() async {
      _isInitialized = true;
    });
    super.onMount();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (_isInitialized) {
      var enemyState = ref.watch(enemyProvider);
      _textPaint.render(
          canvas,
          '${enemyState.health.toInt()} / ${enemyState.maxHealth.toInt()}',
          enemyIcon.position + Vector2(Sizes.blockLength / 1.5, 0));
    }
  }
}
