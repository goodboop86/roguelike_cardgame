
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class Sizes {
  static final Sizes _instance = Sizes._internal();
  factory Sizes() => _instance;

  Sizes._internal();

  late Vector2 screenSize;

  void setScreenSize(Vector2 size) {
    screenSize = size;
  }
  double get screenWidth => screenSize.x;
  double get screenHeight => screenSize.y;
  double get margin => 20.0;

  Vector2 get cardAreaSize => Vector2(450, 200);

  double get cardAreaWidth => screenSize.x * 0.7;
  double get cardAreaHeight => screenSize.x * 0.5;

  double get cardWidth => cardAreaWidth * 0.4;
  double get cardHeight => cardAreaHeight * 0.4;
  double get cardMargin => 10.0;

  double get buttonAreaHeight => 100.0;
}