import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';
import 'package:logging/logging.dart';

import '../components/player_component.dart';
import '../models/enum.dart';
import '../providers/sizes.dart';

class AssetSource {
  Logger log = Logger('SpriteSource');
  final Map<String, SpriteAnimationGroupComponent> _animationCache = {};
  final Map<String, ParallaxComponent> _parallaxCache = {};
  final Map<String, SpriteComponent> _spriteComponentCache = {};
  final Map<String, Sprite> _spriteCache = {};

  Future<void> storeAnimation(
      {required String path,
      required CharState onStart,
      required Vector2 srcSize,
      required Vector2 size,
      required ComponentKey key,
      bool flip = false}) async {
    if (!_animationCache.containsKey(path)) {
      SpriteAnimationGroupComponent component = CharacterAnimationComponent(
        anchor: Anchor.center,
        priority: 20,
        size: size,
        key: key,
        sheet:
            SpriteSheet(image: await Flame.images.load(path), srcSize: srcSize),
        current: onStart,
      );
      if (flip) {
        component.flipHorizontally();
      }
      _animationCache[path] = component;
      log.fine("store sprite: ${path}");
    }
  }

  Future<void> storeSpriteComponent(
      {required Vector2 size,
      required String path,
      required ComponentKey key}) async {
    if (!_spriteComponentCache.containsKey(path)) {
      SpriteComponent sprite = SpriteComponent(
        size: size,
        sprite: await Sprite.load(path),
        key: key,
        priority: 10,
        anchor: Anchor.center,
      );
      _spriteComponentCache[path] = sprite;
      log.fine("store sprite: $path");
    }
  }

  Future<void> storeSprite(
      {required Vector2 size,
      required String path,
      required ComponentKey key}) async {
    if (!_spriteCache.containsKey(path)) {
      Sprite sprite = await Sprite.load(path);
      _spriteCache[path] = sprite;
      log.fine("store sprite: $path");
    }
  }

  Future<void> storeParallax(
      {required ParallaxComponent parallaxComponent,
      required String name}) async {
    if (!_parallaxCache.containsKey(name)) {
      _parallaxCache[name] = parallaxComponent;
      log.fine("store parallax: $name");
    }
  }

  SpriteAnimationGroupComponent? getAnimation({required String name}) {
    if (_animationCache.containsKey(name)) {
      return _animationCache[name];
    } else {
      log.warning('not found: $name');
      return null;
    }
  }

  SpriteComponent? getSpriteComponent({required String name}) {
    if (_spriteComponentCache.containsKey(name)) {
      return _spriteComponentCache[name];
    } else {
      log.warning('not found: $name');
      return null;
    }
  }

  Sprite? getSprite({required String name}) {
    if (_spriteCache.containsKey(name)) {
      return _spriteCache[name];
    } else {
      log.warning('not found: $name');
      return null;
    }
  }


  ParallaxComponent? getParallax({required String name}) {
    if (_parallaxCache.containsKey(name)) {
      return _parallaxCache[name];
    } else {
      log.warning('not found: $name');
      return null;
    }
  }

  static final AssetSource _instance = AssetSource._internal();

  // プライベートなコンストラクタ (外部からのインスタンス化を防ぐ)
  AssetSource._internal();

  // ファクトリーコンストラクタ (常に同じインスタンスを返す)
  factory AssetSource() {
    return _instance;
  }
}
