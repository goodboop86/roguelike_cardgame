
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class RoundedRectangleOutlineBox extends PositionComponent {
  final double borderRadius;
  final double strokeWidth;

  RoundedRectangleOutlineBox({
    required this.borderRadius,
    this.strokeWidth = 2.0,
    Vector2? position,
    Vector2? size,
    Anchor? anchor,
  }) : super(position: position, size: size, anchor: anchor);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // 塗りつぶし (透過の黒)
    final fillPaint = Paint()
      ..color = Colors.black.withOpacity(0.7) // 透過の黒
      ..style = PaintingStyle.fill;

    // 輪郭線 (赤)
    final strokePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final rrect = RRect.fromRectAndRadius(
      size.toRect(),
      Radius.circular(borderRadius),
    );

    canvas.drawRRect(rrect, fillPaint);   // まず塗りつぶし
    canvas.drawRRect(rrect, strokePaint); // 次に輪郭線
  }
}
