import 'dart:convert';

import 'package:riverpod/riverpod.dart';

import '../models/character_state.dart';
import '../systems/dungeon.dart';
import '../systems/event_probabilities.dart';

// プレイヤーの状態管理プロバイダ
final exploreRouteProvider =
    StateNotifierProvider<ExploreRouteStateNotifier, ExploreRouteState>((ref) {
  return ExploreRouteStateNotifier(ExploreRouteState(stage: 0, stageList: []));
});

class ExploreRouteStateNotifier extends StateNotifier<ExploreRouteState> {
  ExploreRouteStateNotifier(super.initialState);

  void initialize(
      {required stageLength, required minChoice, required maxChoice}) {
    state = ExploreRouteState(
      stage: 0,
      stageList:
          generateNestedListWithFixedLength(stageLength, minChoice, maxChoice),
    );
  }

  void incrementStage() {
    state =
        ExploreRouteState(stage: state._stage + 1, stageList: state._stageList);
  }

  int get stage => state._stage;

  int get nextStage => state._stage + 1;

  int get previousStage => state._stage - 1;

  List<List<Event>> get stageList => state._stageList;
}

class ExploreRouteState implements Jsonable {
  late final List<List<Event>> _stageList;
  late final int _stage;

  ExploreRouteState({required int stage, required List<List<Event>> stageList}) {
    _stage = stage;
    _stageList = stageList;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'stage': _stage,
      'stageList': _stageList
    };
  }

  @override
  String toJsonString() {
    return jsonEncode(toJson());
  }
}
