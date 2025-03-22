// カードの効果を定義するクラス

import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/cupertino.dart';
import '../providers/enemy_provider.dart';
import '../providers/player_provider.dart';


abstract class CardEffect {
  void call(ComponentRef ref);
}


class AllDamageEffect extends CardEffect {
  @override
  void call(ComponentRef ref) {
    ref.read(playerProvider.notifier).takeDamage(10); // Player に 10 ダメージ
    ref.read(enemyProvider.notifier).takeDamage(20); // Enemy に 20 ダメージ
  }
}

class PlayerDamageEffect extends CardEffect {
  @override
  void call(ComponentRef ref) {
    ref.read(playerProvider.notifier).takeDamage(10); // Player に 10 ダメージ
  }
}

class PlayerHealEffect extends CardEffect {
  @override
  void call(ComponentRef ref) {
    ref.read(playerProvider.notifier).heal(30); // Player を 10 回復
  }
}

class BuffEffect extends CardEffect {
  @override
  void call(ComponentRef ref) {
    debugPrint('Buff applied!');
  }
}

class DebuffEffect extends CardEffect {
  @override
  void call(ComponentRef ref) {
    debugPrint('Debuff applied!');
  }
}

class EmptyEffect extends CardEffect {
  @override
  void call(ComponentRef ref) {
    debugPrint('do nothing!');
  }
}
