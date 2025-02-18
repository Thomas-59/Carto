import 'package:carto/models/account.dart';
import 'package:carto/viewmodel/account_view_model.dart';
import 'package:carto/views/widgets/form/account_form.dart';
import 'package:carto/views/widgets/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// The page to let the user create a new account
class SignUpPage extends StatefulWidget {

  /// The initializer of the class
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

/// The state of the SignUpPage stateful widget
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

  /// Create a new account in our API
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

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: const Text('Bienvenue sur Carto ! Tu peux te connecter à présent, un mail te confirmera ton inscription.', style: blueTextBold16,),
            duration: const Duration(seconds: 5),
            behavior: SnackBarBehavior.floating,
            backgroundColor: white,
            shape : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )
        ),
      );

      Navigator.pop(context);
    } else {
      if (kDebugMode) {
        print("Erreur lors de la création du compte");
      }
    }
  }
}
