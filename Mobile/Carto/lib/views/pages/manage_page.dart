import 'package:carto/views/widgets/buttons.dart';
import 'package:carto/views/services/account_service.dart';
import 'package:flutter/material.dart';

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
                  DefaultElevatedButton(
                    title: "gérer mon compte",
                    onPressed: () {
                      Navigator.pushNamed(context, "/account",);
                    },
                  ),
                  DefaultElevatedButton(
                    title: "Changer de compte",
                    onPressed: () {
                      _disconnect();
                      Navigator.pushNamed(context, "/login",);
                    },
                  ),
                  DefaultElevatedButton(
                    title: "Se déconnecter",
                    onPressed: _disconnect
                  ),
                  RedElevatedButton(
                    title: "Supprimer mon compte",
                    onPressed: _onDelete,
                  ),
                  DefaultElevatedButton(
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

  void _onDelete() {
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
                        RedElevatedButton(
                          title: "Suprimer",
                          onPressed: () {
                            setState(() {
                              AccountService().deleteAccount();
                              Navigator.of(context)..pop()..pop();
                            });
                          },
                          width: 125,
                        ),
                        DefaultElevatedButton(
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

  void _disconnect() {
    setState(() {
      AccountService().disconnect();
      Navigator.pop(context);
    });
  }
}
