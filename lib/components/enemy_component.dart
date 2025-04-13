import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../providers/enemy_provider.dart';
import '../providers/player_provider.dart';
import '../providers/sizes.dart';
import '../spritesheet/spritesheet.dart';

class EnemyComponent extends PositionComponent with RiverpodComponentMixin {
  EnemyComponent({required super.key, required String path})
      : super(priority: 10, children: [
          AssetSource().getAnimation(name: path)!
            ..anchor = Anchor.bottomCenter
            ..position = Vector2(
                Sizes().enemyAreaWidth / 2 - 10, Sizes().enemyAreaHeight),
          EnemyHpBar()
        ]);

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // canvas.drawRect(size.toRect(), Paint()..color = Colors.blue);
    final enemyState = ref.watch(enemyProvider);
    TextPainter(
      text: TextSpan(
          text: enemyState.toJsonString(),
          style: const TextStyle(color: Colors.white)),
      textDirection: TextDirection.ltr,
    )
      ..layout(maxWidth: size.x)
      ..paint(canvas, Vector2(0, 0).toOffset());
  }
}

class EnemyHpBar extends HpBar {
  EnemyHpBar() : super();

  @override
  Future<void> onMount() async {
    addToGameWidgetBuild(() async {
      _maxHp = ref.read(enemyProvider).maxHealth;
      _hp = ref.read(enemyProvider).maxHealth;
      _isInitialized = true;
    });
    super.onMount();
  }

  @override
  double getHealth() {
    return ref.watch(playerProvider).health;
  }
}

abstract class HpBar extends PositionComponent with RiverpodComponentMixin {
  late double _hp;
  late double _maxHp;
  bool _isInitialized = false;

  HpBar() {
    size = Vector2(100, 10);
    position = Vector2(0, 0);
    anchor = Anchor.topLeft;
  }

  set hp(double value) {
    _hp = value.clamp(0, _maxHp);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (_isInitialized) {
      hp = getHealth();

      // 背景
      canvas.drawRect(
        size.toRect(),
        Paint()..color = Colors.grey,
      );

      // HPバー
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.x * (_hp / _maxHp), size.y),
        Paint()..color = Colors.green,
      );
    }
  }

  double getHealth();
}
