
import '../models/enum.dart';

enum Monster { goblin, orc, troll, dragon, blackOrc, redDragon }

final Map<int, Map<Event, double>> firstEventProbabilities = {
  0: {Event.start: 1.0},
  1: {
    Event.battle: 1.0,
    Event.person: 0.0,
    Event.rest: 0.0,
    Event.treasureChest: 0.0,
  },
  2: {
    Event.battle: 1.0,
    Event.person: 0.0,
    Event.rest: 0.0,
    Event.treasureChest: 0.0,
  },
  3: {
    Event.battle: 0.0,
    Event.person: 1.0,
    Event.rest: 0.0,
    Event.treasureChest: 0.0,
  },
  4: {
    Event.battle: 0.0,
    Event.person: 0.0,
    Event.rest: 1.0,
    Event.treasureChest: 0.0,
  },
  5: {
    Event.midBoss: 1.0
  },
  6: {
    Event.battle: 1.0,
    Event.person: 0.0,
    Event.rest: 0.0,
    Event.treasureChest: 0.0,
  },
  7: {
    Event.battle: 1.0,
    Event.person: 0.0,
    Event.rest: 0.0,
    Event.treasureChest: 0.0,
  },
  8: {
    Event.battle: 0.0,
    Event.person: 1.0,
    Event.rest: 0.0,
    Event.treasureChest: 0.0,
  },
  9: {
    Event.battle: 0.0,
    Event.person: 0.0,
    Event.rest: 1.0,
    Event.treasureChest: 0.0,
  },
  10: {
    Event.boss: 1.0
  },
  11: {
    Event.end: 1.0
  },
};

final Map<int, Map<Event, double>> otherEventProbabilities = {
  0: {Event.start: 1.0},
  1: {
    Event.battle: 0.5,
    Event.person: 0.25,
    Event.rest: 0.0,
    Event.treasureChest: 0.25,
  },
  2: {
    Event.battle: 0.5,
    Event.person: 0.25,
    Event.rest: 0.0,
    Event.treasureChest: 0.25,
  },
  3: {
    Event.battle: 0.5,
    Event.person: 0.25,
    Event.rest: 0.0,
    Event.treasureChest: 0.25,
  },
  4: {
    Event.battle: 0.5,
    Event.person: 0.25,
    Event.rest: 0.0,
    Event.treasureChest: 0.25,
  },
  5: {
    Event.midBoss: 1.0
  },
  6: {
    Event.battle: 0.5,
    Event.person: 0.25,
    Event.rest: 0.0,
    Event.treasureChest: 0.25,
  },
  7: {
    Event.battle: 0.5,
    Event.person: 0.25,
    Event.rest: 0.0,
    Event.treasureChest: 0.25,
  },
  8: {
    Event.battle: 0.5,
    Event.person: 0.25,
    Event.rest: 0.0,
    Event.treasureChest: 0.25,
  },
  9: {
    Event.battle: 0.5,
    Event.person: 0.25,
    Event.rest: 0.0,
    Event.treasureChest: 0.25,
  },
  10: {
    Event.boss: 1.0
  },
  11: {
    Event.end: 1.0
  },
};
