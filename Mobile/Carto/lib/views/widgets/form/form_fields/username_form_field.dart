import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:carto/models/account.dart';
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
  });

  final String label;
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
          suffixIcon: _isChecking ? CircularProgressIndicator() : null,
          errorText: _usernameError,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: _validator,
      ),
    );
  }

  String? _validator(String? value) {
    if (widget.canBeEmpty ? false : (value == null || value.isEmpty)) {
      return 'Veuillez entrer ${widget.isFeminine ? "une" : "un"} ${widget.label.toLowerCase()}';
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
      Account? account = await accountService.getAccountByUsername(username);

      if (account != null) {
        setState(() {
          _usernameError = "L'identifiant $username existe déjà.";
        });
      } else {
        setState(() {
          _usernameError = null;
        });
      }
    } catch (DioException) {
      print('Erreur lors de la vérification du nom d\'utilisateur : $DioException');
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
