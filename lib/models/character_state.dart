import 'package:riverpod/riverpod.dart';

import 'card.dart';

abstract class CharacterState implements Jsonable {}

abstract class CharacterStateNotifier<T extends CharacterState>
    extends StateNotifier<T> {
  CharacterStateNotifier(super.initialState);
}
