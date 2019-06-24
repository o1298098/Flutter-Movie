import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SearchPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<SearchPageState>>{
      SearchPageAction.action: _onAction,
    },
  );
}

SearchPageState _onAction(SearchPageState state, Action action) {
  final SearchPageState newState = state.clone();
  return newState;
}
