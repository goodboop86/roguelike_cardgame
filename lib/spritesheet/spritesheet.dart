import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';
import 'package:logging/logging.dart';

import '../components/player_component.dart';
import '../models/enum.dart';
import '../providers/sizes.dart';

class SpriteSource {
  Logger log = Logger('SpriteSource');
  final Map<String, SpriteAnimationGroupComponent> _characterCache = {};
  final Map<String, ParallaxComponent> _parallaxCache = {};

  Future<void> storeCharacter() async {
    storeCharacterComponent(
        path: 'dragon.png',
        onStart: CharState.idle,
        key: ComponentKey.named("PlayerAnimation"));
  }

  Future<void> storeParallaxComponent(
      {required ParallaxComponent parallaxComponent,
      required String name}) async {
    if (!_parallaxCache.containsKey(name)) {
      try {
        _parallaxCache[name] = parallaxComponent;
      } catch (e) {
        log.warning('Error store parallax: $name - $e');
      }
    }
  }

  SpriteAnimationGroupComponent? getCharacter({required String path}) {
    if (_characterCache.containsKey(path)) {
      return _characterCache[path];
    } else {
      log.warning('Sprite not found: $path');
      return null;
    }
  }

  ParallaxComponent? getParallax({required String name}) {
    if (_parallaxCache.containsKey(name)) {
      return _parallaxCache[name];
    } else {
      log.warning('Parallax not found: $name');
      return null;
    }
  }

  Future<void> storeCharacterComponent(
      {required String path,
      required CharState onStart,
      required ComponentKey key}) async {
    return await _storeCharacterSpriteComponent(
        path: path,
        onStart: onStart,
        srcSize: Vector2(64.0, 64.0),
        size: Vector2(128, 128),
        key: key);
  }

  Future<void> _storeCharacterSpriteComponent(
      {required String path,
      required CharState onStart,
      required Vector2 srcSize,
      required Vector2 size,
      required ComponentKey key}) async {
    if (!_characterCache.containsKey(path)) {
      try {
        SpriteAnimationGroupComponent component = CharacterAnimationComponent(
          anchor: Anchor.center,
          priority: 1,
          size: size,
          key: key,
          sheet: SpriteSheet(
              image: await Flame.images.load(path), srcSize: srcSize),
          current: onStart,
        );

        _characterCache[path] = component;
      } catch (e) {
        log.warning('Error loading image: $path - $e');
      }
    }
  }

  // Future<SpriteAnimationGroupComponent?> loadCharacterComponent(

  //     required CharState onStart,

  // Future<SpriteAnimationGroupComponent?> _loadCharacterSpriteComponent(

  //     {required String path,
  //     required CharState onStart,
  //     required Vector2 srcSize,
  //     required Vector2 size,
  //     required ComponentKey key}) async {
  //   if (_characterCache.containsKey(path)) {
  //     return _characterCache[path];
  //   }
  //
  //   try {
  //     SpriteAnimationGroupComponent component = CharacterAnimationComponent(
  //       anchor: Anchor.center,
  //       priority: 1,
  //       size: size,
  //       key: key,
  //       sheet:
  //           SpriteSheet(image: await Flame.images.load(path), srcSize: srcSize),
  //       current: onStart,
  //     );
  //
  //     _characterCache[path] = component;
  //
  //     return component;
  //   } catch (e) {
  //     log.warning('Error loading image: $path - $e');
  //     return null;
  //   }
  // }
  //     {required String path,
  //     required ComponentKey key}) async {
  //   return await _loadCharacterSpriteComponent(
  //       path: path,
  //       onStart: onStart,
  //       srcSize: Vector2(64.0, 64.0),
  //       size: Vector2(128, 128),
  //       key: key);
  // }

  static final SpriteSource _instance = SpriteSource._internal();

  // プライベートなコンストラクタ (外部からのインスタンス化を防ぐ)
  SpriteSource._internal();

  // ファクトリーコンストラクタ (常に同じインスタンスを返す)
  factory SpriteSource() {
    return _instance;
  }
}
