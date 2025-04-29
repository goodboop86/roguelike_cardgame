import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:roguelike_cardgame/main_game.dart';
import '../components/button_component.dart';
import '../components/card_area_component.dart';
import '../components/text_component.dart';
import '../models/enum.dart';
import '../providers/sizes.dart';

mixin HasExploreArea
    on Component, HasGameRef<MainGame>, RiverpodComponentMixin {
  Logger log = Logger('HasBattleArea');

  void addMap(List<List<Event>> stageList, int currentStage) {
    final mapArea = MapAreaComponent();
    add(mapArea);

    int stageNum = stageList.length;
    var totalMapWidth = Sizes.mapWidth + Sizes.miniMargin;

    stageList.asMap().forEach((depth, stages) {
      final int choiceNum = stages.length;
      final totalMapHeight = Sizes.mapHeight + Sizes.miniMargin;

      Color color = depth == currentStage ? Colors.green : Colors.black12;
      stages.asMap().forEach((choice, stage) {
        final button = ButtonComponent(
          button: RectangleComponent(
              size: Sizes.mapSize, paint: Paint()..color = color, priority: 0),
          onPressed: () {},
          children: [
            Texts.tinyMapText()..text = '$depth $choice',
          ],
        )..position = Vector2(
            depth * totalMapWidth +
                (Sizes.mapAreaWidth - (stageNum * totalMapWidth)) /
                    2, // X 座標を調整
            choice * totalMapHeight +
                (Sizes.mapAreaHeight - (choiceNum * totalMapHeight)) / 2
            // choice * (Sizes.mapWidth / 2 + Sizes.mini_margin)
            , // Y 座標を調整
          );
        // ..anchor = Anchor.center;

        mapArea.add(button);
      });
    });
  }

  void addMapCards(List<List<Event>> stageList, int currentStage) {
    List<Event> events = stageList[currentStage];

    // カードエリアを作成
    double mapCardWidth_ = Sizes.mapCardWidth + Sizes.mapCardMargin;

    final mapCardArea = MapCardAreaComponent();
    add(mapCardArea);

    events.asMap().forEach((index, event) {
      ChoiceButtonComponent button = ChoiceButtonComponent(
        value: event,
      )..position = Vector2(mapCardWidth_ * index, Sizes.blockLength);

      mapCardArea.add(button);

      log.info("add ToggleButtonComponent");
    });
  }
}
