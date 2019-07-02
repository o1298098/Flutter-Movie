import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/videolist.dart';

//TODO replace with your own action
enum AccountPageAction { action,login,init,logout}

class AccountPageActionCreator {
  static Action onAction() {
    return const Action(AccountPageAction.action);
  }
  static Action onLogin() {
    return Action(AccountPageAction.login);
  }
  static Action onInit(String name,String avatar,bool islogin) {
    return Action(AccountPageAction.init,payload:[name,avatar,islogin]);
  }
  static Action onLogout() {
    return Action(AccountPageAction.logout);
  }
}
