import 'package:carto/views/widgets/form/form_fields/single_password_form_field.dart';
import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {

  const PasswordFormField({
    super.key,
    required this.label,
    required this.controller,
    this.isFeminine = false,
    this.canBeEmpty = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.confirmationController
  });

  final String label;
  final TextEditingController controller;
  final TextEditingController? confirmationController;
  final bool isFeminine, canBeEmpty;
  final int minLines, maxLines;

  @override
  State<PasswordFormField> createState() => _MyFormFieldPassword();

}

class _MyFormFieldPassword extends State<PasswordFormField> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SinglePasswordFormField(
          label: widget.label,
          controller: widget.controller,
          hintText: "Mot de passe",
          helperText: "Le mot de passe doit contenir au moins 1 majuscule"
            ", \n1 chiffre et  la longueur doit être d'au moins 8 "
            "caractères.",
          validator: validator,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          isFeminine: widget.isFeminine,
          canBeEmpty: widget.canBeEmpty,
        ),
        if (widget.confirmationController != null)
          SinglePasswordFormField(
            label: 'Confirmation du ${widget.label}',
            controller: widget.confirmationController!,
            hintText: "Confirmer le mot de passe",
            validator: confirmationValidator,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            isFeminine: widget.isFeminine,
            canBeEmpty: widget.canBeEmpty,
          ),
      ],
    );
  }

  String? validator(String? value) {
    if (widget.canBeEmpty ? false : (value == null || value.isEmpty)) {
      return 'Veuillez entrer ${widget.isFeminine ? "une" : "un"} '
          '${widget.label.toLowerCase()}';
    }

    if (value != null && value.isNotEmpty) {
      final RegExp passwordRegex =
        RegExp(r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,}$');
      if (!passwordRegex.hasMatch(value)) {
        return "Le mot de passe doit contenir au moins 1 majuscule, \n1 "
            "chiffre et  la longueur doit être d'au moins 8 caractères.";
      }
    }

    return null;
  }

  String? confirmationValidator(String? value) {
    if (widget.canBeEmpty ? false : (value == null || value.isEmpty)) {
      return 'Veuillez confirmer ${widget.isFeminine ? "le" : "le"} '
          '${widget.label.toLowerCase()}';
    }

    if (value != widget.controller.text) {
      return "Les mots de passe ne correspondent pas";
    }

    return null;
  }
}
