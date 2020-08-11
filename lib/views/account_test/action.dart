import 'package:fish_redux/fish_redux.dart';

enum AccountAction { action, onTabBarTap, navigatorPush, showTip }

class AccountActionCreator {
  static Action onAction() {
    return const Action(AccountAction.action);
  }

  static Action onTabBarTap(int index) {
    return Action(AccountAction.onTabBarTap, payload: index);
  }

  static Action showTip(bool show) {
    return Action(AccountAction.showTip, payload: show);
  }

  static Action navigatorPush(String routeName, {Object arguments}) {
    return Action(AccountAction.navigatorPush, payload: [routeName, arguments]);
  }
}
