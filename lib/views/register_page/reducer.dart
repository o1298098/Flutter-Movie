import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<RegisterPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<RegisterPageState>>{
      RegisterPageAction.action: _onAction,
      RegisterPageAction.nameTextChanged: _onNameTextChanged,
      RegisterPageAction.emailTextChanged: _onEmailTextChanged,
      RegisterPageAction.pwdTextChanged: _onPwdTextChanged,
    },
  );
}

RegisterPageState _onAction(RegisterPageState state, Action action) {
  final RegisterPageState newState = state.clone();
  return newState;
}

RegisterPageState _onNameTextChanged(RegisterPageState state, Action action) {
  final String text = action.payload ?? '';
  final RegisterPageState newState = state.clone();
  newState.name = text;
  return newState;
}

RegisterPageState _onEmailTextChanged(RegisterPageState state, Action action) {
  final String text = action.payload ?? '';
  final RegisterPageState newState = state.clone();
  newState.emailAddress = text;
  return newState;
}

RegisterPageState _onPwdTextChanged(RegisterPageState state, Action action) {
  final String text = action.payload ?? '';
  final RegisterPageState newState = state.clone();
  newState.password = text;
  return newState;
}
