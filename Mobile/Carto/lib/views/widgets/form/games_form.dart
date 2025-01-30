import 'package:carto/utils/establishment_games.dart';
import 'package:carto/views/widgets/constants.dart';
import 'package:flutter/material.dart';

import 'other_fields/game_counter.dart';

/// The frame concerning the games of the establishment in the form
class GamesForm extends StatefulWidget {
  /// The action to take when value change
  final ValueChanged<EstablishmentGames> formChange;
  /// The games to initialize the form
  final EstablishmentGames? games;

  /// The initializer of the class
  const GamesForm({
    super.key,
    this.games,
    required this.formChange
  });

  @override
  State<GamesForm> createState() => _GamesFormState();
}

/// The state of GamesForm
class _GamesFormState extends State<GamesForm> {
  /// The current games in the form
  late final EstablishmentGames _games;

  @override
  void initState() {
    _games = widget.games ?? EstablishmentGames();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
            "TYPES DE JEUX",
          style: blackTextBold20,
        ),
        const Divider(
            color: Colors.black
        ),
        _setGameCounters()
      ],
    );
  }

  /// Give the games counters split in two column
  Widget _setGameCounters() {
    List <Widget> leftColumn = [];
    List <Widget> rightColumn = [];
    bool isLeftRow = true;
    for(EstablishmentGame game in _games.games) {
      String title = game.getName().length > 9 ?
        "${game.getName().substring(0, 7)}..." : game.getName();
      GameCounter gameCounter = GameCounter(
        title: title,
        initial:
        game.numberOfGame,
        onChange: (int value) {
          game.numberOfGame = value;
          widget.formChange(_games);
        },
      );
      if(isLeftRow) {
        leftColumn.add(gameCounter);
      } else {
        rightColumn.add(gameCounter);
      }
      isLeftRow = !isLeftRow;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: leftColumn,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: rightColumn,
        )
      ],
    );
  }
}