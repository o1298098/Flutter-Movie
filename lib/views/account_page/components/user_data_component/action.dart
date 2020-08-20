import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/account_info.dart';

enum UserDataAction { action, navigatorPush, setInfo }

class UserDataActionCreator {
  static Action onAction() {
    return const Action(UserDataAction.action);
  }

  static Action navigatorPush(String routeName, {Object arguments}) {
    return Action(UserDataAction.navigatorPush,
        payload: [routeName, arguments]);
  }

  static Action setInfo(AccountInfo info) {
    return Action(UserDataAction.setInfo, payload: info);
  }
}
