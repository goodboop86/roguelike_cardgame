import 'package:riverpod/riverpod.dart';

import '../models/character_state.dart';
import '../models/player_state.dart';

// プレイヤーの状態管理プロバイダ
final playerProvider =
    StateNotifierProvider<PlayerStateNotifier, PlayerState>((ref) {
  return PlayerStateNotifier(
      PlayerState(name: 'Player', health: 100, mana: 50));
});

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

}
