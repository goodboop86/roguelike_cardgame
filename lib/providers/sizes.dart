
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



  // CharacterArea
  double get characterAreaWidth => screenSize.x * 0.95;
  double get characterAreaHeight => screenSize.y * 0.3;
  Vector2 get characterAreaSize => Vector2(characterAreaWidth, characterAreaHeight);

  double get characterAreaX => (screenWidth - characterAreaWidth)/2;
  double get characterAreaY => (screenHeight - characterAreaHeight)/10;
  Vector2 get characterAreaPosition => Vector2(characterAreaX, characterAreaY);

  // Character
  // double get characterWidth => characterAreaWidth * 0.45;
  // double get characterHeight => characterAreaHeight * 0.9;
  double get enemyAreaWidth => characterAreaWidth * 0.4;
  double get enemyAreaHeight => characterAreaHeight;
  Vector2 get enemyAreaSize => Vector2(enemyAreaWidth, enemyAreaHeight);

  double get playerAreaWidth => characterAreaWidth * 0.4;
  double get playerAreaHeight => characterAreaHeight;
  Vector2 get playerAreaSize => Vector2(playerAreaWidth, playerAreaHeight);

  double get playerAreaX => 0;
  double get playerAreaY => 0; // characterAreaHeight - characterHeight;
  Vector2 get playerAreaPosition => Vector2(playerAreaX, playerAreaY);

  double get enemyAreaX => characterAreaWidth - playerAreaWidth;
  double get enemyAreaY => 0; // characterAreaHeight - characterHeight;
  Vector2 get enemyAreaPosition => Vector2(enemyAreaX, enemyAreaY);


  // CardArea
  double get cardAreaWidth => screenSize.x * 0.9;
  double get cardAreaHeight => screenSize.y * 0.4;
  Vector2 get cardAreaSize => Vector2(cardAreaWidth, cardAreaHeight);

  double get cardAreaX => (screenWidth - cardAreaWidth)/2;
  double get cardAreaY => (screenHeight - cardAreaHeight)/1.1;
  Vector2 get cardAreaPosition => Vector2(cardAreaX, cardAreaY);


  // Card
  // double get cardWidth => cardAreaWidth * 0.45;
  double get cardWidth => 128;
  // double get cardHeight => cardAreaHeight * 0.45;
  double get cardHeight => 160;
  Vector2 get cardSize => Vector2(cardWidth, cardHeight);

  double get cardMargin => 40.0;

  // ButtonArea
  double get buttonAreaWidth => screenSize.x * 0.95;
  double get buttonAreaHeight => screenSize.y * 0.05;
  Vector2 get buttonAreaSize => Vector2(buttonAreaWidth, buttonAreaHeight);

  double get buttonAreaX => (screenWidth - buttonAreaWidth)/2;
  double get buttonAreaY => (screenHeight - buttonAreaHeight)/2.5;
  Vector2 get buttonAreaPosition => Vector2(buttonAreaX, buttonAreaY);

  // Button
  double get buttonWidth => buttonAreaWidth * 0.1;
  double get buttonHeight => buttonAreaHeight * 0.8;
  Vector2 get buttonSize => Vector2(buttonWidth, buttonHeight);


}