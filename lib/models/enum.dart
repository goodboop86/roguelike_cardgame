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
