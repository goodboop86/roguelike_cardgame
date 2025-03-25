import 'package:riverpod/riverpod.dart';

import '../models/card.dart';
import '../models/card_effect.dart';
import '../models/card_state.dart';

// プレイヤーの状態管理プロバイダ
final cardProvider = StateNotifierProvider<CardStateNotifier, CardState>((ref) {
  return CardStateNotifier(CardState(
      activeCard: ActionCard(
          name: 'empty', effect: EmptyEffect())));
});

class CardStateNotifier extends StateNotifier<CardState> {
  CardStateNotifier(super.cardState);

  void setCard(ActionCard card) {
    state = CardState(activeCard: card);
  }
}
