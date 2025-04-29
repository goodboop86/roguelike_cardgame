import 'dart:convert';
import 'character_state.dart';

class PlayerState extends CharacterState {
  late final String name;
  late final double health;
  late final double maxHealth;
  late final int mana;
  late final int maxMana;

  PlayerState(
      {required this.name,
      required double health,
      required int mana,
      required this.maxMana,
      required this.maxHealth}) {
    // health, manaが規定以上/以下にならないようにする。
    this.health = health.clamp(0.0, maxHealth);
    this.mana = mana.clamp(0, maxMana);
  }

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

  bool isDead(){
    return health == 0.0;
  }
}
