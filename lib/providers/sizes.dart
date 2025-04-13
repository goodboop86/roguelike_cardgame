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

  double get gameOriginX => -gameWidth / 2;

  double get gameOriginY => -gameHeight / 2;

  double get gameEndX => gameWidth / 2;

  double get gameEndY => gameHeight / 2;

  Vector2 get gameTopLeft => Vector2(gameOriginX, gameOriginY);
  Vector2 get gameTopRight => Vector2(gameEndX, gameOriginY);
  Vector2 get gameBottomLeft => Vector2(gameOriginX, gameEndY);
  Vector2 get gameBottomRight => Vector2(gameEndX, gameEndY);

  // Background
  double get backgroundWidth => gameWidth;

  double get backgroundHeight => 18 * blockSize;

  Vector2 get backgroundSize => Vector2(backgroundWidth, backgroundHeight);

  double get backgroundX => 0;

  double get backgroundY => gameEndY - backgroundHeight/2;

  Vector2 get backgroundPosition => Vector2(backgroundX, backgroundY);

  // gradient
  double get topGradientX => gameOriginX;
  double get topGradientY => gameOriginY;
  Vector2 get topGradientPosition => Vector2(gameOriginX, gameOriginY);
  double get bottomGradientX => gameOriginX;
  double get bottomGradientY => gameOriginY + 26 * blockSize;
  Vector2 get bottomGradientPosition => Vector2(bottomGradientX, bottomGradientY);


  // CharacterArea
  double get characterAreaWidth => gameWidth;

  double get characterAreaHeight => 4 * blockSize;

  Vector2 get characterAreaSize =>
      Vector2(characterAreaWidth, characterAreaHeight);

  double get characterAreaX => gameOriginX;

  double get characterAreaY => gameOriginY + 6 * blockSize;

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

  double get buttonAreaX => gameOriginX;

  double get buttonAreaY => gameOriginY + 12 * blockSize;

  Vector2 get buttonAreaPosition => Vector2(buttonAreaX, buttonAreaY);

  // Button
  double get buttonWidth => 2 * blockSize;

  double get buttonHeight => 2 * blockSize;

  Vector2 get buttonSize => Vector2(buttonWidth, buttonHeight);

  // CardArea
  double get cardAreaWidth => gameWidth;

  double get cardAreaHeight => 8 * blockSize;

  Vector2 get cardAreaSize => Vector2(cardAreaWidth, cardAreaHeight);

  double get cardAreaX => gameOriginX;

  double get cardAreaY => gameOriginY + 16 * blockSize;

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

  double get mapCardAreaX => gameOriginX;

  double get mapCardAreaY => gameOriginY + 16 * blockSize;

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

  double get mapAreaX => gameOriginX;

  double get mapAreaY => gameOriginY + 12 * blockSize;

  Vector2 get mapAreaPosition => Vector2(mapAreaX, mapAreaY);

  // Button
  double get mapWidth => mapAreaWidth * 0.05;

  double get mapHeight => mapAreaHeight * 0.2;

  Vector2 get mapSize => Vector2(mapWidth, mapHeight);

  // margin
  double get margin => 20.0;

  double get miniMargin => 5.0;
}
