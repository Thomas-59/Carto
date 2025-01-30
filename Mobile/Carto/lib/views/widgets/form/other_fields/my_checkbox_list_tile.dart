import 'package:flutter/material.dart';

/// A checkbox with a color background on the case
class MyCheckboxListTile extends StatefulWidget {
  /// The initial value of the checkbox
  final bool value;
  /// The action to take on value change
  final ValueChanged<bool?> onChanged;
  /// The label of the checkbox
  final String title;
  /// The color of the label
  final Color textColor;

  /// The initializer of the class
  const MyCheckboxListTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    required this.textColor
  });

  @override
  _MyCheckboxListTileState createState() => _MyCheckboxListTileState();
}

/// The state of MyCheckboxListTile
class _MyCheckboxListTileState extends State<MyCheckboxListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      leading: Checkbox(
        value: widget.value,
        onChanged: widget.onChanged,
        checkColor: Colors.black,
        activeColor: Colors.grey,
        fillColor: WidgetStateColor.resolveWith(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.grey;
            }
            return Colors.white;
          },
        ),
      ),
      title: Text(widget.title, style: TextStyle(color: widget.textColor),),
      focusColor: Colors.white,
    );
  }
}
