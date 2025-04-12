import 'dart:math';

import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:roguelike_cardgame/models/card.dart';

// カードの情報を保持するクラス
class Deck {
  Logger log = Logger('Deck');
  int maxHandNum;
  List<Card_> _deck = [];
  final List<Card_> _hand = [];
  final List<Card_> _trash = []; // 墓地
  final List<Card_> _excluded = []; // 除外
  Card_? _lastPlayedCard; // 直前に使ったカード
  int _nextCardDamageBuff = 0; // 次にプレイするカードへのダメージバフ

  List<Card_> get hand => _hand;

  Deck({required List<Card_> cards, required this.maxHandNum}) {
    _deck = List.from(cards);
  }

  void _drawHand() {
    while (_hand.length < maxHandNum && _deck.isNotEmpty) {
      _hand.add(_deck.removeAt(0));
    }
  }

  Deck playCard(Card_ card, ComponentRef ref, FlameGame<World> game) {
    log.info("playCard");
    if (_hand.contains(card)) {
      _hand.remove(card);
      card.effect.call(ref, game); // カードの効果を実行（直前のカードとデッキを渡す）
      if ('exile' == card.effect) {
        _excluded.add(card);
      } else {
        _trash.add(card);
      }
      _lastPlayedCard = card; // 直前に使ったカードを更新
      _nextCardDamageBuff = 0; // バフをリセット
      return this;
    } else {
      return this;
    }
  }

  Deck startTurn() {
    log.info("startTurn");
    // 手札をデッキに戻す
    _deck.addAll(_hand);
    _hand.clear();

    // デッキがn枚未満の場合、墓地のカードをデッキに戻す
    if (_deck.length < maxHandNum) {
      _deck.addAll(_trash);
      _trash.clear();
    }

    // デッキをシャッフルして手札を引く
    _deck.shuffle(Random());
    _drawHand();
    _lastPlayedCard = null; // ターン開始時に直前に使ったカードをリセット
    _nextCardDamageBuff = 0; // ターン開始時にバフをリセット

    return this;
  }

  @override
  String toString() {
    return 'デッキ: $_deck\n手札: $_hand\n墓地: $_trash\n除外: $_excluded\n直前に使ったカード: $_lastPlayedCard\n次のカードへのダメージバフ: $_nextCardDamageBuff';
  }
}
