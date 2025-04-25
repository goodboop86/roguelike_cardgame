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

  late TextBoxComponent textComponent1;

  PopupWindow dialog = PopupWindow(
    position: Sizes.npcDialogPosition,
    size: Sizes.npcDialogSize,
    anchor: Anchor.topLeft,
  )..paint.color = Colors.black.withValues(alpha: 0.3);

  Future<void> startDialog() async {
    textComponent1 = TextBoxes.dialogText()
      ..text = 'やあ、\nテストNPCだよ。'
          'ここにテキストを\n'
          '書くと表示されるよ。\n'
          'ーーーーーーーーーーーーーーーーーー\n'
          'ーーーーーーーーーーーーー'
      ..onComplete = () async {
        String value = await npcDialog();

        SupportDialog supportDialog = SupportDialog(text: value.toString());

        add(supportDialog);

        dialog.remove(textComponent1);

        textComponent1 = TextBoxes.dialogText()
          ..text = 'またおいで..............'
          ..onComplete = () async {
            dialog.add(UIButtonComponent(
                button: AssetSource().getSprite(name: "right_arrow.png"))
              ..size = Sizes.blockSize * 0.8
              ..position = Sizes.npcDialogSize - Sizes.blockSize
              ..priority = 100
              ..onPressed = () {
                game.router.pushNamed(ROUTE.home.name);
              });
          };

        dialog.add(textComponent1);
      };

    dialog.add(textComponent1);

    add(dialog);
  }

  Future<String> npcDialog() async {
    int value = await game.router.pushAndWait(MyPopupRoute());
    log.info(value);
    return value.toString();
  }
}
