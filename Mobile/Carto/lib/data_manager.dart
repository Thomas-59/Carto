import 'package:carto/views/services/establishment_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/establishment.dart';

class DataManager {
  static final DataManager _singleton = DataManager._internal();
  static bool isLogged = false;
  static String credential = "";
  static String token = "";

  static late Future<List<Establishment>> establishmentsFuture;
  static late SharedPreferences prefs;

  DataManager._internal();
  static Future<DataManager> getInstance() async {
    prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("credential")) {
      credential = prefs.getString("credential")!;
    }

    final EstablishmentService establishmentService = EstablishmentService();
    establishmentsFuture = establishmentService.getAllEstablishment();
    return _singleton;
  }
}