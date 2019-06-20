import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<LoginPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<LoginPageState>>{
      LoginPageAction.action: _onAction,
      LoginPageAction.accoutChanged:_onAccountChanged,
      LoginPageAction.pwdChanged:_onPwdChanged
    },
  );
}

LoginPageState _onAction(LoginPageState state, Action action) {
  final LoginPageState newState = state.clone();
  return newState;
}
LoginPageState _onAccountChanged(LoginPageState state, Action action) {
  String account=action.payload??'';
  final LoginPageState newState = state.clone();
  newState.account=account;
  return newState;
}
LoginPageState _onPwdChanged(LoginPageState state, Action action) {
  String pwd=action.payload??'';
  final LoginPageState newState = state.clone();
  newState.pwd=pwd;
  return newState;
}
