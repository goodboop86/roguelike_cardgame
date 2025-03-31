import 'dart:convert';

import 'package:roguelike_cardgame/models/character_state.dart';

import 'card_effect.dart';


// カードの情報を保持するクラス
class Card_ implements Jsonable{
  final CardEffect effect;

  Card_({required this.effect});

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': effect.name,
    };
  }
  @override
  String toJsonString() {
    return jsonEncode(toJson());
  }
}


List<Card_> getCards() {
  return [
    Card_(effect: AllDamageEffect()),
    Card_(effect: AllDamageEffect()),
    Card_(effect: AllDamageEffect()),
    Card_(effect: AllDamageEffect()),
    Card_(effect: PlayerHealEffect()),
    Card_(effect: PlayerHealEffect()),
    Card_(effect: BuffEffect()),
    Card_(effect: BuffEffect()),
    Card_(effect: DebuffEffect()),
    Card_(effect: DebuffEffect()),
  ];
}




