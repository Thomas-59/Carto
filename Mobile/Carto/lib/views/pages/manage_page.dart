import 'package:carto/utils/buttons.dart';
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
                      Navigator.pushNamed(context, '/login',);
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
                    Padding( padding: const EdgeInsets.all(8.0),
                      child : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text(
                          "Supprimer mon compte",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          //TODO delete account
                          Navigator.pop(context);
                        },
                      ),
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

  void disconnect() {
    setState(() {
      DataManager.isLogged = false;
      DataManager.credential = "";
      DataManager.token = "";
      DataManager.prefs.setString("credential", "");
    });
  }
}
