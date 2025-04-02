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


# TOTO

- デッキのprovider作成。デッキ、使い終わったカード、手札など。またそれを表示できるOverlay
- マナがないとカードが使えない。エラーメッセージを出す(provider + popup)
- 相手のHPがゼロになると、勝利エフェクト発生し、報酬をゲットする。その後ボタンを押すとexploreに戻る。
- event.person押したら人物に移行。ポップアップを表示して押したら消え、アクション選択、押したら反映。その後ボタンを押すとexploreに戻る。
- event.rest押したら休憩に移行。ポップアップを表示して押したら消え、アクション選択、押したら反映。その後ボタンを押すとexploreに戻る。
- キャラクター選択画面

# 画像生成のプロンプト

```
Magic Barrier, A solid painted touch, black background, simple color palette, Bold line design, Rounded shape,  This is an expression that could be used for illustrations in a card game for smartphones. It is a fantastical, iconic, non-scary two-dimensional illustration. The expression is performed with a sense of dynamism, and there are no human or living things, only effect.
```