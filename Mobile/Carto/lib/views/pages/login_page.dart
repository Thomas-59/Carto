import 'package:carto/data_manager.dart';
import 'package:carto/views/widgets/form/form_fields/my_form_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mailOrPseudoController =
    TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  bool _canLog = false;
  bool _remember = false;

  @override
  initState() {
    mailOrPseudoController.addListener(() {
      setState(() {
        _canLog = _canTryToLog();
      });
    });

    passwordController.addListener(() {
      setState(() {
        _canLog = _canTryToLog();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            body:
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(8, 16, 8, 25),
                      child: Text(
                        "connexion",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25
                        ),
                      ),
                    ),

                    MyFormField(
                      label: "Mail ou pseudo",
                      controller: mailOrPseudoController,
                      canBeEmpty: true,
                    ),
                    MyFormField(
                      label: "Mot de passe",
                      controller: passwordController,
                      canBeEmpty: true,
                    ),

                    CheckboxListTile(
                        value: _remember,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: const Text("se souvenir de moi"),
                        onChanged:(newValue){
                          setState(() {
                            _remember = newValue ?? _remember;
                          });
                        }),
                    ElevatedButton(
                      style: _canLog ?
                        ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        )
                        : ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                        child: const Text("Connexion"),
                      onPressed: () {
                        if(_canLog) {
                          //
                          String credential = mailOrPseudoController.text;
                          if(_remember) {
                            DataManager.prefs.setString("credential", credential);
                          }
                          DataManager.credential = credential;
                          Navigator.pop(context);
                        }
                      },
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: const Text("Créer un compte "),
                            onPressed: () {
                              //TODO Laurine part
                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                            onTap: () {
                              //TODO Forgotten password
                            },
                            child: const Text("mot de passe oublié ?"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
          );
        }
    );
  }

  bool _canTryToLog() {
    return mailOrPseudoController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }
}
