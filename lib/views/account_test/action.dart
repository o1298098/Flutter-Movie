import 'package:fish_redux/fish_redux.dart';

enum AccountAction { action }

class AccountActionCreator {
  static Action onAction() {
    return const Action(AccountAction.action);
  }
}
