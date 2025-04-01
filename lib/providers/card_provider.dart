import 'package:riverpod/riverpod.dart';

import '../models/card.dart';
import '../models/card_effect.dart';
import '../models/card_state.dart';

// プレイヤーの状態管理プロバイダ
final cardProvider = StateNotifierProvider<CardStateNotifier, CardState>((ref) {
  return CardStateNotifier(CardState(
      activeCard: Card_(
          effect: EmptyEffect())));
});

class CardStateNotifier extends StateNotifier<CardState> {
  CardStateNotifier(super.cardState);

  void setCard(Card_ card) {
    state = CardState(activeCard: card);
  }
}
