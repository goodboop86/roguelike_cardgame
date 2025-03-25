import 'dart:convert';

import 'package:riverpod/riverpod.dart';


abstract interface class Jsonable {
  Map<String, dynamic> toJson();

  String toJsonString() {
    return jsonEncode(toJson());
  }
}

abstract class CharacterState implements Jsonable {}

abstract class CharacterStateNotifier<T extends CharacterState>
    extends StateNotifier<T> {
  CharacterStateNotifier(super.initialState);
}
