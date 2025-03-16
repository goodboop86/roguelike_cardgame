
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:riverpod/riverpod.dart';


class CharacterState extends StateNotifier<Map<String, dynamic>> {
  CharacterState({required String name, required int health}): super({'name': name, 'health': health});

  void takeDamage(int damage) {
    state = {...state, 'health': state['health']! - damage};
  }
  void healDamage(int damage) {
    state = {...state, 'health': state['health']! + damage};
  }


  }


final playerProvider = StateNotifierProvider<PlayerState, Map<String, dynamic>>((ref) => PlayerState(
  name: "Player",
  health: 100
));

final enemyProvider = StateNotifierProvider<PlayerState, Map<String, dynamic>>((ref) => PlayerState(
    name: "Enemy",
    health: 100
));

class PlayerState extends CharacterState {
  PlayerState({required super.name, required super.health});
}

class EnemyState extends CharacterState {
  EnemyState({required super.name, required super.health});
}




