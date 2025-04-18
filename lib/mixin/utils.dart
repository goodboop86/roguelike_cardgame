import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../components/basic_component.dart';
import '../main_game.dart';
import '../models/enum.dart';
import '../singleton/sizes.dart';

mixin HasUtils on Component, HasGameRef<MainGame>, RiverpodComponentMixin {
  Logger log = Logger('HasBattleArea');



}