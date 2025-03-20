import 'dart:convert';
import 'card.dart';
import 'character_state.dart';

class CardState implements Jsonable {
  final Card_ activeCard;

  CardState({required this.activeCard});

  @override
  Map<String, dynamic> toJson() {
    return activeCard.toJson();
  }

  @override
  String toJsonString() {
    return jsonEncode(toJson());
  }
}
