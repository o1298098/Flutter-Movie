import 'package:fish_redux/fish_redux.dart';

enum AccountAction { action, onTabBarTap }

class AccountActionCreator {
  static Action onAction() {
    return const Action(AccountAction.action);
  }

  static Action onTabBarTap(int index) {
    return Action(AccountAction.onTabBarTap, payload: index);
  }
}
