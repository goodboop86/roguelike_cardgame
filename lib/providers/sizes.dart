
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
  // Screen
  double get screenWidth => screenSize.x;
  double get screenHeight => screenSize.y;
  double get margin => 20.0;

  // Character
  double get characterWidth => screenWidth  * 0.5 - margin * 2;
  double get characterHeight => screenHeight * 0.3 - margin * 2;
  Vector2 get characterSize => Vector2(characterWidth, characterHeight);


  double get playerX => margin;
  double get playerY => margin;
  Vector2 get playerPosition => Vector2(playerX, playerY);

  double get enemyX => screenWidth - characterWidth - Sizes().margin;
  double get enemyY => margin;
  Vector2 get enemyPosition => Vector2(enemyX, enemyY);


  // CardArea
  double get cardAreaWidth => screenSize.x * 0.95;
  double get cardAreaHeight => screenSize.y * 0.4;
  Vector2 get cardAreaSize => Vector2(cardAreaWidth, cardAreaHeight);

  double get cardAreaX => (screenWidth - cardAreaWidth)/2;
  double get cardAreaY => (screenHeight - cardAreaHeight)/1/1;
  Vector2 get cardAreaPosition => Vector2(cardAreaX, cardAreaY);


  // Card
  double get cardWidth => cardAreaWidth * 0.45;
  double get cardHeight => cardAreaHeight * 0.45;
  Vector2 get cardSize => Vector2(cardWidth, cardHeight);

  double get cardMargin => 20.0;

  double get buttonAreaHeight => 100.0;
}