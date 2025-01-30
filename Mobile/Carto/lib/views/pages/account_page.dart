import 'package:carto/data_manager.dart';
import 'package:carto/models/account.dart';
import 'package:carto/models/establishment.dart';
import 'package:carto/viewmodel/account_view_model.dart';
import 'package:carto/views/widgets/constants.dart';
import 'package:carto/views/widgets/form/account_form.dart';
import 'package:carto/views/widgets/text.dart';
import 'package:carto/views/widgets/buttons.dart';
import 'package:flutter/material.dart';

/// The page to update the user account and the possibility for manager to see
/// their establishment, reclaim new establishment and having access to the
/// page to modify the data of their establishment
class AccountPage extends StatefulWidget {

  /// The initializer of the class
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPage();
}

/// The state of the AccountPage stateful widget
class _AccountPage extends State<AccountPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VOTRE COMPTE'),
        backgroundColor: blue,
        titleTextStyle: appBarTextStyle,
        centerTitle: true,
        iconTheme: const IconThemeData(color: white),
      ),
      backgroundColor: white,
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
                  onConfirmation: _onConfirmation,
                  account: DataManager.account,
                  buttonTitle: "Modifier",
                  onUpdate: true,
                )
              ),
              if(DataManager.account!.managerInformation != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const DefaultText("Liste de vos établissements : ",
                          style : textInPageTextStyle),
                          IconButton(
                            onPressed: _claimEstablishment,
                            icon: const Icon(Icons.add_circle_outline,),
                            iconSize: 35,
                          ),
                        ],
                      ),
                      Column(
                        children: listEstablishmentCard(),
                      ),
                    ],
                  )
                ),
            ])
          ],
        ),
      ),
    );
  }

  /// Update account data and asks the user if he is sure he wants to if user
  /// discard is MANAGER status is the situation happen
  void _onConfirmation(Account newAccount) {
    if((newAccount.managerInformation == null) &&
      (DataManager.account!.managerInformation != null))
    {
      confirmationLostManagement(newAccount);
    } else {
      updateAccount(newAccount);
    }
  }

  /// Update the data of the user account
  void updateAccount(Account newAccount) {
    setState(() {
      AccountViewModel accountViewModel = AccountViewModel();
      accountViewModel.updateAccount(newAccount);
      DataManager.account = newAccount;
      const snackBar = SnackBar(
        content: Text('Modification effectuée !'),
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  ///asks the user if he is sure he wants to discard is MANAGER status and
  ///update them if he agree
  void confirmationLostManagement(Account newAccount) {
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
                      "\nÊtes-vous sûr de vouloir supprimer vos données de "
                        "manager ?\n\n"
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
                              updateAccount(newAccount);
                              Navigator.of(context).pop();
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

  /// Give a list of card of all establishments possessed by the user
  List<Widget> listEstablishmentCard() {
    List<Widget> cards = List.empty(growable: true);
    for(Establishment establishment in DataManager.possessedEstablishment) {
      cards.add(establishmentCard(establishment));
    }
    return cards;
  }

  /// Give a card of the given establishment
  Widget establishmentCard(Establishment establishment) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.popAndPushNamed(
            context,
            '/establishment_detail',
            arguments: {'establishment': establishment},
          );
        },
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    establishment.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(establishment.address),
                ],
              ),
          ),
        ),
      )
    );
  }

  /// Allow the  user to try to claim a establishment (Not implemented, so show
  /// a  message "Coming soon" to the user
  void _claimEstablishment() {
    //TODO claim establishment
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Fonctionnalité bientôt disponible !', style: blueTextBold16),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        backgroundColor: white,
        shape : RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        )
      ),
    );
  }
}
