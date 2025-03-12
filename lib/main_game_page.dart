import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import 'main_game.dart';

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
            GameWidget(game: game),
          ],
        )
    );
  }

}

