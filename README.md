# roguelike_cardgame

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# directory

```
lib/
  components/           # Flame コンポーネント
    card/               # カード関連コンポーネント
      card_component.dart
    player/             # プレイヤー関連コンポーネント
      player_component.dart
    enemy/              # 敵関連コンポーネント
      enemy_component.dart
    ui/                 # UI 関連コンポーネント
      card_slot.dart
      health_bar.dart
  models/               # データモデル
    card/               # カードデータモデル
      card.dart
      card_effect.dart
    player/             # プレイヤーデータモデル
      player_state.dart
    enemy/              # 敵データモデル
      enemy_state.dart
  providers/            # Riverpod プロバイダ
    card_provider.dart
    player_provider.dart
    enemy_provider.dart
    game_state_provider.dart
  screens/              # 画面
    game_screen.dart
    main_menu_screen.dart
  utils/                # ユーティリティ
    constants.dart
    extensions.dart
  main.dart             # エントリポイント
assets/
  images/               # 画像アセット
    cards/              # カード画像
    characters/         # キャラクター画像
  audio/                # 音声アセット
```