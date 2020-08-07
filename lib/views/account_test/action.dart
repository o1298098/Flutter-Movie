import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum AccountAction { action }

class AccountActionCreator {
  static Action onAction() {
    return const Action(AccountAction.action);
  }
}
