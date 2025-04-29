import 'dart:convert';

import 'package:logging/logging.dart';
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
  Logger log  = Logger("BattleRouteStateNotifier");

  Event getEvent() {
    return state.event;
  }

  void waitPhase() {
    log.info("waitPhase");
    state = BattleRouteState(event: state.event, phase: BattlePhase.waitPhase
    );
  }

  void startPhase() {
    log.info("startPhase");
    state = BattleRouteState(event: state.event, phase: BattlePhase.startPhase
    );
  }

  void playerPhase() {
    log.info("playerPhase");
    state = BattleRouteState(event: state.event, phase: BattlePhase.playerPhase
    );
  }

  void playerEndPhase() {
    log.info("endPhase");
    state = BattleRouteState(event: state.event, phase: BattlePhase.playerEndPhase
    );
  }

  void enemyPhase() {
    log.info("enemyPhase");
    state = BattleRouteState(event: state.event, phase: BattlePhase.enemyPhase
    );
  }

  void endPhase() {
    log.info("endPhase");
    state = BattleRouteState(event: state.event, phase: BattlePhase.endPhase
    );
  }

  void winPhase() {
    log.info("winPhase");
    state = BattleRouteState(event: state.event, phase: BattlePhase.win
    );
  }

  void losePhase() {
    log.info("losePhase");
    state = BattleRouteState(event: state.event, phase: BattlePhase.lose
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
