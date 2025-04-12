import 'dart:math';

import '../models/enum.dart';
import 'event_probabilities.dart';

// ステージ全体の構成を決める
List<List<Event>> generateNestedListWithFixedLength(
    int stageLists, int minLength, int maxLength, bool isDebug) {
  final nestedList = <List<Event>>[];

  // stageの選択肢の数とその比率
  final weights = {
    1: 25,
    2: 50,
    3: 25,
  };

  for (int stage = 0; stage < stageLists; stage++) {
    // int listLength = Random().nextInt(maxLength - minLength + 1) + minLength; // 指定された範囲内でランダムな長さを生成
    int listLength = weightedRandom(weights);
    if (stage == 0 || stage == 5 || stage == 10) {
      listLength = 1; // 0, 5, 10番目のリストの長さを1にする
    }
    final innerList = List.generate(
        listLength, (idx) => assignEvent(idx, stage)); // 連番でリストを生成
    nestedList.add(innerList);
  }

  if (isDebug) {
    return [
      [Event.start],
      [Event.battle, Event.person, Event.treasureChest]
    ];
  }
  return nestedList;
}

Event assignEvent(int idx, int stageId) {
  /**
   * stageIdごとに割り振られた確率に従ってイベントを決定する。
   * 1つ目と2つ目以降では異なる確率テーブル(first/other)を利用する。
   */
  final random = Random();
  final randomNumber = random.nextDouble();
  double cumulativeProbability = 0.0;
  Map<Event, double> probabilities;
  if (idx == 0) {
    probabilities = firstEventProbabilities[stageId] ?? {};
  } else {
    probabilities = otherEventProbabilities[stageId] ?? {};
  }

  Event? selectedEvent;
  for (final event in Event.values) {
    cumulativeProbability += probabilities[event] ?? 0.0;
    if (randomNumber < cumulativeProbability) {
      selectedEvent = event;
      break;
    }
  }

  return selectedEvent ?? Event.rest; // デフォルト
}

bool isSpecialStage(int stageId) {
  List<int> specialStages = [1, 5, 10, 15, 20];
  return specialStages.contains(stageId);
}

T weightedRandom<T>(Map<T, int> weights) {
  final random = Random();
  final totalWeight = weights.values.reduce((a, b) => a + b);
  var randomNumber = random.nextInt(totalWeight);

  for (final entry in weights.entries) {
    randomNumber -= entry.value;
    if (randomNumber < 0) {
      return entry.key;
    }
  }

  // ここに来ることは通常ないはずですが、念のため最初のキーを返します。
  return weights.keys.first;
}

enum Foo { foo, bar }

void main() {
  final nestedList =
      generateNestedListWithFixedLength(11, 1, 3, true); // 12個のリストを持つ二重リストを生成
  print(nestedList);

  print(Foo.foo.name);
}
