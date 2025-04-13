import 'dart:ui';

import 'package:flame/components.dart' hide Timer;
import 'package:roguelike_cardgame/main_game.dart';

import '../providers/sizes.dart';

class GradientBackground extends PositionComponent
    with HasGameReference<MainGame> {
  GradientBackground({required super.position, required this.shader})
      : super(anchor: Anchor.topLeft);

  Shader shader;

  @override
  void render(Canvas canvas) {
    Paint paint = Paint()..shader = shader;
    canvas.drawRect(
        Rect.fromLTWH(0, 0, Sizes().gameWidth, Sizes().gameHeight), paint);
  }
}
