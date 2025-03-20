import 'dart:convert';

import 'package:roguelike_cardgame/models/character_state.dart';

import 'card_effect.dart';


// カードの情報を保持するクラス
class Card_ implements Jsonable{
  final String name;
  final CardEffect effect;

  Card_({required this.name, required this.effect});

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  @override
  String toJsonString() {
    return jsonEncode(toJson());
  }
}

