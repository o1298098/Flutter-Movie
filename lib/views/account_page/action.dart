import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/videolist.dart';

//TODO replace with your own action
enum AccountPageAction { action,login,init,logout,myListsTppped}

class AccountPageActionCreator {
  static Action onAction() {
    return const Action(AccountPageAction.action);
  }
  static Action onLogin() {
    return Action(AccountPageAction.login);
  }
  static Action onInit(String name,String avatar,bool islogin,int acountIdV3,String acountIdV4) {
    return Action(AccountPageAction.init,payload:[name,avatar,islogin,acountIdV3,acountIdV4]);
  }
  static Action onLogout() {
    return Action(AccountPageAction.logout);
  }
  static Action myListsTapped(String accountid) {
    return Action(AccountPageAction.myListsTppped,payload: accountid);
  }
}
