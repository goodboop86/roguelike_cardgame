import 'package:flame/components.dart';
import 'package:flame/game.dart';

class Sizes {
  static final Sizes _instance = Sizes._internal();

  factory Sizes() => _instance;

  Sizes._internal();

  // Block
  double get blockLength => 32.0;
  Vector2 get blockSize => Vector2.all(blockLength);

  // Game
  double get gameWidth => 13 * blockLength; // 416

  double get gameHeight => 27 * blockLength; // 864

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

  double get backgroundHeight => 18 * blockLength;

  Vector2 get backgroundSize => Vector2(backgroundWidth, backgroundHeight);

  double get backgroundX => 0;

  double get backgroundY => gameEndY - backgroundHeight / 2;

  Vector2 get backgroundPosition => Vector2(backgroundX, backgroundY);

  // gradient
  double get topGradientX => gameOriginX;
  double get topGradientY => gameOriginY;
  Vector2 get topGradientPosition => Vector2(gameOriginX, gameOriginY);
  double get bottomGradientX => gameOriginX;
  double get bottomGradientY => gameOriginY + 26 * blockLength;
  Vector2 get bottomGradientPosition =>
      Vector2(bottomGradientX, bottomGradientY);

  // CharacterArea
  double get characterAreaWidth => gameWidth;

  double get characterAreaHeight => 4 * blockLength;

  Vector2 get characterAreaSize =>
      Vector2(characterAreaWidth, characterAreaHeight);

  double get characterAreaX => gameOriginX;

  double get characterAreaY => gameOriginY + 5 * blockLength;

  Vector2 get characterAreaPosition => Vector2(characterAreaX, characterAreaY);

  // Character

  double get playerAreaWidth => 4 * blockLength;

  double get playerAreaHeight => characterAreaHeight;

  Vector2 get playerAreaSize => Vector2(playerAreaWidth, playerAreaHeight);

  double get playerAreaX => 0; // characterAreaXから見て0
  double get playerAreaY => 1.5 * blockLength; // sprite内の余白分
  Vector2 get playerAreaPosition => Vector2(playerAreaX, playerAreaY);

  double get enemyAreaWidth => 4 * blockLength;

  double get enemyAreaHeight => characterAreaHeight;

  Vector2 get enemyAreaSize => Vector2(enemyAreaWidth, enemyAreaHeight);

  double get enemyAreaX => characterAreaWidth - enemyAreaWidth;
  double get enemyAreaY => 1.5 * blockLength; // sprite内の余白分
  Vector2 get enemyAreaPosition => Vector2(enemyAreaX, enemyAreaY);

  // ButtonArea
  double get buttonAreaWidth => gameWidth - 1 * blockLength;

  double get buttonAreaHeight => blockLength;

  Vector2 get buttonAreaSize => Vector2(buttonAreaWidth, buttonAreaHeight);

  double get buttonAreaX => gameOriginX + 0.5 * blockLength;

  double get buttonAreaY => gameOriginY + 12 * blockLength;

  Vector2 get buttonAreaPosition => Vector2(buttonAreaX, buttonAreaY);

  // Button
  double get buttonWidth => blockLength;

  double get buttonHeight => blockLength;

  Vector2 get buttonSize => Vector2(buttonWidth, buttonHeight);

  // WideButton
  double get wideButtonWidth => 3 * blockLength;

  double get wideButtonHeight => 1 * blockLength;

  Vector2 get wideButtonSize => Vector2(wideButtonWidth, wideButtonHeight);

  // CardArea
  double get cardAreaWidth => gameWidth - 1 * blockLength;

  double get cardAreaHeight => 10 * blockLength;

  Vector2 get cardAreaSize => Vector2(cardAreaWidth, cardAreaHeight);

  double get cardAreaX => gameOriginX + 0.5 * blockLength;

  double get cardAreaY => gameOriginY + 14 * blockLength;

  Vector2 get cardAreaPosition => Vector2(cardAreaX, cardAreaY);

  // Card
  double get cardWidth => 3 * blockLength;

  double get cardHeight => 4 * blockLength;

  Vector2 get cardSize => Vector2(cardWidth, cardHeight);

  double get cardMargin => 0.5 * blockLength;

  // MapCardArea
  double get mapCardAreaWidth => gameWidth - 1 * blockLength;

  double get mapCardAreaHeight => 8 * blockLength;

  Vector2 get mapCardAreaSize => Vector2(mapCardAreaWidth, mapCardAreaHeight);

  double get mapCardAreaX => gameOriginX + 0.5 * blockLength;

  double get mapCardAreaY => gameOriginY + 16 * blockLength;

  Vector2 get mapCardAreaPosition => Vector2(mapCardAreaX, mapCardAreaY);

  // MapCard
  double get mapCardWidth => cardWidth;

  double get mapCardHeight => cardHeight;

  Vector2 get mapCardSize => Vector2(mapCardWidth, mapCardHeight);

  double get mapCardMargin => cardMargin;

  // MapArea
  double get mapAreaWidth => gameWidth - 1 * blockLength;

  double get mapAreaHeight => 3 * blockLength;

  Vector2 get mapAreaSize => Vector2(mapAreaWidth, mapAreaHeight);

  double get mapAreaX => gameOriginX + 0.5 * blockLength;

  double get mapAreaY => gameOriginY + 12 * blockLength;

  Vector2 get mapAreaPosition => Vector2(mapAreaX, mapAreaY);

  // Map
  double get mapWidth => mapAreaWidth * 0.05;

  double get mapHeight => mapAreaHeight * 0.2;

  Vector2 get mapSize => Vector2(mapWidth, mapHeight);

  // Dialog

  double get dialogWidth => 8 * blockLength;

  double get dialogHeight => 12 * blockLength;

  Vector2 get dialogSize => Vector2(dialogWidth, dialogHeight);

  // DialogButton

  double get dialogButtonWidth => 4 * blockLength;

  double get dialogButtonHeight => 1.5 * blockLength;

  Vector2 get dialogButtonSize =>
      Vector2(dialogButtonWidth, dialogButtonHeight);

  // UIArea
  double get uiAreaWidth => gameWidth - 1 * blockLength;

  double get uiAreaHeight => 1 * blockLength;

  Vector2 get uiAreaSize => Vector2(uiAreaWidth, uiAreaHeight);

  double get uiAreaX => gameOriginX + 0.5 * blockLength;

  double get uiAreaY => gameOriginY + 25 * blockLength;

  Vector2 get uiAreaPosition => Vector2(uiAreaX, uiAreaY);

  // margin
  double get margin => 20.0;

  double get miniMargin => 5.0;
}
