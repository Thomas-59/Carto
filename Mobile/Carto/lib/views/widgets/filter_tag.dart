import 'dart:collection';
import 'package:flutter/material.dart';

class FilterTag extends StatefulWidget {
  final HashMap<String, bool> filterMap;
  final String tagName;
  final ValueChanged<String> onToggle;

  const FilterTag({
    super.key,
    required this.filterMap,
    required this.tagName,
    required this.onToggle,
  });

  @override
  State<FilterTag> createState() => _FilterTagState();
}

class _FilterTagState extends State<FilterTag> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.filterMap[widget.tagName] ?? false;
    return GestureDetector(
      onTap: () => _toggleSelection(),
      child: isSelected
          ? ElevatedButton(
        onPressed: null,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xFFEB663B)),
        ),
        child: Text(
          widget.tagName,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      )
          : OutlinedButton(
        onPressed: null,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(width: 1.0, color: Color(0xFFEB663B)),
        ),
        child: Text(
          widget.tagName,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFEB663B)),
        ),
      ),
    );
  }

  void _toggleSelection() {
    widget.onToggle(widget.tagName);
  }
}
