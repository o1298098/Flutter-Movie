import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum LoginPageAction {
  action,
  loginclicked,
  accoutChanged,
  pwdChanged,
  signUp,
  googleSignIn,
  facebookSignIn
}

class LoginPageActionCreator {
  static Action onAction() {
    return const Action(LoginPageAction.action);
  }

  static Action onLoginClicked() {
    return const Action(LoginPageAction.loginclicked);
  }

  static Action onAccountChange(String account) {
    return Action(LoginPageAction.accoutChanged, payload: account);
  }

  static Action onPwdChange(String pwd) {
    return Action(LoginPageAction.pwdChanged, payload: pwd);
  }

  static Action onSignUp() {
    return Action(LoginPageAction.signUp);
  }

  static Action onGoogleSignIn() {
    return Action(LoginPageAction.googleSignIn);
  }
}
