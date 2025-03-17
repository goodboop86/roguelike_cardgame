// カードの効果を定義するクラス
import 'dart:convert';

import 'card.dart';

class CardEffect implements Jsonable {
  final int damage;
  final int heal;

  CardEffect({required this.damage, required this.heal});

  @override
  Map<String, dynamic> toJson() {
    return {
      'damage': damage,
      'heal': heal,
    };
  }

  @override
  String toJsonString() {
    return jsonEncode(toJson());
  }
}
