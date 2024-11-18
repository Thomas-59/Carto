import 'package:counter/counter.dart';
import 'package:flutter/cupertino.dart';

class GameCounter extends StatelessWidget {
  final ValueChanged<int> onChange;
  final String title;
  final int min;
  final int max;
  final int initial;
  late int value;


  GameCounter({
    super.key,
    required this.title,
    required this.min,
    required this.max,
    this.initial = 0,
    this.onChange = _noOp
  }) {
    value = initial;
  }

  static void _noOp(int value) {
    // Does nothing
  }

  @override
  Widget build(BuildContext context) {
    return Padding( padding: const EdgeInsets.all(8.0),
      child :
      Row(
        children: [
          Text(title),
          Counter(min: 0, max: 10, initial: initial, onValueChanged: _onValueChanged,),
        ],
      ),
    );
  }

  _onValueChanged(num value) {
    this.value = value as int;
    onChange(value);
  }

}