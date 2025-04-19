import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:roguelike_cardgame/main_game.dart';
import '../components/basic_component.dart';
import '../components/button_component.dart';
import '../components/card_area_component.dart';
import '../components/card_component.dart';
import '../models/card.dart';
import '../models/card_effect.dart';
import '../models/enum.dart';
import '../providers/deck_provider.dart';
import '../providers/player_provider.dart';
import '../providers/sizes.dart';
import '../valueroutes/popup.dart';

mixin HasPersonArea on Component, HasGameRef<MainGame>, RiverpodComponentMixin {
  Logger log = Logger('HasPersonArea');

  TextBoxComponent textComponent1 = TextBoxComponent(
      size: Sizes.npcDialogSize,
      text: 'やあ、\nテストNPCだよ。'
          'ここにテキストを\n'
          '書くと表示されるよ。\n'
          'ーーーーーーーーーーーーーーーーーー\n'
          'ーーーーーーーーーーーーー',
      boxConfig: const TextBoxConfig(
          timePerChar: 0.03,
          maxWidth: 30.0,
          growingBox: true,
          margins: EdgeInsets.fromLTRB(10, 10, 10, 10)),
      textRenderer: TextPaint(
          style: const TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontFamily: 'monospace', // 等幅フォントが見やすい
      )));

  DialogBackground dialog = DialogBackground(
    position: Sizes.npcDialogPosition,
    size: Sizes.npcDialogSize,
    anchor: Anchor.topLeft,
  )..paint.color = Colors.black.withValues(alpha: 0.1);

  Future<void> startDialog() async {
    final overlay = OverlayComponent(
      paint: Paint()..color = Colors.black.withValues(alpha: 0.5),
      size: Sizes.gameSize,
      position: Sizes.gameTopLeft,
      anchor: Anchor.topLeft,
    );

    dialog.add(textComponent1
      ..text = 'やあ、\nテストNPCだよ。'
          'ここにテキストを\n'
          '書くと表示されるよ。\n'
          'ーーーーーーーーーーーーーーーーーー\n'
          'ーーーーーーーーーーーーー'
      ..onComplete = () async {
        String value = await popUp();

        textComponent1.text = value;
      });

    add(overlay);
    overlay.add(dialog);
    // game.router.pushAndWait(NPCDialogRoute());
  }

  Future<String> popUp() async {
    int value = await game.router.pushAndWait(NPCDialogRoute());
    log.info(value);
    return value.toString();
  }
}
