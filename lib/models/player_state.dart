import 'dart:convert';
import 'character_state.dart';

class PlayerState extends CharacterState {
  final String name;
  final double health;
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
