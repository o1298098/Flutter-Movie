import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum AccountPageAction { action,login }

class AccountPageActionCreator {
  static Action onAction() {
    return const Action(AccountPageAction.action);
  }
   static Action onLogin() {
    return Action(AccountPageAction.login);
  }
}
