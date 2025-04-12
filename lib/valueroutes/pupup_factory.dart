import 'package:flame/game.dart';
import 'package:roguelike_cardgame/valueroutes/popup.dart';

class ValueRouteFactory {
  static ValueRoute create(String type) {
    switch (type) {
      case 'string':
        return StringRoute();
      case 'int':
        return IntRoute();
      default:
        throw ArgumentError('Invalid product type: $type');
    }
  }
}
