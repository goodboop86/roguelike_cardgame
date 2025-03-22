import 'package:riverpod/riverpod.dart';

import '../models/card.dart';
import '../models/card_effect.dart';
import '../models/card_state.dart';
import '../models/character_state.dart';
import '../models/player_state.dart';

// プレイヤーの状態管理プロバイダ
final cardProvider = StateNotifierProvider<CardStateNotifier, CardState>((ref) {
  return CardStateNotifier(CardState(
      activeCard: HandCard(
          name: 'empty', effect: EmptyEffect())));
});

class CardStateNotifier extends StateNotifier<CardState> {
  CardStateNotifier(super.cardState);

  void setCard(HandCard card) {
    state = CardState(activeCard: card);
  }
}
