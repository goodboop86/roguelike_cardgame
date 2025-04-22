import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';

class Sizes {
  static final Sizes _instance = Sizes._internal();

  // factory Sizes => _instance;

  Sizes._internal();

  // Block
  static double get blockLength => 32.0;

  static Vector2 get blockSize => Vector2.all(blockLength);

  // Game
  static double get gameWidth => 13 * blockLength; // 416
  static double get gameHeight => 27 * blockLength; // 864
  static Vector2 get gameSize => Vector2(gameWidth, gameHeight);

  static double get gameOriginX => -gameWidth / 2;

  static double get gameOriginY => -gameHeight / 2;

  static double get gameEndX => gameWidth / 2;

  static double get gameEndY => gameHeight / 2;

  static Vector2 get gameTopLeft => Vector2(gameOriginX, gameOriginY);

  static Vector2 get gameTopRight => Vector2(gameEndX, gameOriginY);

  static Vector2 get gameBottomLeft => Vector2(gameOriginX, gameEndY);

  static Vector2 get gameBottomRight => Vector2(gameEndX, gameEndY);

  // Background
  static double get backgroundWidth => gameWidth;

  static double get backgroundHeight => 19 * blockLength;

  static Vector2 get backgroundSize =>
      Vector2(backgroundWidth, backgroundHeight);

  static double get backgroundX => 0;

  static double get backgroundY => gameEndY - backgroundHeight / 2;

  static Vector2 get backgroundPosition => Vector2(backgroundX, backgroundY);

  // gradient
  static double get topGradientX => gameOriginX;

  static double get topGradientY => gameOriginY;

  static Vector2 get topGradientPosition => Vector2(gameOriginX, gameOriginY);

  static double get bottomGradientX => gameOriginX;

  static double get bottomGradientY => gameOriginY + 26 * blockLength;

  static Vector2 get bottomGradientPosition =>
      Vector2(bottomGradientX, bottomGradientY);

  // CharacterArea
  static double get characterAreaWidth => gameWidth;

  static double get characterAreaHeight => 4 * blockLength;

  static Vector2 get characterAreaSize =>
      Vector2(characterAreaWidth, characterAreaHeight);

  static double get characterAreaX => gameOriginX;

  static double get characterAreaY => gameOriginY + 4 * blockLength;

  static Vector2 get characterAreaPosition =>
      Vector2(characterAreaX, characterAreaY);

  // Character
  static double get playerAreaWidth => 4 * blockLength;

  static double get playerAreaHeight => characterAreaHeight;

  static Vector2 get playerAreaSize =>
      Vector2(playerAreaWidth, playerAreaHeight);

  static double get playerAreaX => 0; // characterAreaXから見て0
  static double get playerAreaY => 1.5 * blockLength; // sprite内の余白分
  static Vector2 get playerAreaPosition => Vector2(playerAreaX, playerAreaY);

  static double get enemyAreaWidth => 4 * blockLength;

  static double get enemyAreaHeight => characterAreaHeight;

  static Vector2 get enemyAreaSize => Vector2(enemyAreaWidth, enemyAreaHeight);

  static double get enemyAreaX => characterAreaWidth - enemyAreaWidth;

  static double get enemyAreaY => 1.5 * blockLength; // sprite内の余白分
  static Vector2 get enemyAreaPosition => Vector2(enemyAreaX, enemyAreaY);

  // ButtonArea
  static double get buttonAreaWidth => gameWidth - 1 * blockLength;

  static double get buttonAreaHeight => blockLength;

  static Vector2 get buttonAreaSize =>
      Vector2(buttonAreaWidth, buttonAreaHeight);

  static double get buttonAreaX => gameOriginX + 0.5 * blockLength;

  static double get buttonAreaY => gameOriginY + 12 * blockLength;

  static Vector2 get buttonAreaPosition => Vector2(buttonAreaX, buttonAreaY);

  // Button
  static double get buttonWidth => blockLength;

  static double get buttonHeight => blockLength;

  static Vector2 get buttonSize => Vector2(buttonWidth, buttonHeight);

  // WideButton
  static double get wideButtonWidth => 3 * blockLength;

  static double get wideButtonHeight => 1 * blockLength;

  static Vector2 get wideButtonSize =>
      Vector2(wideButtonWidth, wideButtonHeight);

  // CardArea
  static double get cardAreaWidth => gameWidth - 1 * blockLength;

  static double get cardAreaHeight => 10 * blockLength;

  static Vector2 get cardAreaSize => Vector2(cardAreaWidth, cardAreaHeight);

  static double get cardAreaX => gameOriginX + 0.5 * blockLength;

  static double get cardAreaY => gameOriginY + 14 * blockLength;

  static Vector2 get cardAreaPosition => Vector2(cardAreaX, cardAreaY);

  // Card
  static double get cardWidth => 3 * blockLength;

  static double get cardHeight => 4 * blockLength;

  static Vector2 get cardSize => Vector2(cardWidth, cardHeight);

  static double get cardMargin => 0.5 * blockLength;

  // MapCardArea
  static double get mapCardAreaWidth => gameWidth - 1 * blockLength;

  static double get mapCardAreaHeight => 8 * blockLength;

  static Vector2 get mapCardAreaSize =>
      Vector2(mapCardAreaWidth, mapCardAreaHeight);

  static double get mapCardAreaX => gameOriginX + 0.5 * blockLength;

  static double get mapCardAreaY => gameOriginY + 16 * blockLength;

  static Vector2 get mapCardAreaPosition => Vector2(mapCardAreaX, mapCardAreaY);

  // MapCard
  static double get mapCardWidth => cardWidth;

  static double get mapCardHeight => cardHeight;

  static Vector2 get mapCardSize => Vector2(mapCardWidth, mapCardHeight);

  static double get mapCardMargin => cardMargin;

  // MapArea
  static double get mapAreaWidth => gameWidth - 1 * blockLength;

  static double get mapAreaHeight => 3 * blockLength;

  static Vector2 get mapAreaSize => Vector2(mapAreaWidth, mapAreaHeight);

  static double get mapAreaX => gameOriginX + 0.5 * blockLength;

  static double get mapAreaY => gameOriginY + 12 * blockLength;

  static Vector2 get mapAreaPosition => Vector2(mapAreaX, mapAreaY);

  // Map
  static double get mapWidth => mapAreaWidth * 0.05;

  static double get mapHeight => mapAreaHeight * 0.2;

  static Vector2 get mapSize => Vector2(mapWidth, mapHeight);

  // BoolDialog
  static double get boolDialogWidth => 8 * blockLength;

  static double get boolDialogHeight => 12 * blockLength;

  static Vector2 get boolDialogSize =>
      Vector2(boolDialogWidth, boolDialogHeight);

  // DialogButton
  static double get dialogButtonWidth => 4 * blockLength;

  static double get dialogButtonHeight => 1.5 * blockLength;

  static Vector2 get dialogButtonSize =>
      Vector2(dialogButtonWidth, dialogButtonHeight);

  // NPCDialog
  static double get npcDialogWidth => 12 * Sizes.blockLength;
  static double get npcDialogHeight => 4 * Sizes.blockLength;
  static Vector2 get npcDialogSize => Vector2(npcDialogWidth, npcDialogHeight);

  static double get npcDialogX => gameOriginX + 0.5 * Sizes.blockLength;
  static double get npcDialogY => gameOriginY + 1 * Sizes.blockLength;
  static Vector2 get npcDialogPosition => Vector2(npcDialogX, npcDialogY);

  // Support dialog
  static double get supportDialogWidth => 12 * Sizes.blockLength;
  static double get supportDialogHeight => 1 * Sizes.blockLength;
  static Vector2 get supportDialogSize =>
      Vector2(supportDialogWidth, supportDialogHeight);

  static double get supportDialogX => gameOriginX + 0.5 * Sizes.blockLength;
  static double get supportDialogY => gameOriginY + 9 * Sizes.blockLength;
  static Vector2 get supportDialogPosition =>
      Vector2(supportDialogX, supportDialogY);

  // UIArea
  static double get uiAreaWidth => gameWidth - 1 * blockLength;

  static double get uiAreaHeight => 1 * blockLength;

  static Vector2 get uiAreaSize => Vector2(uiAreaWidth, uiAreaHeight);

  static double get uiAreaX => gameOriginX + 0.5 * blockLength;

  static double get uiAreaY => gameOriginY + 25 * blockLength;

  static Vector2 get uiAreaPosition => Vector2(uiAreaX, uiAreaY);

  // margin
  static double get margin => 20.0;

  static double get miniMargin => 5.0;
}

class CANVAS {
  Logger log = Logger('CanvasSizes');

  final Vector2 size;

  late double x;
  late double y;

  double get centerX => x / 2;

  double get npcDialogWidth => 12 * Sizes.blockLength;
  double get npcDialogHeight => 4 * Sizes.blockLength;
  Vector2 get npcDialogSize => Vector2(npcDialogWidth, npcDialogHeight);

  Vector2 get npcDialogPosition => Vector2(centerX, y / 10);

  double get npcPopupWidth => 12 * Sizes.blockLength;
  double get npcPopupHeight => 12 * Sizes.blockLength;
  Vector2 get npcPopupSize => Vector2(npcPopupWidth, npcPopupHeight);

  Vector2 get npcPopupPosition => Vector2(centerX, y / 2.5);

  // singleton method
  CANVAS._(this.size) {
    x = size.x;
    y = size.y;
  }

  static CANVAS? _instance;

  static CANVAS get sizes {
    if (_instance == null) {
      throw Exception(
          "Singleton is not initialized. Call initialize(x) first.");
    }
    return _instance!;
  }

  static void initialize(Vector2 size) {
    if (_instance == null) {
      _instance = CANVAS._(size);
      debugPrint("Construct Singleton CanvasSize: size = $size");
    } else {
      debugPrint("CanvasSize is already constructed.");
    }
  }
}
