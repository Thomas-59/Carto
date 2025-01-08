import 'package:carto/viewmodel/account_view_model.dart';
import 'package:carto/views/widgets/buttons.dart';
import 'package:carto/views/widgets/form/form_fields/my_form_field_mail.dart';
import 'package:flutter/material.dart';

import '../widgets/constants.dart';
import '../widgets/text.dart';

class ForgottenPasswordPage extends StatefulWidget {
  const ForgottenPasswordPage({super.key});

  @override
  State<ForgottenPasswordPage> createState() => _ForgottenPasswordPageState();
}

class _ForgottenPasswordPageState extends State<ForgottenPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AccountViewModel accountViewModel = AccountViewModel();
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
                )
              ],
            )),
      ),
    );
  }

  void _sendMail() {
    accountViewModel.forgottenPassword(_emailController.text);
    Navigator.pop(context);
  }
}
