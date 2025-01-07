import 'package:carto/models/account.dart';

import '../services/account_service.dart';

class AccountViewModel{
  AccountService accountService = AccountService();

  Future<String?> createAccount(Account account){
    return accountService.createAccount(account);
  }

  void updateAccount(Account account){
    accountService.updateAccount(account);
  }

  void deleteAccount(){
    accountService.deleteAccount();
  }

  Future<bool> getCredentials(String usernameOrMail, String password){
    return accountService.getCredential(usernameOrMail, password);
  }

  Future<String> getToken(){
    return accountService.getToken();
  }

  void forgottenPassword(String email) {
    accountService.forgottenPassword(email);
  }

  Future<bool> logIn(String usernameOrMail, String password) {
    return accountService.logIn(usernameOrMail, password);
  }

  Future<String> checkEmailExists(String emailAddress) {
    return accountService.checkEmailExists(emailAddress);
  }

  Future<String> checkUsernameExists(String username) {
    return accountService.checkUsernameExists(username);
  }

  Future<Account> getAccount() {
    return accountService.getAccount();
  }


}