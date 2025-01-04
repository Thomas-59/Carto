import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carto/views/services/account_service.dart';

class UsernameFormField extends StatefulWidget {
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

  final String label;
  final String? ignoreUsername;
  final TextEditingController controller;
  final bool isFeminine, canBeEmpty;
  final int minLines, maxLines;

  @override
  State<UsernameFormField> createState() => _UsernameFormFieldState();
}

class _UsernameFormFieldState extends State<UsernameFormField> {
  String? _usernameError;
  bool _isChecking = false;

  AccountService accountService = AccountService();

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
      if((widget.ignoreUsername != null) && (widget.ignoreUsername != username)) {
        String? result = await accountService.checkUsernameExists(username);

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
