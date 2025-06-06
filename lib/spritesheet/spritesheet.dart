import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:logging/logging.dart';

import '../components/sprite_animation_group_component.dart';
import '../models/enum.dart';

class AssetSource {
  Logger log = Logger('SpriteSource');
  final Map<String, SpriteAnimationGroupComponent> _animationCache = {};
  final Map<String, ParallaxComponent> _parallaxCache = {};
  final Map<String, SpriteComponent> _spriteComponentCache = {};
  final Map<String, Sprite> _spriteCache = {};

  Future<void> storeCharacterAnimation(
      {required String path,
      required CharacterState onStart,
      required Vector2 srcSize,
      required Vector2 size,
      required ComponentKey key,
      bool flip = false}) async {
    if (!_animationCache.containsKey(path)) {
      SpriteAnimationGroupComponent component = SpriteAnimationGroups.character(
        key: key,
        sheet:
        SpriteSheet(image: await Flame.images.load(path), srcSize: srcSize),
        size: size,
        anchor: Anchor.center,
        priority: 20,
        current: onStart,
      );
      if (flip) {
        component.flipHorizontally();
      }
      _animationCache[path] = component;
      log.fine("store sprite: ${path}");
    }
  }

  Future<void> storeContainerAnimation(
      {required String path,
        required ContainerState onStart,
        required Vector2 srcSize,
        required Vector2 size,
        required ComponentKey key,
        bool flip = false}) async {
    if (!_animationCache.containsKey(path)) {
      SpriteAnimationGroupComponent component = SpriteAnimationGroups.containers(
        key: key,
        sheet:
        SpriteSheet(image: await Flame.images.load(path), srcSize: srcSize),
        size: size,
        anchor: Anchor.center,
        priority: 20,
        current: onStart,
      );
      if (flip) {
        component.flipHorizontally();
      }
      _animationCache[path] = component;
      log.fine("store sprite: ${path}");
    }
  }

  Future<void> storeSprite({
    required String path,
  }) async {
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

  SpriteComponent? getSpriteComponent(
      {required String name, required Vector2 size, ComponentKey? key}) {

    key ??= ComponentKey.unique();

    if (_spriteCache.containsKey(name)) {
      return SpriteComponent(
        size: size,
        sprite: _spriteCache[name],
        priority: 10,
        anchor: Anchor.center,
        key: key
      );
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
