import 'package:carto/models/account.dart';
import 'package:carto/views/services/account_service.dart';

class AccountViewModel{
  AccountService accountService = AccountService();

  void createAccount(Account account){
    accountService.createAccount(account);
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

  void getToken(){
    accountService.getToken();
  }


}