import 'dart:convert';

import 'package:riverpod/riverpod.dart';

import '../models/character_state.dart';
import '../systems/dungeon.dart';
import '../systems/event_probabilities.dart';

// プレイヤーの状態管理プロバイダ
final exploreRouteProvider =
    StateNotifierProvider<ExploreRouteStateNotifier, ExploreRouteState>((ref) {
  return ExploreRouteStateNotifier(ExploreRouteState(stage: 0, stageList: [[Event.empty]]));
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
    print("initialized!");
  }

  void incrementStage() {
    state =
        ExploreRouteState(stage: state._stage + 1, stageList: state._stageList);
  }


}

class ExploreRouteState implements Jsonable {
  late final List<List<Event>> _stageList;
  late final int _stage;

  ExploreRouteState({required stage, required stageList}) {
    _stage = stage;
    _stageList = stageList;
  }

  int get getStage => _stage;

  int get getNextStage => _stage + 1;

  int get getPreviousStage => _stage - 1;

  List<List<Event>> get getStageList => _stageList;


  @override
  Map<String, int> toJson() {
    return {
      'stage': _stage,
    };
  }

  @override
  String toJsonString() {
    return jsonEncode(toJson());
  }
}

