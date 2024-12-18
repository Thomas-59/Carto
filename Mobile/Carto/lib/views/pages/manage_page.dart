import 'package:carto/views/widgets/buttons.dart';
import 'package:carto/views/services/account_service.dart';
import 'package:flutter/material.dart';

import '../../data_manager.dart';

class ManagePage extends StatefulWidget {
  const ManagePage({super.key});

  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
              body:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/logo/logo_purple.png"),
                  !DataManager.isLogged ?
                    const SizedBox() :
                    MyElevatedButton(
                      title: "gérer mon compte",
                      onPressed: () {
                        //TODO manage account
                      },
                    ),
                  MyElevatedButton(
                    title: DataManager.isLogged ?
                      "Changer de compte" : "Se connecter",
                    onPressed: () {
                      if(DataManager.isLogged) {
                        disconnect();
                      }
                      Navigator.pushNamed(context, "/login",);
                    },
                  ),
                  !DataManager.isLogged ?
                    const SizedBox() :
                    MyElevatedButton(
                      title: "Se déconnecter",
                      onPressed: () {
                        disconnect();
                      },
                    ),
                  !DataManager.isLogged ?
                    const SizedBox() :
                  MyElevatedButton(
                      color : Colors.red,
                      title: "Supprimer mon compte",
                      textStyle: const TextStyle(color: Colors.white),
                      onPressed: onDelete,
                    ),
                  MyElevatedButton(
                    title: "Retour à la carte",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            backgroundColor: const Color.fromARGB(255, 216, 184, 253),
          );
        }
    );
  }

  void onDelete() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      "\nÊtes-vous sûr de vouloir supprimer votre compte ?\n\n"
                          "Cette action est définitive !",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyElevatedButton(
                          title: "Suprimer",
                          onPressed: () {
                            setState(() {
                              AccountService().deleteAccount();
                              Navigator.of(context).pop();
                            });
                          },
                          color: Colors.red,
                          width: 125,
                        ),
                        MyElevatedButton(
                          title: "Annuler",
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          width: 125,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );//Navigator.pop(context);
  }

  void disconnect() {
    setState(() {
      AccountService().disconnect();
    });
  }
}
