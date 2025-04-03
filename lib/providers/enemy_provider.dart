import 'package:riverpod/riverpod.dart';

import '../models/character_state.dart';
import '../models/enemy_state.dart';

final enemyProvider =
    StateNotifierProvider<EnemyStateNotifier, EnemyState>((ref) {
  return EnemyStateNotifier(EnemyState(
      name: 'Enemy', health: 50, mana: 3, maxMana: 3, maxHealth: 50));
});
// 敵の状態管理プロバイダ

class EnemyStateNotifier extends CharacterStateNotifier<EnemyState> {
  EnemyStateNotifier(super.initialState);

  void takeDamage(int damage) {
    state = EnemyState(
      name: state.name,
      maxHealth: state.maxHealth,
      maxMana: state.maxMana,
      health: state.health - damage,
      mana: state.mana,
    );
  }

  void heal(int amount) {
    state = EnemyState(
      name: state.name,
      maxHealth: state.maxHealth,
      maxMana: state.maxMana,
      health: state.health + amount,
      mana: state.mana,
    );
  }

  void useMana(int amount) {
    state = EnemyState(
      name: state.name,
      maxHealth: state.maxHealth,
      maxMana: state.maxMana,
      health: state.health,
      mana: state.mana - amount,
    );
  }

  void resetMana() {
    state = EnemyState(
      name: state.name,
      maxHealth: state.maxHealth,
      maxMana: state.maxMana,
      health: state.health,
      mana: state.maxMana,
    );
  }

  void reset() {
    print("---> ${state.maxHealth}");
    state = EnemyState(
      name: state.name,
      maxHealth: state.maxHealth,
      maxMana: state.maxMana,
      health: state.maxHealth,
      mana: state.maxMana,
    );
  }
}
