import 'package:carto/viewmodel/account_view_model.dart';
import 'package:carto/views/widgets/buttons.dart';
import 'package:carto/views/widgets/form/form_fields/my_form_field_mail.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: const Color.fromARGB(255, 216, 184, 253),
      body: Form(
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
              "Mot de passe oublié ?",
              style: TextStyle(fontSize: 20),
            ),
            const DefaultText(
              "Entrez votre adresse e-mail pour recevoir un lien sécurisé"
                " qui vous permettra de réinitialiser votre mot de passe.",
              textAlign: TextAlign.left,
            ),
            MyFormFieldMail(
              label: "Adresse mail",
              controller: _emailController,
              isFeminine: true,
            ),
            FractionallySizedBox(
              alignment: Alignment.center,
              widthFactor: 0.8,
              child: DefaultElevatedButton(
                onPressed: _sendMail,
                title: "Envoyer le mail de récupération",
                validator: _isFormValid,
              )
            ),
          ],
        )
      ),
    );
  }

  void _sendMail() {
    accountViewModel.forgottenPassword(_emailController.text);
    Navigator.pop(context);
  }
}
