import 'package:carto/models/account.dart';
import 'package:carto/viewmodel/account_view_model.dart';
import 'package:carto/views/widgets/form/account_form.dart';
import 'package:carto/views/widgets/constants.dart';
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
      appBar: AppBar(
        title: const Text("INSCRIPTION"),
        backgroundColor: blue,
        titleTextStyle: appBarTextStyle,
        centerTitle: true,
        iconTheme: const IconThemeData(color: white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffffffff), Color(0xffd4bbf9)],
            stops: [0.7, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Column(children: [
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
                    Navigator.pop(context);
                  },
                  child: const Text("J'ai déjà un compte", style: blueTextNormal14),
                ),
              )
            ])
          ],
        ),
      ),
    );
  }

  void signUp(Account newAccount) async {
    AccountViewModel accountViewModel = AccountViewModel();
    String? accountId;

    String? id = await accountViewModel.createAccount(newAccount);

    if (id != null) {
      setState(() {
        accountId = id;
      });

      if (kDebugMode) {
        print("Compte créé avec succès. ID du compte : $accountId");
      }

      Navigator.pop(context);
    } else {
      if (kDebugMode) {
        print("Erreur lors de la création du compte");
      }
    }
  }
}
