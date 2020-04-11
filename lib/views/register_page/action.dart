import 'package:fish_redux/fish_redux.dart';

enum RegisterPageAction {
  action,
  registerWithEmail,
}

class RegisterPageActionCreator {
  static Action onAction() {
    return const Action(RegisterPageAction.action);
  }

  static Action onRegisterWithEmail() {
    return const Action(RegisterPageAction.registerWithEmail);
  }
}
