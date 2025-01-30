import 'package:carto/viewmodel/account_view_model.dart';
import 'package:carto/views/widgets/buttons.dart';
import 'package:carto/views/widgets/form/form_fields/my_form_field_mail.dart';
import 'package:flutter/material.dart';

import '../widgets/constants.dart';
import '../widgets/text.dart';

/// The page where the user can ask to change is password when he forgotten his
class ForgottenPasswordPage extends StatefulWidget {

  /// The initializer of the class
  const ForgottenPasswordPage({super.key});

  @override
  State<ForgottenPasswordPage> createState() => _ForgottenPasswordPageState();
}

/// The state of the ForgottenPasswordPage stateful widget
class _ForgottenPasswordPageState extends State<ForgottenPasswordPage> {
  /// The TextEditingController of the field where enter the address email of
  /// the account
  final TextEditingController _emailController = TextEditingController();
  /// The key of the form
  final _formKey = GlobalKey<FormState>();
  /// The view model to access to the service which communicate with the account
  /// part of our API
  final AccountViewModel accountViewModel = AccountViewModel();
  /// The state of validity of the form
  bool _isFormValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text("MOT DE PASSE \nOUBLIÉ"),
        backgroundColor: blue,
        titleTextStyle: appBarTextStyle,
        centerTitle: true,
        iconTheme: const IconThemeData(color: white),
      ),
      backgroundColor: white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffffffff), Color(0xffd4bbf9)],
            stops: [0.7, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Form(
            key: _formKey,
            onChanged: () {
              setState(() {
                _isFormValid = _formKey.currentState?.validate() == true;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const DefaultText(
                  "Entrez votre adresse e-mail pour recevoir un lien sécurisé"
                  " qui vous permettra de réinitialiser votre mot de passe.",
                  textAlign: TextAlign.left,
                  style: textInPageTextStyle,
                ),
                MyFormFieldMail(
                  label: "Adresse mail",
                  controller: _emailController,
                  isFeminine: true,
                ),
                LargeDefaultElevatedButton(
                  title: "Envoyer le mail de récupération",
                  onPressed: _sendMail,
                  validator: _isFormValid,
                  height: 50,
                )
              ],
            )),
      ),
    );
  }

  /// Call the endpoint to send a email to change the password if the given
  /// address email is linked to an account
  void _sendMail() {
    accountViewModel.forgottenPassword(_emailController.text);
    Navigator.pop(context);
  }
}
