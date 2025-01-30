import 'dart:collection';

import 'package:carto/models/account.dart';
import 'package:carto/viewmodel/account_view_model.dart';
import 'package:carto/viewmodel/establishment_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/establishment.dart';

// This class must not have any function except getInstance()
/// A class who keep all value need by the rest of the application
class DataManager {
  /// The instance of DataManager
  static final DataManager _singleton = DataManager._internal();
  /// The state of connection of user
  static bool isLogged = false;
  /// The token used as credential for getting the functional token
  static String credential = "";
  /// The token used to identify the user in the carto API
  static String token = "";
  /// The data of the user if logged
  static Account? account;
  /// The list of filter used in the map
  static HashMap<String, bool> filterMap = HashMap();
  /// The list of establishment possessed by user
  static List<Establishment> possessedEstablishment = List.empty();
  /// The list of all establishments to show
  static late Future<List<Establishment>> establishmentsFuture;
  /// The list of all establishments know by the carto API
  static late Future<List<Establishment>> establishmentsOriginFuture;
  /// The instance of SharedPreferences
  static late SharedPreferences prefs;

  DataManager._internal();

  /// Create the first instance of DataManager and init all value who are not constant
  static Future<DataManager> getInstance() async {
    prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("credential")) {
      credential = prefs.getString("credential")!;
      if(credential.isNotEmpty) {
        isLogged = true;
        await AccountViewModel().getToken();
        await AccountViewModel().getAccount();
      }
    }

    final EstablishmentViewModel establishmentViewModel = EstablishmentViewModel();
    filterMap.addAll({
      'Billard': false,
      'Fléchettes': false,
      'Babyfoot': false,
      'Ping-Pong': false,
      'Arcade': false,
      'Flipper': false,
      'Karaoké': false,
      'Cartes': false,
      'Sociétés': false,
      'Pétanque': false
    });
    establishmentsOriginFuture = establishmentViewModel.getAllEstablishment();
    establishmentsFuture = establishmentsOriginFuture;

    return _singleton;
  }
}
