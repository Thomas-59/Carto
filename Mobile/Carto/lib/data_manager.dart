import 'dart:collection';

import 'package:carto/models/account.dart';
import 'package:carto/viewmodel/account_view_model.dart';
import 'package:carto/viewmodel/establishment_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/establishment.dart';

class DataManager {
  static final DataManager _singleton = DataManager._internal();
  static bool isLogged = false;
  static String credential = "";
  static String token = "";
  static Account? account;
  static HashMap<String, bool> filterMap = HashMap();
  static List<Establishment> possessedEstablishment = List.empty();


  static late Future<List<Establishment>> establishmentsFuture;
  static late Future<List<Establishment>> establishmentsOriginFuture;
  static late SharedPreferences prefs;

  DataManager._internal();
  static Future<DataManager> getInstance() async {
    prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("credential")) {
      credential = prefs.getString("credential")!;
      if(credential.isNotEmpty) {
        isLogged = true;
        AccountViewModel().getToken();
        AccountViewModel().getAccount();
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

  static void appliedFilter(HashMap<String,bool> filterMap,List<Establishment> toFiltered){
    List<Establishment> filtered= [];
    for(Establishment establishment in toFiltered){
      for(GameTypeDto gameTypeDto in establishment.gameTypeDtoList){
        if(filterMap[gameTypeDto.gameType.value]!){
          filtered.add(establishment);
          break;
        }
      }
    }
    establishmentsFuture=Future.value(filtered);
  }

  static void resetEstablishmentsFuture(){
    establishmentsFuture=establishmentsOriginFuture;
  }

}
