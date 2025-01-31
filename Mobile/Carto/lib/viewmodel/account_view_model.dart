import 'package:carto/models/account.dart';

import '../services/account_service.dart';

/// The viewModel of the service to manage an account
class AccountViewModel {
  /// The instance of the service who manage an account
  AccountService accountService = AccountService();

  /// Add an account in the data base
  Future<String?> createAccount(Account account) {
    return accountService.createAccount(account);
  }

  /// Update the user account in the data base
  void updateAccount(Account account) {
    accountService.updateAccount(account);
  }

  /// Delete the user account of the data base
  void deleteAccount() {
    accountService.deleteAccount();
  }

  /// Give a token who contain the credential of the user who can be used to obtain the functional token
  Future<bool> getCredentials(String usernameOrMail, String password) {
    return accountService.getCredential(usernameOrMail, password);
  }

  /// Give the functional token of the user
  Future<String> getToken() {
    return accountService.getToken();
  }

  /// Ask the server to send a forgotten password if the email is linked to an account
  void forgottenPassword(String email) {
    accountService.forgottenPassword(email);
  }

  /// Log the user in the app
  Future<bool> logIn(String usernameOrMail, String password) {
    return accountService.logIn(usernameOrMail, password);
  }

  /// Check if the email is already linked to another account in the data base
  Future<String> checkEmailExists(String emailAddress) {
    return accountService.checkEmailExists(emailAddress);
  }

  /// Check if a user name already exists in the data base
  Future<String> checkUsernameExists(String username) {
    return accountService.checkUsernameExists(username);
  }

  /// Give the data of the logged user
  Future<Account> getAccount() {
    return accountService.getAccount();
  }
}