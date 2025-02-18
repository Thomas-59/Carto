import 'dart:convert';

import 'package:carto/Exceptions/bad_credential_exception.dart';
import 'package:carto/data_manager.dart';
import 'package:carto/enum/query_enum.dart';
import 'package:carto/models/account.dart';
import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';

/// The service to manage a account
class AccountService {
  /// The dio service
  final Dio dio = Dio();
  /// The base path to the service
  final String basePath = "https://carto.onrender.com/account";

  /// Add an account in the data base
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

  /// Check if a user name already exists in the data base
  Future<String> checkUsernameExists(String username) async {
    try {
      final response = await dio.get('$basePath/check-username/$username');

      if (response.statusCode == 200) {
        return 'Username is available';
      } else {
        return 'An error occurred';
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        return 'Username already exists';
      }
      return 'An error occurred';
    }
  }

  /// Check if the email is already linked to another account in the data base
  Future<String> checkEmailExists(String email) async {
    try {
      final response = await dio.get('$basePath/check-email/$email');
      if (response.statusCode == 200) {
        return 'Email is available';
      } else {
        return 'An error occurred';
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        return 'Email address already exists';
      }
      return 'An error occurred';
    }
  }

  /// Update the user account in the data base
  void updateAccount(Account account) async {
    Response<dynamic> response = queryUseToken(
        type: QueryEnum.put,
        path: basePath,
        data: account.toJson()
    ) as Response;
    DataManager.account = response.data;
  }

  /// Delete the user account of the data base
  void deleteAccount() async {
    queryUseToken(
        type: QueryEnum.delete,
        path: basePath,
    );
    disconnect();
  }

  /// Give a token who contain the credential of the user who can be used to obtain the functional token
  Future<bool> getCredential(String usernameOrMail, String password) async {
    Dio tmpDio = Dio();
    String basicAuth =
        "Basic ${base64Encode(utf8.encode("$usernameOrMail:$password"))}";
    tmpDio.options.headers['Authorization'] = basicAuth;
    try {
      Response<dynamic> response = await tmpDio.get("$basePath/log");
      DataManager.credential = response.data;
      DataManager.isLogged = true;
    } on DioException {
      return false;
    }
    return true;
  }

  /// Give the functional token of the user
  Future<String> getToken() async {
    if(!DataManager.isLogged) throw BadCredentialException();

    Dio tmpDio = Dio();
    tmpDio.options.headers['Authorization'] = DataManager.credential;
    try {
      Response<dynamic> response =  await tmpDio.get("$basePath/token");
      DataManager.token = response.data;
      return response.data;
    } on DioException { //bad credential
      disconnect();
      throw BadCredentialException();
    }
  }

  /// Give the data of the logged user
  Future<Account> getAccount() async {
    Response<dynamic> response = await queryUseToken(
        type: QueryEnum.get,
        path: basePath
    );
    Account account = Account.fromJson(response.data);
    DataManager.account = account;
    return account;
  }

  /// Log the user in the app
  Future<bool> logIn(String usernameOrMail, String password) async {
    bool success = await getCredential(usernameOrMail, password);
    if(success) {
      await getToken();
      getAccount();
    }
    return success;
  }

  /// Send query who need the functional token and refresh the token if needed
  Future<Response<dynamic>> queryUseToken({
    required QueryEnum type,
    required String path,
    var data
  }) async {
    try {
      return _queryUseToken(type: type, path: path, data: data);
    } on DioException { //expired token
      await getToken();
      return _queryUseToken(type: type, path: path, data: data);
    }
  }


  /// Send query who need the functional token
  Future<Response<dynamic>> _queryUseToken({
    required QueryEnum type,
    required String path,
    var data
  }) async {
    String token = DataManager.token;
    dio.options.headers['Authorization'] = token;
    if(type == QueryEnum.post) {
      return await dio.post(path, data: data);
    } else if(type == QueryEnum.put) {
      return await dio.put(path, data: data);
    } else if(type == QueryEnum.delete) {
      return await dio.delete(path, data: data);
    } else {
      return await dio.get(path, data: data);
    }
  }

  /// Disconnect the user from the app
  void disconnect() {
    DataManager.token = "";
    DataManager.credential = "";
    DataManager.isLogged = false;
    DataManager.account = null;
    DataManager.prefs.setString("credential", "");
  }

  /// Ask the server to send a forgotten password if the email is linked to an account
  void forgottenPassword(String email) {
    dio.put("$basePath/forgottenPassword/$email");
  }
}
