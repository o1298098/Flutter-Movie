import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TitleState> buildReducer() {
  return asReducer(
    <Object, Reducer<TitleState>>{
      TitleAction.action: _onAction,
    },
  );
}

TitleState _onAction(TitleState state, Action action) {
  final TitleState newState = state.clone();
  return newState;
}
