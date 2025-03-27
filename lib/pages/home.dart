
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';

import '../main_game.dart';

class HomePage extends World with HasGameReference<MainGame> {
  late final ButtonComponent button;

  @override
  Future<void> onLoad() async {
    button = ButtonComponent(
      button: RectangleComponent(
        size: Vector2(150, 50),
        paint: BasicPalette.blue.paint(),
        anchor: Anchor.topLeft,
      ),
      buttonDown: RectangleComponent(
        size: Vector2(150, 50),
        paint: BasicPalette.blue.paint(),
        anchor: Anchor.topLeft,
      ),
      anchor: Anchor.topLeft,
      onPressed: () {
        game.router.pushNamed('explore');
      },
    )..anchor = Anchor.center;

    add(button);
  }
}
