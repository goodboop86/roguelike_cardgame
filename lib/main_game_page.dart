import 'dart:async';

import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roguelike_cardgame/providers/card_provider.dart';

import 'main_game.dart';
import 'models/enum.dart';

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
                OVERLAY.cardOverlay.name: (BuildContext context, MainGame game) {
                  return CardOverlayWidget(game: game);
                },
                OVERLAY.characterOverlay.name: (BuildContext context, MainGame game) {
                  return CharacterOverlayWidget(game: game);
                },
                OVERLAY.enemyTurnOverlay.name: (BuildContext context, MainGame game) {
                  return EnemyTurnOverlayWidget(game: game);
                },
                OVERLAY.autoDisappearingOverlay.name:
                    (BuildContext context, MainGame game) {
                  return AutoDisappearingOverlayWidget(game: game);
                }
              }),
        ),
      ],
    ));
  }
}

class CardOverlayWidget extends ConsumerWidget {
  final MainGame game;

  const CardOverlayWidget({super.key, required this.game});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardState = ref.read(cardProvider);
    return GestureDetector(
      onTap: () {
        game.overlays.remove(OVERLAY.cardOverlay.name);
        game.resumeEngine();
      },
      child: Container(
        color: Colors.black.withValues(alpha: 0.5),
        child: Center(
          child: Container(
            width: 200,
            height: 100,
            color: Colors.white,
            child: Center(
              child: Text(cardState.toJsonString()),
            ),
          ),
        ),
      ),
    );
  }
}

class EnemyTurnOverlayWidget extends ConsumerWidget {
  final MainGame game;

  const EnemyTurnOverlayWidget({super.key, required this.game});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        game.overlays.remove(OVERLAY.enemyTurnOverlay.name);
        game.resumeEngine();
      },
      child: Container(
        color: Colors.black.withValues(alpha: 0.5),
        child: Center(
          child: Container(
            width: 200,
            height: 100,
            color: Colors.white,
            child: const Center(
              child: Text("EnemyTurn"),
            ),
          ),
        ),
      ),
    );
  }
}

class CharacterOverlayWidget extends ConsumerWidget {
  final MainGame game;

  const CharacterOverlayWidget({super.key, required this.game});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 画面サイズの8割の領域を計算
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height * 0.6;

    return GestureDetector(
      onTap: () {
        game.overlays.remove(OVERLAY.characterOverlay.name);
        game.resumeEngine();
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: ColoredBox(
                    color: Colors.yellow, // プレイヤー部分を黄色に設定
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ColoredBox(
                    color: Colors.black.withValues(alpha: 0.5), // 領域部分を透過の黒に設定
                    child: const SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'ここにテキストを表示します。\n\n'
                        'スクロール可能なテキストボックスです。\n\n'
                        'スクロール可能なテキストボックスです。\n\n'
                        'スクロール可能なテキストボックスです。\n\n'
                        'スクロール可能なテキストボックスです。\n\n'
                        'スクロール可能なテキストボックスです。\n\n'
                        'スクロール可能なテキストボックスです。\n\n'
                        'スクロール可能なテキストボックスです。\n\n'
                        'スクロール可能なテキストボックスです。\n\n'
                        'スクロール可能なテキストボックスです。\n\n'
                        'スクロール可能なテキストボックスです。\n\n'
                        'スクロール可能なテキストボックスです。\n\n'
                        'スクロール可能なテキストボックスです。\n\n'
                        'スクロール可能なテキストボックスです。\n\n'
                        'スクロール可能なテキストボックスです。\n\n'
                        'スクロール可能なテキストボックスです。\n\n'
                        'スクロール可能なテキストボックスです。\n\n'
                        'スクロール可能なテキストボックスです。\n\n'
                        'スクロール可能なテキストボックスです。\n\n'
                        'スクロール可能なテキストボックスです。\n\n'
                        '長い文章も表示できます。',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AutoDisappearingOverlayWidget extends StatelessWidget {
  final MainGame game;

  const AutoDisappearingOverlayWidget({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    // 3秒後にオーバーレイを削除
    Timer(const Duration(seconds: 1), () {
      game.overlays.remove(OVERLAY.autoDisappearingOverlay.name);
      game.resumeEngine();
    });

    return Container(
      color: Colors.black.withValues(alpha: 0.5),
      child: const Center(
        child: Text("AutoDisappearingOverlay",
            style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
