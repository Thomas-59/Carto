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

  Future<String> checkUsernameExists(String username) async {
    try {
      final response = await dio.get('$basePath/check-username/$username');

      if (response.statusCode == 200) {
        return 'Username is available';
      } else {
        return 'An error occurred';
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 409) {
        return 'Username already exists';
      }
      return 'An error occurred';
    }
  }

  Future<String> checkEmailExists(String email) async {
    try {
      final response = await dio.get('$basePath/check-email/$email');
      if (response.statusCode == 200) {
        return 'Email is available';
      } else {
        return 'An error occurred';
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 409) {
        return 'Email address already exists';
      }
      return 'An error occurred';
    }
  }
}
