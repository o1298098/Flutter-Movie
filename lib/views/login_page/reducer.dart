import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<LoginPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<LoginPageState>>{
      LoginPageAction.action: _onAction,
      LoginPageAction.switchLoginMode: _switchLoginMode,
      LoginPageAction.countryCodeChange: _onCountryCodeChange,
    },
  );
}

LoginPageState _onAction(LoginPageState state, Action action) {
  final LoginPageState newState = state.clone();
  return newState;
}

LoginPageState _switchLoginMode(LoginPageState state, Action action) {
  final LoginPageState newState = state.clone();
  newState.emailLogin = !state.emailLogin;
  return newState;
}

LoginPageState _onCountryCodeChange(LoginPageState state, Action action) {
  final String _code = action.payload;
  final LoginPageState newState = state.clone();
  newState.countryCode = _code;
  return newState;
}
