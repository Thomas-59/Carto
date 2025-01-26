import 'dart:collection';
import 'package:flutter/material.dart';

/// The tag used in filter
class FilterTag extends StatefulWidget {
  /// The map of tag with their state
  final HashMap<String, bool> filterMap;
  /// The label to apply on the tag
  final String tagName;
  /// The action to take when user touch the tag
  final ValueChanged<String> onToggle;

  /// The initializer of the class
  const FilterTag({
    super.key,
    required this.filterMap,
    required this.tagName,
    required this.onToggle,
  });

  @override
  State<FilterTag> createState() => _FilterTagState();
}

/// The state of FilterTag
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

  /// The action to take when user touch the tag
  void _toggleSelection() {
    widget.onToggle(widget.tagName);
  }
}
