enum Event {
  start,
  monster,
  midBoss,
  boss,
  personal, // merchant, enhancer
  treasureChest,
  rest, // bonfire, bench
  end
}

enum Monster { goblin, orc, troll, dragon, blackOrc, redDragon }

final Map<int, Map<Event, double>> firstEventProbabilities = {
  0: {Event.start: 1.0},
  1: {
    // ステージ1
    Event.monster: 0.0,
    Event.personal: 0.6,
    Event.rest: 0.0,
    Event.treasureChest: 0.4,
  },
  2: {
    // ステージ2
    Event.monster: 0.5,
    Event.personal: 0.3,
    Event.rest: 0.0,
    Event.treasureChest: 0.1,
  },
  3: {
    // ステージ3
    Event.monster: 0.4,
    Event.personal: 0.2,
    Event.rest: 0.3,
    Event.treasureChest: 0.1,
  },
  4: {
    // ステージ4
    Event.monster: 0.6,
    Event.personal: 0.2,
    Event.rest: 0.1,
    Event.treasureChest: 0.1,
  },
  5: {
    // ステージ5
    Event.midBoss: 1.0
  },
  6: {
    // ステージ6
    Event.monster: 0.6,
    Event.personal: 0.2,
    Event.rest: 0.1,
    Event.treasureChest: 0.1,
  },
  7: {
    // ステージ7
    Event.monster: 0.6,
    Event.personal: 0.2,
    Event.rest: 0.1,
    Event.treasureChest: 0.1,
  },
  8: {
    // ステージ8
    Event.monster: 0.6,
    Event.personal: 0.2,
    Event.rest: 0.1,
    Event.treasureChest: 0.1,
  },
  9: {
    // ステージ9
    Event.monster: 0.6,
    Event.personal: 0.2,
    Event.rest: 0.1,
    Event.treasureChest: 0.1,
  },
  10: {
    // ステージ10
    Event.boss: 1.0
  },
  11: {
    // ステージ11
    Event.end: 1.0
  },
};

final Map<int, Map<Event, double>> otherEventProbabilities = {
  0: {Event.start: 1.0},
  1: {
    // ステージ1
    Event.monster: 0.0,
    Event.personal: 0.6,
    Event.rest: 0.0,
    Event.treasureChest: 0.4,
  },
  2: {
    // ステージ2
    Event.monster: 0.5,
    Event.personal: 0.3,
    Event.rest: 0.0,
    Event.treasureChest: 0.1,
  },
  3: {
    // ステージ3
    Event.monster: 0.4,
    Event.personal: 0.2,
    Event.rest: 0.3,
    Event.treasureChest: 0.1,
  },
  4: {
    // ステージ4
    Event.monster: 0.6,
    Event.personal: 0.2,
    Event.rest: 0.1,
    Event.treasureChest: 0.1,
  },
  5: {
    // ステージ5
    Event.midBoss: 1.0
  },
  6: {
    // ステージ6
    Event.monster: 0.6,
    Event.personal: 0.2,
    Event.rest: 0.1,
    Event.treasureChest: 0.1,
  },
  7: {
    // ステージ7
    Event.monster: 0.6,
    Event.personal: 0.2,
    Event.rest: 0.1,
    Event.treasureChest: 0.1,
  },
  8: {
    // ステージ8
    Event.monster: 0.6,
    Event.personal: 0.2,
    Event.rest: 0.1,
    Event.treasureChest: 0.1,
  },
  9: {
    // ステージ9
    Event.monster: 0.6,
    Event.personal: 0.2,
    Event.rest: 0.1,
    Event.treasureChest: 0.1,
  },
  10: {
    // ステージ10
    Event.boss: 1.0
  },
  11: {
    // ステージ11
    Event.end: 1.0
  },
};
