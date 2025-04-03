import 'dart:convert';

import 'character_state.dart';

class EnemyState extends CharacterState {
  late final String name;
  late final double health;
  late final double maxHealth;
  late final int mana;
  late final int maxMana;

  EnemyState(
      {required this.name,
      required this.health,
      required this.mana,
      required this.maxMana,
      required this.maxHealth});

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
