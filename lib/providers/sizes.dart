import 'package:flame/components.dart';
import 'package:flame/game.dart';

class Sizes {
  static final Sizes _instance = Sizes._internal();

  factory Sizes() => _instance;

  Sizes._internal();

  // Block
  double get blockSize => 32.0;

  // Game
  double get gameWidth => 13 * blockSize; // 416

  double get gameHeight => 27 * blockSize; // 864

  Vector2 get gameSize => Vector2(gameWidth, gameHeight);

  double get originX => -gameWidth / 2;

  double get originY => -gameHeight / 2;

  Vector2 get origin => Vector2(originX, originY);

  double get endX => gameWidth / 2;

  double get endY => gameHeight / 2;

  Vector2 get end => Vector2(originX, originY);

  // Background
  double get backgroundWidth => gameWidth;

  double get backgroundHeight => 18 * blockSize;

  Vector2 get backgroundSize => Vector2(backgroundWidth, backgroundHeight);

  double get backgroundX => 0;

  double get backgroundY => endY - backgroundHeight;

  Vector2 get backgroundPosition => Vector2(backgroundX, backgroundY);

  // CharacterArea
  double get characterAreaWidth => gameWidth;

  double get characterAreaHeight => 4 * blockSize;

  Vector2 get characterAreaSize =>
      Vector2(characterAreaWidth, characterAreaHeight);

  double get characterAreaX => originX;

  double get characterAreaY => originY + 6 * blockSize;

  Vector2 get characterAreaPosition => Vector2(characterAreaX, characterAreaY);

  // Character

  double get playerAreaWidth => 4 * blockSize;

  double get playerAreaHeight => characterAreaHeight;

  Vector2 get playerAreaSize => Vector2(playerAreaWidth, playerAreaHeight);

  double get playerAreaX => 0; // characterAreaXから見て0
  double get playerAreaY => 0; // characterAreaYから見て0
  Vector2 get playerAreaPosition => Vector2(playerAreaX, playerAreaY);

  double get enemyAreaWidth => 4 * blockSize;

  double get enemyAreaHeight => characterAreaHeight;

  Vector2 get enemyAreaSize => Vector2(enemyAreaWidth, enemyAreaHeight);

  double get enemyAreaX => characterAreaWidth - enemyAreaWidth;

  double get enemyAreaY => 0; // characterAreaYから見て0
  Vector2 get enemyAreaPosition => Vector2(enemyAreaX, enemyAreaY);

  // ButtonArea
  double get buttonAreaWidth => gameWidth;

  double get buttonAreaHeight => 2 * blockSize;

  Vector2 get buttonAreaSize => Vector2(buttonAreaWidth, buttonAreaHeight);

  double get buttonAreaX => originX;

  double get buttonAreaY => originY + 12 * blockSize;

  Vector2 get buttonAreaPosition => Vector2(buttonAreaX, buttonAreaY);

  // Button
  double get buttonWidth => 2 * blockSize;

  double get buttonHeight => 2 * blockSize;

  Vector2 get buttonSize => Vector2(buttonWidth, buttonHeight);

  // CardArea
  double get cardAreaWidth => gameWidth;

  double get cardAreaHeight => 8 * blockSize;

  Vector2 get cardAreaSize => Vector2(cardAreaWidth, cardAreaHeight);

  double get cardAreaX => originX;

  double get cardAreaY => originY + 16 * blockSize;

  Vector2 get cardAreaPosition => Vector2(cardAreaX, cardAreaY);

  // Card
  double get cardWidth => 3 * blockSize;

  double get cardHeight => 3 * blockSize;

  Vector2 get cardSize => Vector2(cardWidth, cardHeight);

  double get cardMargin => 20.0;

  // MapCardArea
  double get mapCardAreaWidth => gameWidth;

  double get mapCardAreaHeight => mapCardAreaWidth;

  Vector2 get mapCardAreaSize => Vector2(mapCardAreaWidth, mapCardAreaHeight);

  double get mapCardAreaX => originX;

  double get mapCardAreaY => originY + 16 * blockSize;

  Vector2 get mapCardAreaPosition => Vector2(mapCardAreaX, mapCardAreaY);

  // MapCard
  double get mapCardWidth => cardWidth;

  double get mapCardHeight => cardHeight;

  Vector2 get mapCardSize => Vector2(mapCardWidth, mapCardHeight);

  double get mapCardMargin => cardMargin;

  // MapArea
  double get mapAreaWidth => gameWidth;

  double get mapAreaHeight => 3 * blockSize;

  Vector2 get mapAreaSize => Vector2(mapAreaWidth, mapAreaHeight);

  double get mapAreaX => originX;

  double get mapAreaY => originY + 12 * blockSize;

  Vector2 get mapAreaPosition => Vector2(mapAreaX, mapAreaY);

  // Button
  double get mapWidth => mapAreaWidth * 0.05;

  double get mapHeight => mapAreaHeight * 0.2;

  Vector2 get mapSize => Vector2(mapWidth, mapHeight);

  // margin
  double get margin => 20.0;

  double get miniMargin => 5.0;
}
