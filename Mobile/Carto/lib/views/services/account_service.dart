import 'package:carto/models/account.dart';
import 'package:dio/dio.dart';

class AccountService {
  final Dio dio = Dio();

  void createAccount(Account account) async {
    // TODO : replace with render path
    await dio.post("https://localhost:8080/user", data: account.toJson());
  }
}