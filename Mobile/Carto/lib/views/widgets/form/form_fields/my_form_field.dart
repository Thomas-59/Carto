import 'package:flutter/material.dart';

class MyFormField extends StatelessWidget {
  const MyFormField({
    super.key,
    required this.label,
    required this.isFeminine,
    required this.controller,
  });

  final String label;
  final bool isFeminine;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
      autovalidateMode: AutovalidateMode.always,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer ${isFeminine ? "une" : "un"} ${label.toLowerCase()}';
        }

        return null;
      },
    );
  }
}
