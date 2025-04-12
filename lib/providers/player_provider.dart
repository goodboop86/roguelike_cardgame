import 'package:riverpod/riverpod.dart';

import '../models/character_state.dart';
import '../models/player_state.dart';

// プレイヤーの状態管理プロバイダ
final playerProvider =
    StateNotifierProvider<PlayerStateNotifier, PlayerState>((ref) {
  return PlayerStateNotifier(PlayerState(
      name: 'Player', health: 50, mana: 3, maxMana: 3, maxHealth: 50));
});

class PlayerStateNotifier extends CharacterStateNotifier<PlayerState> {
  PlayerStateNotifier(super.initialState);

  void takeDamage(int damage) {
    state = PlayerState(
      name: state.name,
      maxHealth: state.maxHealth,
      maxMana: state.maxMana,
      health: state.health - damage,
      mana: state.mana,
    );
  }

  void heal(int amount) {
    state = PlayerState(
      name: state.name,
      maxHealth: state.maxHealth,
      maxMana: state.maxMana,
      health: state.health + amount,
      mana: state.mana,
    );
  }

  void useMana(int amount) {
    state = PlayerState(
      name: state.name,
      maxHealth: state.maxHealth,
      maxMana: state.maxMana,
      health: state.health,
      mana: state.mana - amount,
    );
  }

  void resetMana() {
    state = PlayerState(
      name: state.name,
      maxHealth: state.maxHealth,
      maxMana: state.maxMana,
      health: state.health,
      mana: state.maxMana,
    );
  }

  void reset() {
    print("---> ${state.maxHealth}");
    state = PlayerState(
      name: state.name,
      maxHealth: state.maxHealth,
      maxMana: state.maxMana,
      health: state.maxHealth,
      mana: state.maxMana,
    );
  }
}
