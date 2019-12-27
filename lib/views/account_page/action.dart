import 'package:fish_redux/fish_redux.dart';

enum AccountPageAction {
  action,
  login,
  init,
  logout,
  navigatorPush,
  settingCellTapped,
  themeChanged
}

class AccountPageActionCreator {
  static Action onAction() {
    return const Action(AccountPageAction.action);
  }

  static Action onLogin() {
    return Action(AccountPageAction.login);
  }

  static Action onInit(String name, String avatar, bool islogin) {
    return Action(AccountPageAction.init, payload: [name, avatar, islogin]);
  }

  static Action onLogout() {
    return Action(AccountPageAction.logout);
  }

  static Action navigatorPush(String routeName, {Object arguments}) {
    return Action(AccountPageAction.navigatorPush,
        payload: [routeName, arguments]);
  }

  static Action themeChange() {
    return const Action(AccountPageAction.themeChanged);
  }

  static Action settingCellTapped() {
    return const Action(AccountPageAction.settingCellTapped);
  }
}
