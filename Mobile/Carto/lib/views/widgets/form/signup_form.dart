import 'package:carto/models/account.dart';
import 'package:carto/views/services/account_service.dart';
import 'package:carto/views/widgets/constants.dart';
import 'package:carto/views/widgets/form/form_fields/mail_form_field.dart';
import 'package:carto/views/widgets/form/form_fields/password_form_field.dart';
import 'package:flutter/material.dart';

import 'form_fields/username_form_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final AccountService accountService = AccountService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordVerifyController =
      TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailAddressController.dispose();
    _passwordController.dispose();
    _passwordVerifyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          UsernameFormField(
              label: "Identifiant", controller: _usernameController),
          MailFormField(
              label: "Adresse mail", controller: _emailAddressController),
          PasswordFormField(
              label: "Mot de passe",
              controller: _passwordController,
              confirmationController: _passwordVerifyController),
          FractionallySizedBox(
            alignment: Alignment.center,
            widthFactor: 0.8,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _formKey.currentState?.validate() == true
                      ? blue
                      : Colors.grey,
                ),
                onPressed: _formKey.currentState?.validate() == true
                    ? () {
                        accountService.createAccount(Account(
                            username: _usernameController.text,
                            emailAddress: _emailAddressController.text,
                            password: _passwordController.text,
                            createdAt: DateTime.now(),
                            role: Role.user));
                        Navigator.pushNamed(context, '/home');
                      }
                    : null,
                child: const Text("S'inscrire",
                    style: TextStyle(color: Colors.white))),
          ),
        ],
      ),
    );
  }
}
