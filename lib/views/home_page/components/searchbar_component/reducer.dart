import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SearchBarState> buildReducer() {
  return asReducer(
    <Object, Reducer<SearchBarState>>{
      SearchBarAction.action: _onAction,
    },
  );
}

SearchBarState _onAction(SearchBarState state, Action action) {
  final SearchBarState newState = state.clone();
  return newState;
}
