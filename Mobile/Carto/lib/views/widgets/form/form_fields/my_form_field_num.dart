import 'package:flutter/material.dart';

class MyFormFieldNum extends StatelessWidget {
  const MyFormFieldNum({
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if(value!.isEmpty) return null;
        try {
          int.parse(value);
        } catch (e) {
          return "Veuillez entrer un ${label.toLowerCase()} valide";
        }

        return null;
      },
    );
  }
}
