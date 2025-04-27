enum ROUTE {
  home,
  explore,
  battle,
  person,
  treasureChest,
  rest, // bonfire, bench
}

enum OVERLAY {
  cardOverlay,
  characterOverlay,
  enemyTurnOverlay,
  autoDisappearingOverlay,
}

enum Event {
  empty,
  start,
  battle,
  midBoss,
  boss,
  person, // merchant, enhancer
  treasureChest,
  rest, // bonfire, bench
  end
}

enum BattlePhase {
  start,
  playerPhase,
  enemyPhase,
}

enum CharState {
  idle,
  ready,
  run,
  crawl,
  climb,
  jump,
  push,
  jab,
  slash,
  shot,
  fire,
  block,
  death,
  roll
}
