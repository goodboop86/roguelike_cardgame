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


  int get getStage => state._stage;

  int get getNextStage => state._stage + 1;

  int get getPreviousStage => state._stage - 1;

  List<List<Event>> get getStageList => state._stageList;
}

class ExploreRouteState implements Jsonable {
  late final List<List<Event>> _stageList;
  late final int _stage;

  ExploreRouteState({required stage, required stageList}) {
    _stage = stage;
    _stageList = stageList;
  }


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


class ExploreState {
  // 唯一のインスタンスを保持
  static final ExploreState _instance = ExploreState._internal();

  // ファクトリーコンストラクタ
  factory ExploreState() {
    return _instance;
  }

  // プライベートコンストラクタ
  ExploreState._internal();

  late final List<List<Event>> _stageList;
  late final int _stage;

  int get stage => _stage;
  List<List<Event>> get  stageList => _stageList;



  // カウンターをインクリメントするメソッド
  void incrementStage() {
    _stage++;
    // 状態が変更されたことを通知（必要に応じて）
    _notifyListeners();
  }

  // リスナーのリスト
  final List<Function> _listeners = [];

  // リスナーを追加するメソッド
  void addListener(Function listener) {
    _listeners.add(listener);
  }

  // リスナーを削除するメソッド
  void removeListener(Function listener) {
    _listeners.remove(listener);
  }

  // リスナーに状態の変更を通知するメソッド
  void _notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }
}