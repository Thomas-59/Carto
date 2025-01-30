import 'package:carto/viewmodel/account_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// The form field for email address of a user
class MailFormField extends StatefulWidget {
  /// The initializer of the class
  const MailFormField({
    super.key,
    required this.label,
    required this.controller,
    this.isFeminine = false,
    this.canBeEmpty = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.ignoreMail,
  });

  /// The label of the field
  final String label;
  /// The address email to ignore
  final String? ignoreMail;
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
  State<MailFormField> createState() => _MailFormFieldState();
}

/// The state of MailFormField
class _MailFormFieldState extends State<MailFormField> {
  /// The error message to show
  String? _mailError;
  /// If the widget is checking the usability of the value
  bool _isChecking = false;

  /// The view model to deal with an account
  AccountViewModel accountViewModel = AccountViewModel();

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
          suffixIcon: _isChecking ? const CircularProgressIndicator() : null,
          errorText: _mailError,
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

    final RegExp mailRegex =
    RegExp( r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" );
    if(value != null && !mailRegex.hasMatch(value)) {
      return "$value n'est pas ${widget.isFeminine ? "une" : "un"} "
          "${widget.label.toLowerCase()} valide";
    }

    return _mailError;
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_validateMail);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validateMail);
    super.dispose();
  }

  /// check if the address email is valid and available
  void _validateMail() async {
    final emailAddress = widget.controller.text;
    if (emailAddress.isEmpty) {
      setState(() {
        _mailError = null;
      });
      return;
    }

    setState(() {
      _isChecking = true;
    });

    try {
      if((widget.ignoreMail == null) && (widget.ignoreMail != emailAddress)) {
        String? result = await accountViewModel.checkEmailExists(emailAddress);

        if (result == 'Email address already exists') {
          setState(() {
            _mailError = "Un compte a déjà été créé avec cette adresse.";
          });
        } else if (result == 'Email is available') {
          setState(() {
            _mailError = null;
          });
        }
      } else {
        setState(() {
          _mailError = null;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erreur lors de la vérification du mail : $e');
      }
      setState(() {
        _mailError = "Erreur lors de la vérification.";
      });
    } finally {
      setState(() {
        _isChecking = false;
      });
    }
  }
}