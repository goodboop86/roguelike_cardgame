import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

import '../models/enum.dart';

class SpriteSource {
  late SpriteSheet playerSpriteSheet;
  late SpriteSheet enemySpriteSheet;

  SpriteSource() {}

  Future<void> load() async {
    playerSpriteSheet = SpriteSheet(
      image: await Flame.images.load('dragon.png'),
      srcSize: Vector2(48.0, 48.0),
      spacing: 16.0
    );
    enemySpriteSheet = SpriteSheet(
      image: await Flame.images.load('swordsman.png'),
      srcSize: Vector2(24.0, 24.0),
    );
  }

  SpriteAnimationGroupComponent getAnimation() {
    SpriteAnimation idle =
        playerSpriteSheet.createAnimation(row: 0, stepTime: 0.15, to: 2);
    SpriteAnimation ready =
        playerSpriteSheet.createAnimation(row: 1, stepTime: 0.15, to: 2);

    SpriteAnimation run =
        playerSpriteSheet.createAnimation(row: 2, stepTime: 0.13, to: 4);

    SpriteAnimation crawl =
        playerSpriteSheet.createAnimation(row: 3, stepTime: 0.1, to: 4);

    SpriteAnimation climb =
        playerSpriteSheet.createAnimation(row: 4, stepTime: 0.15, to: 2);

    SpriteAnimation jump =
        playerSpriteSheet.createAnimation(row: 5, stepTime: 0.1, to: 3, loop: false);

    SpriteAnimation push =
        playerSpriteSheet.createAnimation(row: 6, stepTime: 0.1, to: 3, loop: false);

    SpriteAnimation jab =
        playerSpriteSheet.createAnimation(row: 7, stepTime: 0.1, to: 3, loop: false);

    SpriteAnimation slash =
        playerSpriteSheet.createAnimation(row: 8, stepTime: 0.1, to: 4, loop: false);

    SpriteAnimation shot =
        playerSpriteSheet.createAnimation(row: 9, stepTime: 0.1, to: 4, loop: false);

    SpriteAnimation fire =
        playerSpriteSheet.createAnimation(row: 10, stepTime: 0.15, to: 2, loop: false);

    SpriteAnimation block =
        playerSpriteSheet.createAnimation(row: 11, stepTime: 0.15, to: 2, loop: false);

    SpriteAnimation death =
        playerSpriteSheet.createAnimation(row: 12, stepTime: 0.1, to: 3, loop: false);

    SpriteAnimation roll =
        playerSpriteSheet.createAnimation(row: 13, stepTime: 0.05, to: 9, loop: false);

    SpriteAnimationGroupComponent animationGroup =
        SpriteAnimationGroupComponent<SpriteType>(
          anchor: Anchor.center,
          priority: 100,
          size: Vector2(128, 128),
      animations: {
        SpriteType.idle: playerSpriteSheet.createAnimation(row: 0, stepTime: 0.3, to: 2),
        SpriteType.ready: playerSpriteSheet.createAnimation(row: 1, stepTime: 0.3, to: 2),
        SpriteType.run: playerSpriteSheet.createAnimation(row: 2, stepTime: 0.15, to: 4),
        SpriteType.crawl: playerSpriteSheet.createAnimation(row: 3, stepTime: 0.15, to: 4),
        SpriteType.climb: playerSpriteSheet.createAnimation(row: 4, stepTime: 0.3, to: 2),
        SpriteType.jump: playerSpriteSheet.createAnimation(row: 5, stepTime: 0.2, to: 3, loop: false),
        SpriteType.push: playerSpriteSheet.createAnimation(row: 6, stepTime: 0.2, to: 3, loop: false),
        SpriteType.jab: playerSpriteSheet.createAnimation(row: 7, stepTime: 0.2, to: 3, loop: false),
        SpriteType.slash: playerSpriteSheet.createAnimation(row: 8, stepTime: 0.15, to: 4, loop: false),
        SpriteType.shot: playerSpriteSheet.createAnimation(row: 9, stepTime: 0.15, to: 4, loop: false),
        SpriteType.fire: playerSpriteSheet.createAnimation(row: 10, stepTime: 0.3, to: 2, loop: false),
        SpriteType.block: playerSpriteSheet.createAnimation(row: 11, stepTime: 0.3, to: 2, loop: false),
        SpriteType.death: playerSpriteSheet.createAnimation(row: 12, stepTime: 0.2, to: 3, loop: false),
        SpriteType.roll: playerSpriteSheet.createAnimation(row: 13, stepTime: 0.067, to: 9, loop: false),
      },
      current: SpriteType.death,
    );

    animationGroup.animationTickers?[SpriteType.jump]?.onComplete = (){
      print("jumped!");
      animationGroup.current = SpriteType.slash;
    };
    animationGroup.animationTickers?[SpriteType.slash]?.onComplete = (){
      print("slashed!");
      animationGroup.current = SpriteType.jump;
    };
    animationGroup.animationTickers?[SpriteType.idle]?.onStart = (){print("idle!");};


    return animationGroup;
  }
}
