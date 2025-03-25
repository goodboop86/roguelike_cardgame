import 'package:riverpod/riverpod.dart';

import '../models/character_state.dart';
import '../models/enemy_state.dart';

final enemyProvider =
    StateNotifierProvider<EnemyStateNotifier, EnemyState>((ref) {
  return EnemyStateNotifier(EnemyState(name: 'Enemy', health: 100, mana: 50));
});
// 敵の状態管理プロバイダ

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
}
