
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
  double get mini_margin => 5.0;



  // CharacterArea
  double get characterAreaWidth => screenSize.x;
  double get characterAreaHeight => screenSize.y * 0.3;
  Vector2 get characterAreaSize => Vector2(characterAreaWidth, characterAreaHeight);

  double get originX => -screenWidth/2;
  double get originY => -screenHeight/2;
  Vector2 get origin =>  Vector2(originX, originY);

  double get characterAreaX => originX;
  double get characterAreaY => originY + 50;
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
  double get cardAreaWidth => screenSize.x;
  double get cardAreaHeight => screenSize.y * 0.4;
  Vector2 get cardAreaSize => Vector2(cardAreaWidth, cardAreaHeight);

  double get cardAreaX => originX;
  double get cardAreaY => originY + screenHeight*0.55;
  Vector2 get cardAreaPosition => Vector2(cardAreaX, cardAreaY);

  // Card
  // double get cardWidth => cardAreaWidth * 0.45;
  double get cardWidth => 96;
  // double get cardHeight => cardAreaHeight * 0.45;
  double get cardHeight => 128;
  Vector2 get cardSize => Vector2(cardWidth, cardHeight);

  double get cardMargin => 20.0;

  // MapCardArea
  double get mapCardAreaWidth => screenSize.x;
  double get mapCardAreaHeight => mapCardAreaWidth;
  Vector2 get mapCardAreaSize => Vector2(mapCardAreaWidth, mapCardAreaHeight);

  double get mapCardAreaX => originX;
  double get mapCardAreaY => originY + screenHeight*0.7;
  Vector2 get mapCardAreaPosition => Vector2(mapCardAreaX, mapCardAreaY);

  // MapCard
  double get mapCardWidth => mapCardAreaWidth * 0.3;
  double get mapCardHeight => mapCardAreaHeight * 0.3;
  Vector2 get mapCardSize => Vector2(mapCardWidth, mapCardHeight);
  double get mapCardMargin => 20.0;


  // ButtonArea
  double get buttonAreaWidth => screenSize.x;
  double get buttonAreaHeight => screenSize.y * 0.05;
  Vector2 get buttonAreaSize => Vector2(buttonAreaWidth, buttonAreaHeight);

  double get buttonAreaX => originX;
  double get buttonAreaY => originY + screenHeight*0.5;
  Vector2 get buttonAreaPosition => Vector2(buttonAreaX, buttonAreaY);

  // Button
  double get buttonWidth => buttonAreaWidth * 0.1;
  double get buttonHeight => buttonAreaHeight * 0.8;
  Vector2 get buttonSize => Vector2(buttonWidth, buttonHeight);

  // MapArea
  double get mapAreaWidth => screenSize.x;
  double get mapAreaHeight => screenSize.y * 0.1;
  Vector2 get mapAreaSize => Vector2(mapAreaWidth, mapAreaHeight);

  double get mapAreaX => originX;
  double get mapAreaY => originY + screenHeight/2;
  Vector2 get mapAreaPosition => Vector2(mapAreaX, mapAreaY);

  // Button
  double get mapWidth => mapAreaWidth * 0.05;
  double get mapHeight => mapAreaHeight * 0.2;
  Vector2 get mapSize => Vector2(mapWidth, mapHeight);


}