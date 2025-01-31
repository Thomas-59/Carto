import 'package:counter/counter.dart';
import 'package:flutter/cupertino.dart';

/// The counter of a game
class GameCounter extends StatefulWidget {
  /// The action to take on value change
  final ValueChanged<int> onChange;
  /// The label of the game
  final String title;
  /// The minimal value
  final int min;
  /// The maximal value
  final int max;
  /// The initial value
  final int initial;

  /// The initializer of the class
  const GameCounter({
    super.key,
    required this.title,
    required this.onChange,
    this.min = 0,
    this.max = 99,
    this.initial = 0,
  });

  @override
  State<GameCounter> createState() => _GameCounterState();
}

/// The state of GameCounter
class _GameCounterState extends State<GameCounter> {
  @override
  Widget build(BuildContext context) {
    return Padding( padding: const EdgeInsets.all(8.0),
      child :
      Row(
        children: [
          Text(widget.title),
          Counter(
            min: widget.min,
            max: widget.max,
            initial: widget.initial,
            onValueChanged: _onValueChanged,
          ),
        ],
      ),
    );
  }

  /// The action to take on value change
  _onValueChanged(num value) {
    widget.onChange(value as int);
  }
}