import 'dart:convert';

import 'package:riverpod/riverpod.dart';
import 'package:roguelike_cardgame/systems/event_probabilities.dart';

import '../models/character_state.dart';


// プレイヤーの状態管理プロバイダ
final battleRouteProvider =
    StateNotifierProvider<BattleRouteStateNotifier, BattleRouteState>((ref) {
  return BattleRouteStateNotifier(
      BattleRouteState(event: Event.start));
});

class BattleRouteStateNotifier extends StateNotifier<BattleRouteState> {
  BattleRouteStateNotifier(super.initialState);

  Event getEvent(){
    return state.event;
  }
}

class BattleRouteState implements Jsonable {
  final Event event;

  BattleRouteState({required this.event});

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': event,
    };
  }

  @override
  String toJsonString() {
    return jsonEncode(toJson());
  }
}