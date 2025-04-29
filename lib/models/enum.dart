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
  deckOverlay,
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
  waitPhase,
  empty,
  startPhase,
  playerPhase,
  playerEndPhase,
  enemyPhase,
  endPhase,
  lose,
  win
}

enum CharacterState {
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

enum ContainerState {
  woodenChestBoxIdle,
  silverChestBoxIdle,
  goldenChestBoxIdle,
  woodenChestBoxOpen,
  silverChestBoxOpen,
  goldenChestBoxOpen,
  smallBoxDestroy,
  mediumBoxDestroy,
  largeBoxDestroy,
  bucketDestroy,
  barrelDestroy,
  largeBarrelDestroy,
  jugDestroy,
  urnDestroy,
  vaseDestroy,
  tombStoneADestroy,
  tombStoneBDestroy,
  tombStoneCDestroy,
  bookCaseDestroy,
  coffinDestroy


}
