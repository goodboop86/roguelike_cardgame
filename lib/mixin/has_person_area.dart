import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:roguelike_cardgame/main_game.dart';
import '../components/background_component.dart';
import '../components/text_component.dart';
import '../providers/sizes.dart';
import '../valueroutes/popup.dart';

mixin HasPersonArea on Component, HasGameRef<MainGame>, RiverpodComponentMixin {
  Logger log = Logger('HasPersonArea');

  late TextBoxComponent textComponent1;

  DialogBackground dialog = DialogBackground(
    position: Sizes.npcDialogPosition,
    size: Sizes.npcDialogSize,
    anchor: Anchor.topLeft,
  )..paint.color = Colors.black.withValues(alpha: 0.3);

  Future<void> startDialog() async {
    textComponent1 = DialogText()
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

        textComponent1 = DialogText()
          ..text = 'またおいで..............'
          ..onComplete = () async {
            log.info("end text.");
          };

        dialog.add(textComponent1);
      };

    dialog.add(textComponent1);

    add(dialog);
  }

  Future<String> npcDialog() async {
    int value = await game.router.pushAndWait(NPCDialogRoute());
    log.info(value);
    return value.toString();
  }
}
