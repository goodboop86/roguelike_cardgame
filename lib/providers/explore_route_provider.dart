import 'dart:convert';

import 'package:riverpod/riverpod.dart';

import '../models/character_state.dart';


// プレイヤーの状態管理プロバイダ
final exploreRouteProvider =
    StateNotifierProvider<ExploreRouteStateNotifier, ExploreRouteState>((ref) {
  return ExploreRouteStateNotifier(
      ExploreRouteState(stage: 0));
});

class ExploreRouteStateNotifier extends StateNotifier<ExploreRouteState> {
  ExploreRouteStateNotifier(super.initialState);

  void initialize(){
    state = ExploreRouteState(stage: 0);
  }

  void incrementStage(){
    state = ExploreRouteState(stage: state.stage + 1);
  }

  int getStage(){
    return state.stage;
  }

  int getPreviousStage(){
    return state.stage -1;
  }

  int getNextStage(){
    return state.stage +1 ;
  }
}

class ExploreRouteState implements Jsonable {
  final int stage;

  ExploreRouteState({required this.stage});

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': stage,
    };
  }

  @override
  String toJsonString() {
    return jsonEncode(toJson());
  }
}