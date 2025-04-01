// カードの効果を定義するクラス

import 'dart:convert';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import '../providers/enemy_provider.dart';
import '../providers/player_provider.dart';
import 'character_state.dart';

abstract class CardEffect implements Jsonable {
  Logger log = Logger('CardEffect');
  final String _name = "default";
  final int _manaCost = 0;

  String get name => _name;

  int get manaCost => _manaCost;

  void call(ComponentRef ref, FlameGame<World> game) {
    log.info(toJsonString());
    execute(ref, game);
  }

  void execute(ComponentRef ref, FlameGame<World> game);

  @override
  Map<String, dynamic> toJson() {
    return {'name': name, 'manaCost': manaCost};
  }

  @override
  String toJsonString() {
    return jsonEncode(toJson());
  }
}

class AllDamageEffect extends CardEffect {
  @override
  String get name => "AllDamage";

  @override
  int get manaCost => 2;

  @override
  void execute(ComponentRef ref, FlameGame<World> game) {
    // TODO: animation実行中は、他のカードの実行を行わないようにする。
    Component? playerAnimation =
        game.findByKey(ComponentKey.named("PlayerAnimation"));

    final playerNotifier = ref.read(playerProvider.notifier); // Player に 10 ダメージ
    final enemyNotifier = ref.read(enemyProvider.notifier); // Enemy に 20 ダメージ;

    playerAnimation!.add(SequenceEffect([
      ScaleEffect.to(
        Vector2.all(0.95), // 1.05倍に拡大
        EffectController(duration: 0.1), // 0.05秒かけて拡大
      ),
      ScaleEffect.to(
        Vector2.all(1.0), // 元の大きさに戻す
        EffectController(duration: 0.1), // 0.05秒かけて縮小
      ),
    ], onComplete: () {
      playerNotifier.takeDamage(10); // Player に 10 ダメージ
      enemyNotifier.takeDamage(20); // Enemy に 20 ダメージ;
    }));
  }
}

class PlayerDamageEffect extends CardEffect {
  @override
  String get name => "PlayerDamage";

  @override
  int get manaCost => 1;

  @override
  void execute(ComponentRef ref, FlameGame<World> game) {
    ref.read(playerProvider.notifier).takeDamage(10); // Player に 10 ダメージ
  }
}

class PlayerHealEffect extends CardEffect {
  @override
  String get name => "PlayerHeal";

  @override
  int get manaCost => 1;

  @override
  void execute(ComponentRef ref, FlameGame<World> game) {
    ref.read(playerProvider.notifier).heal(30); // Player を 10 回復
  }
}

class BuffEffect extends CardEffect {
  @override
  String get name => "Buff";

  @override
  int get manaCost => 1;

  @override
  void execute(ComponentRef ref, FlameGame<World> game) {
    debugPrint('Buff applied!');
  }
}

class DebuffEffect extends CardEffect {
  @override
  String get name => "DeBuff";

  @override
  int get manaCost => 1;

  @override
  void execute(ComponentRef ref, FlameGame<World> game) {
    debugPrint('Debuff applied!');
  }
}

class EmptyEffect extends CardEffect {
  @override
  String get name => "Empty";

  @override
  int get manaCost => 1;

  @override
  void execute(ComponentRef ref, FlameGame<World> game) {
    debugPrint('do nothing!');
  }
}
