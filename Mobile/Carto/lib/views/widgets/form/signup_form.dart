import 'package:carto/models/account.dart';
import 'package:carto/views/services/account_service.dart';
import 'package:carto/views/widgets/constants.dart';
import 'package:carto/views/widgets/form/form_fields/mail_form_field.dart';
import 'package:carto/views/widgets/form/form_fields/manager_information_form_field.dart';
import 'package:carto/views/widgets/form/form_fields/my_form_field.dart';
import 'package:carto/views/widgets/form/form_fields/my_form_field_int.dart';
import 'package:carto/views/widgets/form/form_fields/password_form_field.dart';
import 'package:flutter/foundation.dart';
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
  bool _showManagerFields = false;
  bool _isFormValid = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordVerifyController =
      TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _sirenNumController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();

  String? accountId;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailAddressController.dispose();
    _passwordController.dispose();
    _passwordVerifyController.dispose();
    _phoneController.dispose();
    _sirenNumController.dispose();
    _surnameController.dispose();
    _firstnameController.dispose();
    super.dispose();
  }

  void _signUp() async {
    if (_formKey.currentState?.validate() == true) {
      Account newAccount = Account(
        username: _usernameController.text,
        emailAddress: _emailAddressController.text,
        password: _passwordController.text,
        createdAt: DateTime.now(),
        role: _showManagerFields ? Role.manager : Role.user,
        managerInformation: _showManagerFields
            ? ManagerInformation(
                surname: _surnameController.text,
                firstname: _firstnameController.text,
                phoneNumber: _phoneController.text,
                sirenNumber: _sirenNumController.text)
            : null,
      );

      String? id = await accountService.createAccount(newAccount);

      if (id != null) {
        setState(() {
          accountId = id;
        });

        if (kDebugMode) {
          print("Compte créé avec succès. ID du compte : $accountId");
        }
      } else {
        if (kDebugMode) {
          print("Erreur lors de la création du compte");
        }
      }
    } else {
      if (kDebugMode) {
        print("Formulaire invalide");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: () {
        setState(() {
          _isFormValid = _formKey.currentState?.validate() == true;
        });
        if (kDebugMode) {
          print("Formulaire valide $_isFormValid");
        }
      },
      child: Column(
        children: <Widget>[
          UsernameFormField(
              label: "Pseudonyme", controller: _usernameController),
          MailFormField(
              label: "Adresse mail", controller: _emailAddressController),
          PasswordFormField(
              label: "Mot de passe",
              controller: _passwordController,
              confirmationController: _passwordVerifyController),
          CheckboxListTile(
            title: const Text("Êtes-vous un gérant d'établissement ?"),
            value: _showManagerFields,
            onChanged: (bool? value) {
              setState(() {
                _showManagerFields = value ?? false;
                _isFormValid = _formKey.currentState?.validate() ==
                    true; // Re-valide le formulaire
              });
              if (kDebugMode) {
                print("Case à cocher modifiée : $_showManagerFields");
                print("Formulaire valide : $_isFormValid");
              }
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          if (_showManagerFields) ...[
            StringFormField(label: "Nom", controller: _surnameController),
            StringFormField(label: "Prénom", controller: _firstnameController),
            IntegerFormField(
                label: "Numéro SIREN de la société",
                controller: _sirenNumController),
            IntegerFormField(
                label: "Numéro de téléphone", controller: _phoneController),
          ],
          FractionallySizedBox(
            alignment: Alignment.center,
            widthFactor: 0.8,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isFormValid ? blue : Colors.grey,
                ),
                onPressed: _isFormValid
                    ? () {
                        _signUp();
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
