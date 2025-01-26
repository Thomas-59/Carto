import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StringFormField extends StatefulWidget {
  const StringFormField({
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
  State<StringFormField> createState() => _StringFormFieldState();
}

class _StringFormFieldState extends State<StringFormField> {
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

  String? _validator(String? value) {
    if (widget.canBeEmpty ? false : (value == null || value.isEmpty)) {
      return 'Veuillez entrer ${widget.isFeminine ? "une" : "un"} '
          '${widget.label.toLowerCase()}';
    }
    return _fieldError;
  }
}

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

  final String label;
  final TextEditingController controller;
  final bool isFeminine, canBeEmpty;
  final int minLines, maxLines;
  final int? minLength, maxLength;

  @override
  State<IntegerFormField> createState() => _IntegerFormFieldState();
}

class _IntegerFormFieldState extends State<IntegerFormField> {
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