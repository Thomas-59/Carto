import 'package:carto/data_manager.dart';
import 'package:carto/viewmodel/account_view_model.dart';
import 'package:carto/views/widgets/buttons.dart';
import 'package:carto/views/widgets/form/form_fields/my_form_field.dart';
import 'package:carto/views/widgets/form/form_fields/single_password_form_field.dart';
import 'package:carto/views/widgets/form/other_fields/my_checkbox_list_tile.dart';
import 'package:flutter/material.dart';

import '../../services/account_service.dart';

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
                        "Connexion",
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
                    SinglePasswordFormField(
                      label: "Mot de passe",
                      controller: passwordController,
                      canBeEmpty: true,
                    ),

                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 8, 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/forgotten",);
                            },
                            child: const Text(
                                "Mot de passe oublié ?",
                                style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                      ],
                    ),
                    MyCheckboxListTile(
                      value: _remember,
                      title: "Se souvenir de moi",
                      onChanged: (newValue) {
                        setState(() {
                          _remember = newValue ?? _remember;
                        });
                      }
                    ),
                    BlueElevatedButton(
                      onPressed: tryLog,
                      title: "Connexion",
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Pas de compte ?"),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 8, 0),
                            child:GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/signup",);
                              },
                              child: const Text(
                                  "Inscris-toi !",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            backgroundColor: const Color.fromARGB(255, 216, 184, 253),
          );
        }
    );
  }

  bool _canTryToLog() {
    return mailOrPseudoController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  void tryLog() async {
    if(_canLog) {
      AccountViewModel accountService = AccountViewModel();
      bool isLog = await accountService.logIn(
          mailOrPseudoController.text,
          passwordController.text
      );
      if(isLog) {
        if (_remember) {
          DataManager.prefs.setString("credential", DataManager.credential);
        }
        Navigator.pop(context);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                "Échec de la connexion",
                textAlign: TextAlign.center,
              ),
              content: const Text(
                  "Le mot de passe ou nom utilisateur/mail que vous utilisé est"
                      " incorrecte",
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                Center(
                  child: TextButton(
                    child: const Text("Fermer"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            );
          },
        );
      }
    }
  }
}
