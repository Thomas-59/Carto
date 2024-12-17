import 'dart:convert';

import 'package:carto/Exceptions/bad_credential_exception.dart';
import 'package:carto/data_manager.dart';
import 'package:carto/enum/query_enum.dart';
import 'package:carto/models/account.dart';
import 'package:dio/dio.dart';

class AccountService {
  final Dio dio = Dio();

  void createAccount(Account account) async {

    await dio.post("https://localhost:8080/user", data: account.toJson());
  }

  void updateAccount(Account account) async {
    Response<dynamic> response = queryUseToken(
        type: QueryEnum.put,
        path: "https://localhost:8080/user",
        data: account.toJson()
    ) as Response;
    DataManager.account = response.data;
  }

  void deleteAccount() async {
    queryUseToken(
        type: QueryEnum.delete,
        path: "https://localhost:8080/user",
    );
    disconnect();
  }

  Future<bool> getCredential(String usernameOrMail, String password) async {
    Dio tmpDio = Dio();
    String basicAuth =
        "Basic ${base64Encode(utf8.encode("$usernameOrMail:$password"))}";
    tmpDio.options.headers['Authorization'] = basicAuth;
    try {
      Response<dynamic> response = await tmpDio.get(
          "https://localhost:8080/user/log");
      DataManager.credential = response.data;
      DataManager.isLogged = true;
      getToken();
    } on DioException {
      return false;
    }
    return true;
  }

  void getToken() async {
    if(!DataManager.isLogged) throw BadCredentialException();

    Dio tmpDio = Dio();
    tmpDio.options.headers['Authorization'] = DataManager.credential;
    try {
      Response<dynamic> response =  await dio.get(
          "https://localhost:8080/user/token");
      DataManager.token = response.data;
    } on DioException { //bad credential
      disconnect();
      throw BadCredentialException();
    }
  }

  Future<Response<dynamic>> queryUseToken({
    required QueryEnum type,
    required String path,
    var data
  }) async {
    try {
      return _queryUseToken(type: type, path: path, data: data);
    } on DioException { //expired token
      getToken();
      return _queryUseToken(type: type, path: path, data: data);
    }
  }

  Future<Response<dynamic>> _queryUseToken({
    required QueryEnum type,
    required String path,
    var data
  }) async {
    dio.options.headers['Authorization'] = DataManager.token;
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

  void disconnect() {
    DataManager.token = "";
    DataManager.credential = "";
    DataManager.isLogged = false;
    DataManager.account = null;
    DataManager.prefs.setString("credential", "");
  }
}