import 'package:carto/models/account.dart';
import 'package:dio/dio.dart';

import 'dart:convert';
import 'package:flutter/foundation.dart';

class AccountService {
  final Dio dio = Dio();
  final String basePath = "https://carto.onrender.com/account";

  Future<String?> createAccount(Account account) async {
    try {
      if (account.role == Role.manager && account.managerInformation == null) {
        if (kDebugMode) {
          print('Informations du manager manquantes pour le rôle MANAGER.');
        }
        return null;
      }

      var response = await dio.post(basePath, data: account.toJson());

      if (response.statusCode == 201) {
        final responseData = response.data;
        if (responseData is int) {
          return responseData.toString();
        } else if (responseData is Map<String, dynamic>) {
          return responseData['id'];
        } else {
          if (kDebugMode) {
            print('Réponse inattendue : $responseData');
          }
          return null;
        }
      } else {
        if (kDebugMode) {
          print('Erreur de création de compte : ${response.statusCode}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erreur réseau ou API : $e');
      }
      return null;
    }
  }

  Future<Account?> getAccountByUsername(String username) async {
    try {
      var response = await dio.get("$basePath/by-username/$username");

      if (response.data != null) {
        if (response.data is String) {
          final Map<String, dynamic> responseData = json.decode(response.data);
          return Account.fromJson(responseData);
        } else if (response.data is Map<String, dynamic>) {
          return Account.fromJson(response.data);
        } else {
          if (kDebugMode) {
            print('Réponse inattendue : ${response.data}');
          }
          return null;
        }
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Erreur réseau ou API : $e');
      }
      return null;
    }
  }

  Future<Account?> getAccountByEmailAddress(String emailAddress) async {
    try {
      var response = await dio.get("$basePath/by-email-address/$emailAddress");

      if (response.data != null) {
        if (response.data is String) {
          final Map<String, dynamic> responseData = json.decode(response.data);
          return Account.fromJson(responseData);
        } else if (response.data is Map<String, dynamic>) {
          return Account.fromJson(response.data);
        } else {
          if (kDebugMode) {
            print('Réponse inattendue : ${response.data}');
          }
          return null;
        }
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Erreur réseau ou API : $e');
      }
      return null;
    }
  }
}
