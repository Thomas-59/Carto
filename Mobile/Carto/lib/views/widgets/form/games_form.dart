import 'package:carto/utils/establishment_games.dart';
import 'package:carto/views/widgets/constants.dart';
import 'package:flutter/material.dart';

import 'other_fields/game_counter.dart';

class GamesForm extends StatefulWidget {
  final ValueChanged<EstablishmentGames> formChange;
  final EstablishmentGames? games;

  const GamesForm({
    super.key,
    this.games,
    required this.formChange
  });

  @override
  State<GamesForm> createState() => _GamesFormState();
}

class _GamesFormState extends State<GamesForm> {
  late final List<GameCounter> _gameCounters = [];
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
      _gameCounters.add(gameCounter);
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