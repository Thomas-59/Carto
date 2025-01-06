import 'package:carto/models/account.dart';
import 'package:carto/views/services/account_service.dart';
import 'package:carto/views/widgets/constants.dart';
import 'package:carto/views/widgets/form/form_fields/mail_form_field.dart';
import 'package:carto/views/widgets/form/form_fields/manager_information_form_field.dart';
import 'package:carto/views/widgets/form/form_fields/double_password_form_field.dart';
import 'package:carto/views/widgets/form/other_fields/my_checkbox_list_tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'form_fields/username_form_field.dart';

class AccountForm extends StatefulWidget {
  final Account? account;
  final ValueChanged<Account> onConfirmation;
  final String buttonTitle;
  final bool onUpdate;

  const AccountForm({
    super.key,
    this.account,
    required this.onConfirmation,
    required this.buttonTitle,
    this.onUpdate = false,
  });

  @override
  AccountFormState createState() {
    return AccountFormState();
  }
}

class AccountFormState extends State<AccountForm> {
  final _formKey = GlobalKey<FormState>();
  final AccountService accountService = AccountService();
  bool _showManagerFields = false;
  bool _isFormValid = false;

  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _passwordVerifyController;
  late final TextEditingController _emailAddressController;
  late final TextEditingController _phoneController;
  late final TextEditingController _sirenNumController;
  late final TextEditingController _surnameController;
  late final TextEditingController _firstnameController;

  @override
  void initState() {
    Account initAccount = widget.account ?? Account.defaultAccount();

    _usernameController = TextEditingController(text: initAccount.username);
    _passwordController = TextEditingController(text: initAccount.password);
    _passwordVerifyController = TextEditingController(text: initAccount.password);
    _emailAddressController = TextEditingController(text: initAccount.emailAddress);
    _phoneController = TextEditingController(text: initAccount.managerInformation?.phoneNumber ?? "");
    _sirenNumController = TextEditingController(text: initAccount.managerInformation?.sirenNumber ?? "");
    _surnameController = TextEditingController(text: initAccount.managerInformation?.surname ?? "");
    _firstnameController = TextEditingController(text: initAccount.managerInformation?.firstname ?? "");

    super.initState();
  }

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

  void _onConfirmation() async {
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

      widget.onConfirmation(newAccount);

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
              label: "Pseudonyme",
              controller: _usernameController,
              ignoreUsername: widget.onUpdate ? widget.account?.username : null,
          ),
          MailFormField(
              label: "Adresse mail",
              controller: _emailAddressController,
              ignoreMail: widget.onUpdate ? widget.account?.emailAddress : null,
          ),
          PasswordFormField(
              label: "Mot de passe",
              controller: _passwordController,
              confirmationController: _passwordVerifyController,
              canBeEmpty: widget.onUpdate,
          ),
          MyCheckboxListTile(
            title: "Êtes-vous un gérant d'établissement ?",
            value: _showManagerFields,
            onChanged: (bool? value) {
              setState(() {
                _showManagerFields = value ?? false;
                _isFormValid = _formKey.currentState?.validate() ==
                    true;
              });
              if (kDebugMode) {
                print("Case à cocher modifiée : $_showManagerFields");
                print("Formulaire valide : $_isFormValid");
              }
            },
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
                  ? _onConfirmation
                  : null,
              child: Text(
                widget.buttonTitle,
                style: const TextStyle(color: Colors.white)
              )
            ),
          ),
        ],
      ),
    );
  }
}
