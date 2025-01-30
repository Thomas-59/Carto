import 'package:carto/viewmodel/account_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// The default form field for user name
class UsernameFormField extends StatefulWidget {
  /// The initializer of the class
  const UsernameFormField({
    super.key,
    required this.label,
    required this.controller,
    this.isFeminine = false,
    this.canBeEmpty = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.ignoreUsername
  });

  /// The label of the field
  final String label;
  /// The user name to not test
  final String? ignoreUsername;
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
  State<UsernameFormField> createState() => _UsernameFormFieldState();
}

/// The state of UsernameFormField
class _UsernameFormFieldState extends State<UsernameFormField> {
  /// The error message to show
  String? _usernameError;
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
          errorText: _usernameError,
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
    return _usernameError;
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_validateUsername);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validateUsername);
    super.dispose();
  }

  /// Check if the user name is valid and available
  void _validateUsername() async {
    final username = widget.controller.text;
    if (username.isEmpty) {
      setState(() {
        _usernameError = null;
      });
      return;
    }

    setState(() {
      _isChecking = true;
    });

    try {
      if((widget.ignoreUsername == null) || (widget.ignoreUsername != username)) {
        String? result = await accountViewModel.checkUsernameExists(username);

        if (result == 'Username already exists') {
          setState(() {
            _usernameError = "L'identifiant $username existe déjà.";
          });
        } else if (result == 'Username is available') {
          setState(() {
            _usernameError = null;
          });
        }
      }
    } catch (dioException) {
      if (kDebugMode) {
        print('Erreur lors de la vérification du nom d\'utilisateur : '
            '$dioException');
      }
      setState(() {
        _usernameError = "Erreur lors de la vérification.";
      });
    } finally {
      setState(() {
        _isChecking = false;
      });
    }
  }
}
