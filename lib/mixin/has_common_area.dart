import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:roguelike_cardgame/main_game.dart';
import 'package:roguelike_cardgame/models/player_state.dart';
import 'package:roguelike_cardgame/providers/player_provider.dart';
import '../components/background_component.dart';
import '../components/button_component.dart';
import '../components/card_area_component.dart';
import '../components/enemy_component.dart';
import '../components/player_component.dart';
import '../components/text_component.dart';
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

  void addTopUi({hasEnemy = false}) {
    final uiArea = TopUiAreaComponent();

    PlayerState state = ref.watch(playerProvider);

    uiArea.add(PlayerStatus());

    if(hasEnemy){
      log.info("add enemy status");
      uiArea.add(EnemyStatus());
    }

    add(uiArea);
  }

  void addBottomUi() {
    final uiArea = BottomUiAreaComponent();
    add(uiArea);

    final homeButton = SpriteButtons.homeButton(onPressed: () {
      game.router.pushNamed(ROUTE.home.name);
    });

    final questionButton = SpriteButtons.questionButton(onPressed: () {});

    uiArea.addAll([
      homeButton,
      questionButton
        ..position = Vector2(Sizes.bottomUiAreaWidth - Sizes.blockLength, 0)
    ]);
  }
}
