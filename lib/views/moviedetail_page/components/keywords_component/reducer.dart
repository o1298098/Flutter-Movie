import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<KeyWordsState> buildReducer() {
  return asReducer(
    <Object, Reducer<KeyWordsState>>{
      KeyWordsAction.action: _onAction,
    },
  );
}

KeyWordsState _onAction(KeyWordsState state, Action action) {
  final KeyWordsState newState = state.clone();
  return newState;
}
