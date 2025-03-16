import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main_game.dart';

final GlobalKey<RiverpodAwareGameWidgetState> gameWidgetKey =
GlobalKey<RiverpodAwareGameWidgetState>();

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
            ProviderScope(child: RiverpodAwareGameWidget(key:gameWidgetKey,game: game)),
          ],
        )
    );
  }

}

