import 'package:flutter/material.dart';

class MyCheckboxListTile extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String title;

  const MyCheckboxListTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
  });

  @override
  _MyCheckboxListTileState createState() => _MyCheckboxListTileState();
}

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
      title: Text(widget.title),
      focusColor: Colors.white,

        /*WidgetStateProperty.resolveWith((states) {
          if (!states.contains(WidgetState.selected)) {
            return Colors.red;
          }
          return null;
        }),*/
    );
  }
}
