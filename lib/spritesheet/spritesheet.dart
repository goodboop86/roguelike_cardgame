import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:logging/logging.dart';

import '../models/enum.dart';

class SpriteSource {
  Logger log = Logger('SpriteSource');
  final Map<String, SpriteAnimationGroupComponent> _characterCache = {};

  late SpriteSheet playerSpriteSheet;
  late SpriteSheet enemySpriteSheet;

  Future<void> load() async {
    playerSpriteSheet = SpriteSheet(
        image: await Flame.images.load('dragon.png'),
        srcSize: Vector2(64.0, 64.0),
        spacing: 0.0);
    enemySpriteSheet = SpriteSheet(
      image: await Flame.images.load('swordsman.png'),
      srcSize: Vector2(24.0, 24.0),
    );
  }

  Future<SpriteAnimationGroupComponent?> loadCharacterComponent(
      {required String path, required CharState onStart}) async {
    return await _loadCharacterSpriteComponent(
        path: path,
        onStart: onStart,
        srcSize: Vector2(64.0, 64.0),
        size: Vector2(128, 128));
  }

  Future<SpriteAnimationGroupComponent?> _loadCharacterSpriteComponent(
      {required String path,
      required CharState onStart,
      required Vector2 srcSize,
      required Vector2 size}) async {

    if (_characterCache.containsKey(path)) {
      return _characterCache[path];
    }
    try {
      SpriteSheet sheet =
          SpriteSheet(image: await Flame.images.load(path), srcSize: srcSize);

      SpriteAnimationGroupComponent component =
          _getCharacterAnimation(sheet: sheet, onStart: onStart, size: size);
      _characterCache[path] = component;

      return component;

    } catch (e) {
      log.warning('Error loading image: $path - $e');
      return null;
    }
  }

  SpriteAnimationGroupComponent _getCharacterAnimation(
      {required SpriteSheet sheet,
      required CharState onStart,
      required Vector2 size}) {
    SpriteAnimationGroupComponent component =
        SpriteAnimationGroupComponent<CharState>(
      anchor: Anchor.center,
      priority: 1,
      size: size,
      animations: {
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
            sheet.createAnimation(row: 13, stepTime: 0.067, to: 9, loop: false),
      },
      current: onStart,
    );

    component.animationTickers?[CharState.jump]?.onComplete = () {
      log.info("jumped!");
      component.current = CharState.slash;
    };
    component.animationTickers?[CharState.slash]?.onComplete = () {
      log.info("slashed!");
      component.current = CharState.jump;
    };
    component.animationTickers?[CharState.idle]?.onStart = () {
      log.info("idle!");
    };

    return component;
  }

  static final SpriteSource _instance = SpriteSource._internal();

  // プライベートなコンストラクタ (外部からのインスタンス化を防ぐ)
  SpriteSource._internal();

  // ファクトリーコンストラクタ (常に同じインスタンスを返す)
  factory SpriteSource() {
    return _instance;
  }
}
