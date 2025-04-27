import 'dart:convert';

import 'package:riverpod/riverpod.dart';

import '../models/character_state.dart';
import '../models/enum.dart';

// プレイヤーの状態管理プロバイダ
final battleRouteProvider =
    StateNotifierProvider<BattleRouteStateNotifier, BattleRouteState>((ref) {
  return BattleRouteStateNotifier(BattleRouteState(event: Event.start, phase: BattlePhase.playerPhase));
});

class BattleRouteStateNotifier extends StateNotifier<BattleRouteState> {
  BattleRouteStateNotifier(super.initialState);

  Event getEvent() {
    return state.event;
  }

  void enemyPhase() {
    state = BattleRouteState(event: state.event, phase: BattlePhase.enemyPhase
    );
  }

  void playerPhase() {
    state = BattleRouteState(event: state.event, phase: BattlePhase.playerPhase
    );
  }

}

class BattleRouteState implements Jsonable {
  final Event event;
  final BattlePhase phase;

  BattleRouteState({required this.event, required this.phase});

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': event.name,
      'phase': phase.name,
    };
  }

  @override
  String toJsonString() {
    return jsonEncode(toJson());
  }
}
