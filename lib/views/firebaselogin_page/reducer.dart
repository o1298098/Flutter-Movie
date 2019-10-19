import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<FirebaseLoginPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<FirebaseLoginPageState>>{
      FirebaseLoginPageAction.action: _onAction,
    },
  );
}

FirebaseLoginPageState _onAction(FirebaseLoginPageState state, Action action) {
  final FirebaseLoginPageState newState = state.clone();
  return newState;
}
