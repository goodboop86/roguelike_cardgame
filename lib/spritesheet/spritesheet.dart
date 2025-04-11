import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:logging/logging.dart';

import '../components/player_component.dart';
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
      {required String path,
      required CharState onStart,
      required ComponentKey key}) async {
    return await _loadCharacterSpriteComponent(
        path: path,
        onStart: onStart,
        srcSize: Vector2(64.0, 64.0),
        size: Vector2(128, 128),
        key: key);
  }

  Future<SpriteAnimationGroupComponent?> _loadCharacterSpriteComponent(
      {required String path,
      required CharState onStart,
      required Vector2 srcSize,
      required Vector2 size,
      required ComponentKey key}) async {

    if (_characterCache.containsKey(path)) {
      return _characterCache[path];
    }

    try {

      SpriteAnimationGroupComponent component = CharacterAnimationComponent(
        anchor: Anchor.center,
        priority: 1,
        size: size,
        key: key,
        sheet: SpriteSheet(image: await Flame.images.load(path), srcSize: srcSize),
        current: onStart,
      );

      _characterCache[path] = component;

      return component;

    } catch (e) {
      log.warning('Error loading image: $path - $e');
      return null;
    }
  }

  static final SpriteSource _instance = SpriteSource._internal();

  // プライベートなコンストラクタ (外部からのインスタンス化を防ぐ)
  SpriteSource._internal();

  // ファクトリーコンストラクタ (常に同じインスタンスを返す)
  factory SpriteSource() {
    return _instance;
  }
}
