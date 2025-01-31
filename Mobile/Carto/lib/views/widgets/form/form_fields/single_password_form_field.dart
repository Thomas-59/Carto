import 'package:flutter/material.dart';

typedef StringCallback = String? Function(String?);

/// The default form field for password
class SinglePasswordFormField extends StatefulWidget {

  /// The initializer of the class
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

  /// The label of the field
  final String label;
  /// The helper text
  final String? helperText,
  /// The hint text
    hintText;
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
  /// The call back to test the validity of the value
  final StringCallback? validator;

  @override
  State<SinglePasswordFormField> createState() => _MyFormFieldPassword();

}

/// The state of SinglePasswordFormField
class _MyFormFieldPassword extends State<SinglePasswordFormField> {
  /// If the password is visible
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
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

  /// Return a string with the message error if the value is not valid
  String? _validator(String? value) {
    if (widget.canBeEmpty ? false : (value == null || value.isEmpty)) {
      return 'Veuillez entrer ${widget.isFeminine ? "une" : "un"} '
          '${widget.label.toLowerCase()}';
    }

    return widget.validator != null ? widget.validator!(value) : null;
  }
}
