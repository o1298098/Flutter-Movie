import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<StartPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<StartPageState>>{
      StartPageAction.action: _onAction,
    },
  );
}

StartPageState _onAction(StartPageState state, Action action) {
  final StartPageState newState = state.clone();
  return newState;
}
