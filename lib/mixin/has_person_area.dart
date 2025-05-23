import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:roguelike_cardgame/main_game.dart';
import '../components/background_component.dart';
import '../components/button_component.dart';
import '../components/text_component.dart';
import '../models/enum.dart';
import '../providers/sizes.dart';
import '../spritesheet/spritesheet.dart';
import '../valueroutes/popup.dart';

mixin HasPersonArea on Component, HasGameRef<MainGame>, RiverpodComponentMixin {
  Logger log = Logger('HasPersonArea');

  late TextBoxComponent textBox;

  PopupWindow dialog = PopupWindow.npcDialog(
  );

  Future<void> startDialog() async {
    textBox = TextBoxes.dialogText()
      ..text = 'やあ、\nテストNPCだよ。'
          'ここにテキストを\n'
          '書くと表示されるよ。\n'
          'ーーーーーーーーーーーーーーーーーー\n'
          'ーーーーーーーーーーーーー'
      ..onComplete = () async {
        String value = await npcDialog();

        SupportDialog supportDialog = SupportDialog(text: value.toString());

        add(supportDialog);

        dialog.remove(textBox);

        textBox = TextBoxes.dialogText()
          ..text = 'またおいで..............'
          ..onComplete = () async {
            dialog.add(SpriteButtons.dialogNextButton(onPressed: () {
              game.router.pushNamed(ROUTE.home.name);
            }));
          };

        dialog.add(textBox);
      };

    dialog.add(textBox);

    add(dialog);
  }

  Future<String> npcDialog() async {
    int value = await game.router.pushAndWait(MyPopupRoute());
    log.info(value);
    return value.toString();
  }
}
