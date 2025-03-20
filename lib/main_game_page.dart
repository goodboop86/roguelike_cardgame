import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main_game.dart';

final GlobalKey<RiverpodAwareGameWidgetState<MainGame>> gameWidgetKey =
    GlobalKey<RiverpodAwareGameWidgetState<MainGame>>();

class MainGamePage extends StatefulWidget {
  const MainGamePage({super.key});

  @override
  MainGamePageState createState() => MainGamePageState();
}

class MainGamePageState extends State<MainGamePage> {
  MainGame game = MainGame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        ProviderScope(
          child: RiverpodAwareGameWidget<MainGame>(
              key: gameWidgetKey,
              game: game,
              overlayBuilderMap: {
                'myOverlay': (BuildContext context, MainGame game) {
                  return MyOverlayWidget(game: game);
                },
              }),
        ),
      ],
    ));
  }
}


class MyOverlayWidget extends StatelessWidget {
  final MainGame game;

  MyOverlayWidget({required this.game});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        game.overlays.remove('myOverlay');
        game.resumeEngine();
      },
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Container(
            width: 200,
            height: 100,
            color: Colors.white,
            child: Center(
              child: Text('Overlay Content'),
            ),
          ),
        ),
      ),
    );
  }
}
