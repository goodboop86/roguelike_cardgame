import 'package:flame/events.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flame/components.dart';
import 'package:logging/logging.dart';

import '../models/enum.dart';

class SpriteAnimationGroups extends SpriteAnimationGroupComponent
    with RiverpodComponentMixin, TapCallbacks, HasGameRef {
  Logger log = Logger('CharacterAnimationComponent');

  SpriteAnimationGroups.character({
    required super.key,
    required sheet,
    super.size,
    super.position,
    super.anchor,
    super.priority,
    super.current,
  }) {
    super.animations = {
      CharacterState.idle: sheet.createAnimation(row: 0, stepTime: 0.3, to: 2),
      CharacterState.ready: sheet.createAnimation(row: 1, stepTime: 0.3, to: 2),
      CharacterState.run: sheet.createAnimation(row: 2, stepTime: 0.15, to: 4),
      CharacterState.crawl:
          sheet.createAnimation(row: 3, stepTime: 0.15, to: 4),
      CharacterState.climb: sheet.createAnimation(row: 4, stepTime: 0.3, to: 2),
      CharacterState.jump:
          sheet.createAnimation(row: 5, stepTime: 0.2, to: 3, loop: false),
      CharacterState.push:
          sheet.createAnimation(row: 6, stepTime: 0.2, to: 3, loop: false),
      CharacterState.jab:
          sheet.createAnimation(row: 7, stepTime: 0.2, to: 3, loop: true),
      CharacterState.slash:
          sheet.createAnimation(row: 8, stepTime: 0.15, to: 4, loop: false),
      CharacterState.shot:
          sheet.createAnimation(row: 9, stepTime: 0.15, to: 4, loop: false),
      CharacterState.fire:
          sheet.createAnimation(row: 10, stepTime: 0.3, to: 2, loop: false),
      CharacterState.block:
          sheet.createAnimation(row: 11, stepTime: 0.3, to: 2, loop: false),
      CharacterState.death:
          sheet.createAnimation(row: 12, stepTime: 0.2, to: 3, loop: false),
      CharacterState.roll:
          sheet.createAnimation(row: 13, stepTime: 0.067, to: 9, loop: false)
    };

    animationTickers?[CharacterState.jump]?.onComplete = () {
      log.info("jumped!");
      current = CharacterState.slash;
    };
    animationTickers?[CharacterState.slash]?.onComplete = () {
      log.info("slashed!");
      current = CharacterState.jump;
    };
    animationTickers?[CharacterState.idle]?.onStart = () {
      log.info("idle!");
    };
  }

  SpriteAnimationGroups.containers({
    required super.key,
    required sheet,
    super.size,
    super.position,
    super.anchor,
    super.priority,
    super.current,
  }) {
    super.animations = {
      ContainerState.woodenChestBoxIdle:
          sheet.createAnimation(row: 0, stepTime: 0.2, to: 5),
      ContainerState.silverChestBoxIdle:
          sheet.createAnimation(row: 1, stepTime: 0.2, to: 5),
      ContainerState.goldenChestBoxIdle:
          sheet.createAnimation(row: 2, stepTime: 0.2, to: 5),
      ContainerState.woodenChestBoxOpen:
          sheet.createAnimation(row: 3, stepTime: 0.2, to: 6),
      ContainerState.silverChestBoxOpen:
          sheet.createAnimation(row: 4, stepTime: 0.2, to: 6),
      ContainerState.goldenChestBoxOpen:
          sheet.createAnimation(row: 5, stepTime: 0.2, to: 6),
      ContainerState.smallBoxDestroy:
          sheet.createAnimation(row: 6, stepTime: 0.2, to: 7),
      ContainerState.mediumBoxDestroy:
          sheet.createAnimation(row: 7, stepTime: 0.2, to: 7),
      ContainerState.largeBoxDestroy:
          sheet.createAnimation(row: 8, stepTime: 0.2, to: 7),
      ContainerState.bucketDestroy:
          sheet.createAnimation(row: 9, stepTime: 0.2, to: 7),
      ContainerState.barrelDestroy:
          sheet.createAnimation(row: 10, stepTime: 0.2, to: 7),
      ContainerState.largeBarrelDestroy:
          sheet.createAnimation(row: 11, stepTime: 0.2, to: 7),
      ContainerState.jugDestroy:
          sheet.createAnimation(row: 12, stepTime: 0.2, to: 7),
      ContainerState.urnDestroy:
          sheet.createAnimation(row: 13, stepTime: 0.2, to: 7),
      ContainerState.vaseDestroy:
          sheet.createAnimation(row: 14, stepTime: 0.2, to: 7),
      ContainerState.tombStoneADestroy:
          sheet.createAnimation(row: 15, stepTime: 0.2, to: 7),
      ContainerState.tombStoneBDestroy:
          sheet.createAnimation(row: 16, stepTime: 0.2, to: 7),
      ContainerState.tombStoneCDestroy:
          sheet.createAnimation(row: 17, stepTime: 0.2, to: 7),
      ContainerState.bookCaseDestroy:
          sheet.createAnimation(row: 18, stepTime: 0.2, to: 7),
      ContainerState.coffinDestroy:
          sheet.createAnimation(row: 19, stepTime: 0.2, to: 7),
    };

    animationTickers?[CharacterState.jump]?.onComplete = () {
      log.info("jumped!");
      current = CharacterState.slash;
    };
    animationTickers?[CharacterState.slash]?.onComplete = () {
      log.info("slashed!");
      current = CharacterState.jump;
    };
    animationTickers?[CharacterState.idle]?.onStart = () {
      log.info("idle!");
    };
  }
}
