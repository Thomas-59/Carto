import 'package:flutter/material.dart';

typedef StringCallback = String? Function(String?);

class SinglePasswordFormField extends StatefulWidget {

  const SinglePasswordFormField({
    super.key,
    required this.label,
    required this.controller,
    this.isFeminine = false,
    this.canBeEmpty = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.helperText,
    this.hintText,
    this.validator,
  });

  final String label;
  final String? helperText, hintText;
  final TextEditingController controller;
  final bool isFeminine, canBeEmpty;
  final int minLines, maxLines;
  final StringCallback? validator;

  @override
  State<SinglePasswordFormField> createState() => _MyFormFieldPassword();

}

class _MyFormFieldPassword extends State<SinglePasswordFormField> {
  bool passwordVisible = false;
  bool confirmationVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    confirmationVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: passwordVisible,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: "Mot de passe",
          helperText: widget.helperText,
          suffixIcon: IconButton(
              icon: Icon(
                passwordVisible ? Icons.visibility : Icons.visibility_off
              ),
              onPressed: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              }),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
        autovalidateMode: AutovalidateMode.always,
        validator: _validator,
      ),
    );
  }

  String? _validator(String? value) {
    if (widget.canBeEmpty ? false : (value == null || value.isEmpty)) {
      return 'Veuillez entrer ${widget.isFeminine ? "une" : "un"} '
          '${widget.label.toLowerCase()}';
    }

    return widget.validator != null ? widget.validator!(value) : null;
  }
}
