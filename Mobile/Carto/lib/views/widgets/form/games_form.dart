import 'package:flutter/material.dart';

import 'other_fields/game_counter.dart';

class GamesForm extends StatefulWidget {
  final ValueChanged<List<int>> formChange;
  final List<String> gameTitles;
  final List<int> initialGameNumbers;

  const GamesForm({
    super.key,
    this.gameTitles = const [
      "Billard",
      "Flipper",
      "Fléchettes",
      "Ping-Pong",
      "Sociétés",
      "Babyfoot",
      "Karaoké",
      "Arcade",
      "Cartes",
      "Pétanque",
    ],
    this.initialGameNumbers = const <int> [],
    required this.formChange
  });

  @override
  State<GamesForm> createState() => _GamesFormState();
}

class _GamesFormState extends State<GamesForm> {
  late final List<int> _gameNumbers = [];
  late final List<GameCounter> _gameCounters = [];

  @override
  void initState() {
    _gameNumbers.addAll(widget.initialGameNumbers);
    if(_gameNumbers.length < widget.gameTitles.length) {
      for(
        int idx = _gameNumbers.length;
        idx < widget.gameTitles.length;
        idx++
      ) {
        _gameNumbers.add(0);
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
            "Types de jeux",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.5),
        ),
        const Divider(
            color: Colors.black
        ),
        _setGameCounters(widget.gameTitles, _gameNumbers)
      ],
    );
  }

  Widget _setGameCounters(List <String> titles, List <int> initialValue) {
    List <Widget> leftColumn = [];
    List <Widget> rightColumn = [];
    bool isLeftRow = true;
    for(int idx = 0; idx < titles.length; idx++) {
      String title = titles[idx].length > 9 ?
        "${titles[idx].substring(0, 7)}..." : titles[idx];
      GameCounter gameCounter = GameCounter(
        title: title,
        min: 0,
        max: 10,
        initial:
        initialValue[idx],
        onChange: _onChange,
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

  void _onChange(int value) {
    int idx = 0;
    for(GameCounter gameCounter in _gameCounters) {
      _gameNumbers[idx++] = gameCounter.value;
    }
    widget.formChange(_gameNumbers);
  }
}