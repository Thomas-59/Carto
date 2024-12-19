import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {

  const PasswordFormField(
      {super.key,
      required this.label,
      required this.controller,
      this.isFeminine = false,
      this.canBeEmpty = false,
      this.minLines = 1,
      this.maxLines = 1,
      this.confirmationController});

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
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              obscureText: passwordVisible,
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              controller: widget.controller,
              decoration: InputDecoration(
                labelText: widget.label,
                hintText: "Mot de passe",
                helperText: '''Le mot de passe doit contenir au moins 1 majuscule, \n1 chiffre et  la longueur doit être d'au moins 8 caractères.
                ''',
                suffixIcon: IconButton(
                    icon: Icon(
                        passwordVisible ? Icons.visibility : Icons.visibility_off),
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
              ),
              autovalidateMode: AutovalidateMode.always,
              validator: validator,
            ),
            const SizedBox(height: 8),
            if (widget.confirmationController != null)
              TextFormField(
                obscureText: confirmationVisible,
                minLines: widget.minLines,
                maxLines: widget.maxLines,
                controller: widget.confirmationController,
                decoration: InputDecoration(
                  labelText: 'Confirmation du ${widget.label}',
                  hintText: "Confirmer le mot de passe",
                  suffixIcon: IconButton(
                    icon: Icon(confirmationVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        confirmationVisible = !confirmationVisible;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                autovalidateMode: AutovalidateMode.always,
                validator: confirmationValidator,
              ),
          ],
        ));
  }

  String? validator(String? value) {
    if (widget.canBeEmpty ? false : (value == null || value.isEmpty)) {
      return 'Veuillez entrer ${widget.isFeminine ? "une" : "un"} '
          '${widget.label.toLowerCase()}';
    }

    if (value != null) {
      final RegExp passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$');
      if (!passwordRegex.hasMatch(value)) {
        return "Le mot de passe doit contenir au moins 1 majuscule, \n1 chiffre et  la longueur doit être d'au moins 8 caractères.";
      }
    }

    return null;
  }

  String? confirmationValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez confirmer ${widget.isFeminine ? "le" : "le"} ${widget.label.toLowerCase()}';
    }

    if (value != widget.controller.text) {
      return "Les mots de passe ne correspondent pas";
    }

    return null;
  }
}
