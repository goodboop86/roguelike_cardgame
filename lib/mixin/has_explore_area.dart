import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:roguelike_cardgame/main_game.dart';
import '../components/button_component.dart';
import '../components/card_area_component.dart';
import '../models/enum.dart';
import '../providers/sizes.dart';

mixin HasExploreArea
    on Component, HasGameRef<MainGame>, RiverpodComponentMixin {
  Logger log = Logger('HasBattleArea');

  void addMap(List<List<Event>> stageList, int currentStage) {
    final mapArea = MapAreaComponent(
      position: Sizes().mapAreaPosition,
      size: Sizes().mapAreaSize, // カードエリアのサイズ
    );
    add(mapArea);

    int stageNum = stageList.length;
    var totalMapWidth = Sizes().mapWidth + Sizes().miniMargin;

    stageList.asMap().forEach((depth, stages) {
      final int choiceNum = stages.length;
      final totalMapHeight = Sizes().mapHeight + Sizes().miniMargin;

      Color color = depth == currentStage ? Colors.green : Colors.black12;
      stages.asMap().forEach((choice, stage) {
        final button = ButtonComponent(
          button: RectangleComponent(
              size: Sizes().mapSize,
              paint: Paint()..color = color,
              priority: 0),
          onPressed: () {},
          children: [
            TextComponent(
              priority: 1,
              text: '$depth $choice',
              position: Sizes().mapSize,
              anchor: Anchor.center,
              textRenderer:
                  TextPaint(style: const TextStyle(color: Colors.white)),
            ),
          ],
        )..position = Vector2(
            depth * totalMapWidth +
                (Sizes().mapAreaWidth - (stageNum * totalMapWidth)) /
                    2, // X 座標を調整
            choice * totalMapHeight +
                (Sizes().mapAreaHeight - (choiceNum * totalMapHeight)) / 2
            // choice * (Sizes().mapWidth / 2 + Sizes().mini_margin)
            , // Y 座標を調整
          );
        // ..anchor = Anchor.center;

        mapArea.add(button);
      });
    });
  }

  void addMapCards(List<List<Event>> stageList, int currentStage,
      RouterComponent router, ComponentRef ref) {
    List<Event> events = stageList[currentStage];

    // カードエリアを作成
    double mapCardWidth_ = Sizes().mapCardWidth + Sizes().mapCardMargin;
    double mapCardAreaWidth =
        events.length * mapCardWidth_ - Sizes().mapCardMargin;

    Vector2 mapCardAreaSize =
        Vector2(mapCardAreaWidth, Sizes().mapCardAreaHeight);

    double mapCardAreaX =
        Sizes().gameOriginX + (Sizes().gameWidth - mapCardAreaWidth) / 2;
    Vector2 mapCardAreaPosition = Vector2(mapCardAreaX, Sizes().mapCardAreaY);

    final mapCardArea = MapCardAreaComponent(
      position: mapCardAreaPosition,
      size: mapCardAreaSize,
      anchor: Anchor.topLeft,
    );
    add(mapCardArea);

    // Debug
    AdvancedButtonComponent executeButton = AdvancedButtonComponent(
        defaultLabel: TextComponent(
          priority: 1,
          text: "default",
          anchor: Anchor.center,
          position: Sizes().mapCardSize / 2,
          textRenderer: TextPaint(style: const TextStyle(color: Colors.white)),
        ),
        disabledLabel: TextComponent(
          priority: 1,
          text: "disable",
          anchor: Anchor.center,
          position: Sizes().mapCardSize / 2,
          textRenderer: TextPaint(style: const TextStyle(color: Colors.white)),
        ),
        defaultSkin: RectangleComponent(
          size: Sizes().wideButtonSize,
          paint: Paint()..color = Colors.red,
          position: Vector2(0, 0),
        ),
        disabledSkin: RectangleComponent(
          size: Sizes().wideButtonSize,
          paint: Paint()..color = Colors.grey,
          position: Vector2(0, 0),
        ),
        onPressed: () {
          mapCardArea.pupUp();
        })
      ..position = Vector2((mapCardAreaWidth - Sizes().wideButtonWidth) / 2,
          6 * Sizes().blockLength)
      ..isDisabled = true;

    mapCardArea.add(executeButton);

    events.asMap().forEach((index, event) {
      // debug
      RectangleComponent noSelected = RectangleComponent(
        size: Sizes().mapCardSize,
        paint: Paint()..color = Colors.blue, // 青色で塗りつぶし
        position: Vector2(0, 0), // 描画位置 (左上隅の座標)
      );

      RectangleComponent selected = RectangleComponent(
        size: Sizes().mapCardSize,
        paint: Paint()..color = Colors.red, // 青色で塗りつぶし
        position: Vector2(0, 0), // 描画位置 (左上隅の座標)
      );

      final key = ComponentKey.unique();

      ChoiceButtonComponent button = ChoiceButtonComponent<Event>(
          priority: 30,
          position: Vector2(0, 0),
          defaultSkin: noSelected,
          defaultSelectedSkin: selected,
          key: key,
          value: event)
        ..position = Vector2(mapCardWidth_ * index, Sizes().blockLength);

      mapCardArea.add(button
        ..onSelectedChanged = (bool val) {
          if (val) {
            mapCardArea.disableAllStageExclusive(key: key);
          }
          mapCardArea.updateExecuteButton(isSelected: val);
        });

      log.info("add ToggleButtonComponent");
    });

    // toggleButton.isSelected = true;
  }

  Future<T> pushAndWait<T>(ValueRoute<T> route) async {
    return await game.router.pushAndWait(route) as T;
  }
}
