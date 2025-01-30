import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// The default String form field for manager information
class StringFormField extends StatefulWidget {
  /// The initializer of the class
  const StringFormField({
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
  State<StringFormField> createState() => _StringFormFieldState();
}

/// The state of StringFormField
class _StringFormFieldState extends State<StringFormField> {
  /// The error message to show
  String? _fieldError;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.label,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          errorText: _fieldError,
          fillColor: Colors.white,
          filled: true,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
    return _fieldError;
  }
}

/// The default integer form field for manager information
class IntegerFormField extends StatefulWidget {
  const IntegerFormField({
    super.key,
    required this.label,
    required this.controller,
    this.isFeminine = false,
    this.canBeEmpty = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.minLength,
    this.maxLength,
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
  /// The minimal length of the value
  final int? minLength,
  /// The maximal length of the value
    maxLength;

  @override
  State<IntegerFormField> createState() => _IntegerFormFieldState();
}

/// The state of IntegerFormField
class _IntegerFormFieldState extends State<IntegerFormField> {
  /// The error message to show
  String? _fieldError;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        controller: widget.controller,keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
          labelText: widget.label,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          errorText: _fieldError,
          fillColor: Colors.white,
          filled: true,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
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

    if (value != null) {
      if (widget.minLength != null && value.length < widget.minLength!) {
        return 'Le ${widget.label.toLowerCase()} doit contenir au moins\n${widget.minLength} caractères.';
      }
      if (widget.maxLength != null && value.length > widget.maxLength!) {
        return 'Le ${widget.label.toLowerCase()} ne peut pas dépasser\n${widget.maxLength} caractères.';
      }
    }

    return _fieldError;
  }
}