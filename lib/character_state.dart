import 'dart:convert';
import 'package:riverpod/riverpod.dart';

import 'card.dart';

abstract class CharacterStateNotifier<T extends CharacterState>
    extends StateNotifier<T> {
  CharacterStateNotifier(super.initialState);
}

class PlayerStateNotifier extends CharacterStateNotifier<PlayerState> {
  PlayerStateNotifier(super.initialState);

  void takeDamage(int damage) {
    state = PlayerState(
        name: state.name, health: state.health - damage, mana: state.mana);
  }

  void heal(int amount) {
    state = PlayerState(
        name: state.name, health: state.health + amount, mana: state.mana);
  }

  // カードの効果を適用するメソッド
  void applyCardEffect(CardEffect effect) {
    if (effect.damage != 0) {
      takeDamage(effect.damage);
    }
    if (effect.heal != 0) {
      heal(effect.heal);
    }
  }
}

class EnemyStateNotifier extends CharacterStateNotifier<EnemyState> {
  EnemyStateNotifier(super.initialState);

  void takeDamage(int damage) {
    state = EnemyState(
        name: state.name, health: state.health - damage, mana: state.mana);
  }

  void heal(int amount) {
    state = EnemyState(
        name: state.name, health: state.health + amount, mana: state.mana);
  }

  // カードの効果を適用するメソッド
  void applyCardEffect(CardEffect effect) {
    if (effect.damage != 0) {
      takeDamage(effect.damage);
    }
    if (effect.heal != 0) {
      heal(effect.heal);
    }
  }
}

class PlayerState extends CharacterState {
  final String name;
  final int health;
  final int mana;

  PlayerState({required this.name, required this.health, required this.mana});

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'health': health,
      'mana': mana,
    };
  }

  @override
  String toJsonString() {
    return jsonEncode(toJson());
  }
}

class EnemyState extends CharacterState {
  final String name;
  final int health;
  final int mana;

  EnemyState({required this.name, required this.health, required this.mana});

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'health': health,
      'mana': mana,
    };
  }

  @override
  String toJsonString() {
    return jsonEncode(toJson());
  }
}

// プレイヤーの状態管理プロバイダ
final playerProvider =
    StateNotifierProvider<PlayerStateNotifier, PlayerState>((ref) {
  return PlayerStateNotifier(
      PlayerState(name: 'Player', health: 100, mana: 50));
});

final enemyProvider =
    StateNotifierProvider<EnemyStateNotifier, EnemyState>((ref) {
  return EnemyStateNotifier(EnemyState(name: 'Player', health: 100, mana: 50));
});
// 敵の状態管理プロバイダ

abstract class CharacterState implements Jsonable {}
