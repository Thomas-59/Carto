import 'package:carto/models/account.dart';
import 'package:dio/dio.dart';

import 'dart:convert';
import 'package:carto/models/account.dart';
import 'package:dio/dio.dart';

class AccountService {
  final Dio dio = Dio();
  final String basePath = "https://carto.onrender.com/account";

  void createAccount(Account account) async {
    await dio.post(basePath, data: account.toJson());
  }

  Future<Account?> getAccountByUsername(String username) async {
    var response = await dio.get("$basePath/by-username/$username");
    if (response.data != null) {
      return Account.fromJson(response.data);
    }

    return null;
  }

  Future<Account?> getAccountByEmailAddress(String emailAddress) async {
    var response = await dio.get("$basePath/by-email-address/$emailAddress");
    if (response.data != null) {
      return Account.fromJson(response.data);
    }

    return null;
  }
}
