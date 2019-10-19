import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum RegisterPageAction {
  action,
  registerWithEmail,
  nameTextChanged,
  emailTextChanged,
  pwdTextChanged
}

class RegisterPageActionCreator {
  static Action onAction() {
    return const Action(RegisterPageAction.action);
  }

  static Action onRegisterWithEmail() {
    return const Action(RegisterPageAction.registerWithEmail);
  }

  static Action onNameTextChanged(String t) {
    return Action(RegisterPageAction.nameTextChanged, payload: t);
  }

  static Action onEmailTextChanged(String t) {
    return Action(RegisterPageAction.emailTextChanged, payload: t);
  }

  static Action onPwdTextChanged(String t) {
    return Action(RegisterPageAction.pwdTextChanged, payload: t);
  }
}
