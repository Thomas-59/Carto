import 'package:carto/enum/game_type_enum.dart';

/// The type and number of instance of a game in a establishment
class EstablishmentGame{
  /// The type of the game
  GameTypeEnum gameType;
  /// The number of instance of the game
  int numberOfGame;

  /// The initializer of the class
  EstablishmentGame(this.gameType, {this.numberOfGame = 0});

  /// Give the name of the game
  String getName() {
    return gameType.value;
  }
}

/// Give the state of each game know by the application for an establishment
class EstablishmentGames{
  /// The list of state of each game
  List<EstablishmentGame> games = [
    EstablishmentGame(GameTypeEnum.arcade),
    EstablishmentGame(GameTypeEnum.babyfoot),
    EstablishmentGame(GameTypeEnum.pool),
    EstablishmentGame(GameTypeEnum.darts),
    EstablishmentGame(GameTypeEnum.pinball),
    EstablishmentGame(GameTypeEnum.karaoke),
    EstablishmentGame(GameTypeEnum.petanque),
    EstablishmentGame(GameTypeEnum.pingpong),
    EstablishmentGame(GameTypeEnum.boardgame),
    EstablishmentGame(GameTypeEnum.cards),
  ];

  /// The initializer of the class
  EstablishmentGames({List<EstablishmentGame> gameToUpdate = const []}) {
    for(EstablishmentGame game in gameToUpdate) {
      switch (game.gameType) {
        case GameTypeEnum.arcade:
          games[0].numberOfGame = game.numberOfGame;
        case GameTypeEnum.babyfoot:
          games[1].numberOfGame = game.numberOfGame;
        case GameTypeEnum.pool:
          games[2].numberOfGame = game.numberOfGame;
        case GameTypeEnum.darts:
          games[3].numberOfGame = game.numberOfGame;
        case GameTypeEnum.pinball:
          games[4].numberOfGame = game.numberOfGame;
        case GameTypeEnum.karaoke:
          games[5].numberOfGame = game.numberOfGame;
        case GameTypeEnum.petanque:
          games[6].numberOfGame = game.numberOfGame;
        case GameTypeEnum.pingpong:
          games[7].numberOfGame = game.numberOfGame;
        case GameTypeEnum.boardgame:
          games[8].numberOfGame = game.numberOfGame;
        case GameTypeEnum.cards:
          games[9].numberOfGame = game.numberOfGame;
      }
    }
  }
}