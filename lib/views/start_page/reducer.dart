import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<StartPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<StartPageState>>{
      StartPageAction.action: _onAction,
      StartPageAction.setIsFirst: _setIsFirst,
    },
  );
}

StartPageState _onAction(StartPageState state, Action action) {
  final StartPageState newState = state.clone();
  return newState;
}

StartPageState _setIsFirst(StartPageState state, Action action) {
  final bool _isFirst = action.payload;
  final StartPageState newState = state.clone();
  newState.isFirstTime = _isFirst;
  return newState;
}
