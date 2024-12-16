import 'package:flutter/material.dart';

class MyFormField extends StatelessWidget {
  const MyFormField({
    super.key,
    required this.label,
    required this.controller,
    this.isFeminine = false,
    this.canBeEmpty = false,
    this.minLines = 1,
    this.maxLines = 1,
  });

  final String label;
  final TextEditingController controller;
  final bool isFeminine, canBeEmpty;
  final int minLines, maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding( padding: const EdgeInsets.all(8.0),
      child : TextFormField(
        minLines: minLines,
        maxLines: maxLines,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
        autovalidateMode: AutovalidateMode.always,
        validator: validator,
      )
    );
  }

  String? validator(String? value) {
    if (canBeEmpty ? false : (value == null || value.isEmpty)) {
      return 'Veuillez entrer ${isFeminine ? "une" : "un"} '
        '${label.toLowerCase()}';
    }
    return null;
  }
}
