import 'package:carto/viewmodel/account_view_model.dart';
import 'package:carto/views/widgets/buttons.dart';
import 'package:carto/views/widgets/constants.dart';
import 'package:flutter/material.dart';

import '../../services/account_service.dart';

/// The page where the user can have access to most of the page or action
/// related to the management of the account
class ManagePage extends StatefulWidget {

  /// The initializer of the class
  const ManagePage({super.key});

  @override
  State<ManagePage> createState() => _ManagePageState();
}

/// The state of the ManagePage stateful widget
class _ManagePageState extends State<ManagePage> {
  /// The view model to access to the service which communicate with the account
  /// part of our API
  AccountViewModel accountViewModel = AccountViewModel();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
              body:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Image.asset("assets/logo/logo_blue.png")
                  ),
                  LargeDefaultElevatedButton(
                    title: "Gérer mon compte",
                    onPressed: () {
                      Navigator.pushNamed(context, "/account",);
                    },
                  ),
                  LargeDefaultElevatedButton(
                    title: "Changer de compte",
                    onPressed: () {
                      _disconnect();
                      Navigator.pushNamed(context, "/login",);
                    },
                  ),
                  LargeDefaultElevatedButton(
                    title: "Se déconnecter",
                    onPressed: _disconnect
                  ),
                  LargeRedElevatedButton(
                    title: "Supprimer mon compte",
                    onPressed: _onDelete,
                  ),
                  LargeDefaultElevatedButton(
                    title: "Retour à la carte",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            backgroundColor: blue,
          );
        }
    );
  }

  /// Ask the user if he really want to suppress is account and act on is
  /// response
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
                          title: "Supprimer",
                          onPressed: () {
                            setState(() {
                              accountViewModel.deleteAccount();
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

  /// Disconnect the account of the user from the application
  void _disconnect() {
    setState(() {
      AccountService().disconnect();
      Navigator.pop(context);
    });
  }
}
