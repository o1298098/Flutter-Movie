import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<KeywordState> buildReducer() {
  return asReducer(
    <Object, Reducer<KeywordState>>{
      KeywordAction.action: _onAction,
    },
  );
}

KeywordState _onAction(KeywordState state, Action action) {
  final KeywordState newState = state.clone();
  return newState;
}
