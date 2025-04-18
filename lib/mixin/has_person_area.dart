import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
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

  Future<void> startDialog() async {
    game.router.pushAndWait(NPCDialogRoute());
  }
}
