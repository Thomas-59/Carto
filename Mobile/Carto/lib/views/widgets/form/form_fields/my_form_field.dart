import 'package:flutter/material.dart';

/// The default form field
class MyFormField extends StatelessWidget {
  /// The initializer of the class
  const MyFormField({
    super.key,
    required this.label,
    required this.controller,
    this.isFeminine = false,
    this.canBeEmpty = false,
    this.minLines = 1,
    this.maxLines = 1,
  });

  /// The label of the field
  final String label;
  /// The controller of the form field
  final TextEditingController controller;
  /// If the label if feminine (French particularity)
  final bool isFeminine,
  /// If the field can be empty
    canBeEmpty;
  /// The minimal line to show in the field
  final int minLines,
  /// The maximal line to show in the field
    maxLines;

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

  /// Give the value of the field
  String getValue() {
    return controller.text;
  }

  /// Return a string with the message error if the value is not valid
  String? validator(String? value) {
    if (canBeEmpty ? false : (value == null || value.isEmpty)) {
      return 'Veuillez entrer ${isFeminine ? "une" : "un"} '
        '${label.toLowerCase()}';
    }
    return null;
  }
}
