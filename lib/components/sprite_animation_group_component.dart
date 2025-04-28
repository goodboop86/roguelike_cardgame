import 'package:flame/events.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flame/components.dart';
import 'package:logging/logging.dart';

import '../models/enum.dart';

class SpriteAnimationGroups
    extends SpriteAnimationGroupComponent
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
      CharState.idle: sheet.createAnimation(row: 0, stepTime: 0.3, to: 2),
      CharState.ready: sheet.createAnimation(row: 1, stepTime: 0.3, to: 2),
      CharState.run: sheet.createAnimation(row: 2, stepTime: 0.15, to: 4),
      CharState.crawl: sheet.createAnimation(row: 3, stepTime: 0.15, to: 4),
      CharState.climb: sheet.createAnimation(row: 4, stepTime: 0.3, to: 2),
      CharState.jump:
      sheet.createAnimation(row: 5, stepTime: 0.2, to: 3, loop: false),
      CharState.push:
      sheet.createAnimation(row: 6, stepTime: 0.2, to: 3, loop: false),
      CharState.jab:
      sheet.createAnimation(row: 7, stepTime: 0.2, to: 3, loop: true),
      CharState.slash:
      sheet.createAnimation(row: 8, stepTime: 0.15, to: 4, loop: false),
      CharState.shot:
      sheet.createAnimation(row: 9, stepTime: 0.15, to: 4, loop: false),
      CharState.fire:
      sheet.createAnimation(row: 10, stepTime: 0.3, to: 2, loop: false),
      CharState.block:
      sheet.createAnimation(row: 11, stepTime: 0.3, to: 2, loop: false),
      CharState.death:
      sheet.createAnimation(row: 12, stepTime: 0.2, to: 3, loop: false),
      CharState.roll:
      sheet.createAnimation(row: 13, stepTime: 0.067, to: 9, loop: false)
    };

    animationTickers?[CharState.jump]?.onComplete = () {
      log.info("jumped!");
      current = CharState.slash;
    };
    animationTickers?[CharState.slash]?.onComplete = () {
      log.info("slashed!");
      current = CharState.jump;
    };
    animationTickers?[CharState.idle]?.onStart = () {
      log.info("idle!");
    };
  }
}
