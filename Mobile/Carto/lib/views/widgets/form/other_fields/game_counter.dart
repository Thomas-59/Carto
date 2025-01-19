import 'package:counter/counter.dart';
import 'package:flutter/cupertino.dart';

class GameCounter extends StatefulWidget {
  final ValueChanged<int> onChange;
  final String title;
  final int min;
  final int max;
  final int initial;

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

  _onValueChanged(num value) {
    widget.onChange(value as int);
  }
}