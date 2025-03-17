import 'dart:convert';

import 'card_effect.dart';

abstract interface class Jsonable {
  Map<String, dynamic> toJson();

  String toJsonString() {
    return jsonEncode(toJson());
  }
}


// カードの情報を保持するクラス
class Card_ implements Jsonable {
  final String name;
  final CardEffect effect;

  Card_({required this.name, required this.effect});

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'effect': effect.toJson(), // CardEffect の toJson() を呼び出す
    };
  }

  @override
  String toJsonString() {
    return jsonEncode(toJson());
  }
}

