// カードの効果を定義するクラス
import 'dart:convert';

import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/cupertino.dart';

import '../components/enemy_component.dart';
import '../providers/enemy_provider.dart';
import '../providers/player_provider.dart';

typedef CardEffectFunction = void Function(
  ComponentRef ref,
);

class CardEffect {
  final CardEffectFunction effectFunction;

  CardEffect({required this.effectFunction});
}

void damageEffect(ComponentRef ref) {
  ref.read(playerProvider.notifier).takeDamage(10); // Player に 10 ダメージ
  ref.read(enemyProvider.notifier).takeDamage(20); // Enemy に 20 ダメージ
}

void enemyEffect(ComponentRef ref) {
  debugPrint("enemyEffect!");
  ref.read(playerProvider.notifier).takeDamage(10); // Player に 10 ダメージ
}

void healEffect(ComponentRef ref) {
  ref.read(playerProvider.notifier).heal(10); // Player を 10 回復
}

void buffEffect(ComponentRef ref) {
  // バフ効果の実装 (例: 攻撃力アップ)
  print('Buff applied!');
}

void debuffEffect(ComponentRef ref) {
  // デバフ効果の実装 (例: 防御力ダウン)
  print('Debuff applied!');
}

void emptyEffect(ComponentRef ref) {
  // do nothing.
}