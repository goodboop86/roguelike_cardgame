import 'dart:convert';

import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import '../models/character_state.dart';
import '../models/deck.dart';
import '../models/card.dart';

// カードのリストを作成

// プレイヤーの状態管理プロバイダ
final deckProvider = StateNotifierProvider<DeckStateNotifier, DeckState>((ref) {
  return DeckStateNotifier(
      DeckState(deck: Deck(cards: getCards(), maxHandNum: 4)));
});

class DeckStateNotifier extends StateNotifier<DeckState> {
  DeckStateNotifier(super.initialState);

  void playCard(Card_ card, ComponentRef ref, FlameGame<World> game) {
    state = DeckState(deck: state.deck.playCard(card, ref, game));
  }

  void startTurn() {
    state = DeckState(deck: state.deck.startTurn());
  }
}

class DeckState implements Jsonable {
  final Deck deck;

  DeckState({required this.deck});

  @override
  Map<String, dynamic> toJson() {
    return {
      'deck': deck.toString(),
    };
  }

  @override
  String toJsonString() {
    return jsonEncode(toJson());
  }
}
