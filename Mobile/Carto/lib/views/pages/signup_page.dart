import 'package:carto/models/account.dart';
import 'package:carto/views/services/account_service.dart';
import 'package:carto/views/widgets/form/account_form.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(children: [
            const Text(
              "Inscription",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.5),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                child: AccountForm(
                  onConfirmation: signUp,
                  buttonTitle: "S'inscrire",
                )
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/login",);
                },
                child: const Text("J'ai déjà un compte"),
              ),
            )
          ])
        ],
      ),
    );
  }

  void signUp(Account newAccount) async {
    AccountService accountService = AccountService();
    String? accountId;

    String? id = await accountService.createAccount(newAccount);

    if (id != null) {
      setState(() {
        accountId = id;
      });

      if (kDebugMode) {
        print("Compte créé avec succès. ID du compte : $accountId");
      }

      Navigator.pushNamed(context, '/home');
    } else {
      if (kDebugMode) {
        print("Erreur lors de la création du compte");
      }
    }
  }
}
