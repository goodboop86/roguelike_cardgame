import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:roguelike_cardgame/main_game.dart';
import '../components/background_component.dart';
import '../components/button_component.dart';
import '../components/card_area_component.dart';
import '../components/enemy_component.dart';
import '../components/player_component.dart';
import '../models/enum.dart';
import '../providers/sizes.dart';
import '../spritesheet/spritesheet.dart';

mixin HasCommonArea on Component, HasGameRef<MainGame>, RiverpodComponentMixin {
  Logger log = Logger('WorldMixin');

  Future<void> addBackgrounds() async {
    add(AssetSource().getParallax(name: "default")!);

    log.info("---> ${Sizes.gameEndY}");
    add(AssetSource().getSpriteComponent(
        name: "background.png",
        key: ComponentKey.named("Background"),
        size: Sizes.backgroundSize)!
      ..position = Sizes.backgroundPosition
      ..priority = 0);
    addAll([
      GradientBackground.topGradient(),
      GradientBackground.bottomGradient()
    ]);
  }

  Future<void> addCharacters() async {
    final characterArea = CharacterAreaComponent(
      key: ComponentKey.named('BattleCharacterArea'),
      position: Sizes.characterAreaPosition,
      size: Sizes.characterAreaSize, // カードエリアのサイズ
    );
    add(characterArea);

    bool playerExists =
        characterArea.children.any((component) => component is PlayerComponent);
    if (!playerExists) {
      // Player の配置 (左上)
      PlayerComponent player =
          PlayerComponent(key: ComponentKey.named('Player'), path: 'player.png')
            ..size = Sizes.playerAreaSize
            ..position = Sizes.playerAreaPosition;

      characterArea.add(player);
    }

    bool enemyExists =
        characterArea.children.any((component) => component is EnemyComponent);
    if (!enemyExists) {
      // Player の配置 (左上)
      EnemyComponent enemy =
          EnemyComponent(key: ComponentKey.named('Enemy'), path: 'dragon.png')
            ..size = Sizes.enemyAreaSize
            ..position = Sizes.enemyAreaPosition;
      characterArea.add(enemy);
    }
  }

  void addUi() {
    final uiArea = UiAreaComponent(
      position: Sizes.uiAreaPosition,
      size: Sizes.uiAreaSize, // カードエリアのサイズ
    );
    add(uiArea);

    final homeButton = SpriteButtons.homeButton(onPressed: () {
      game.router.pushNamed(ROUTE.home.name);
    });

    final questionButton = SpriteButtons.questionButton(onPressed: () {});

    uiArea.addAll([
      homeButton,
      questionButton
        ..position = Vector2(Sizes.uiAreaWidth - Sizes.blockLength, 0)
    ]);
  }

  Future<T> pushAndWait<T>(ValueRoute<T> route) async {
    return await game.router.pushAndWait(route);
  }
}
