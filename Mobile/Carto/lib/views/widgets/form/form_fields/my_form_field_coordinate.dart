import 'package:flutter/material.dart';

class MyFormFieldCoordinate extends StatelessWidget {
  const MyFormFieldCoordinate({
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
    return Padding( padding: const EdgeInsets.all(8.0),
      child : TextFormField(
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
          if(value == null || value.isEmpty) {
            return "Veuillez entrer ${isFeminine ? "une" : "un"} "
                "${label.toLowerCase()}";
          }
          try {
            double.parse(value);
          } catch (e) {
            return "Veuillez entrer ${isFeminine ? "une" : "un"} "
                "${label.toLowerCase()} valide";
          }

          return null;
        },
      )
    );
  }
}
