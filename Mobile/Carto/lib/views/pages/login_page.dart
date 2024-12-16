import 'package:carto/data_manager.dart';
import 'package:carto/views/widgets/form/form_fields/my_form_field.dart';
import 'package:carto/views/widgets/form/other_fields/my_checkbox_list_tile.dart';
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

                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                          child: GestureDetector(
                            onTap: () {
                              //TODO Forgotten password
                            },
                            child: const Text("mot de passe oublié ?"),
                          ),
                        ),
                      ],
                    ),

                    /*CheckboxListTile(
                        value: _remember,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: const Text("se souvenir de moi"),

                        onChanged:(newValue){
                          setState(() {
                            _remember = newValue ?? _remember;
                          });
                        }),*/
                    MyCheckboxListTile(
                      value: _remember,
                      title: "se souvenir de moi",
                      onChanged: (newValue){
                        setState(() {
                          _remember = newValue ?? _remember;
                        });
                      }
                    ),
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
}
