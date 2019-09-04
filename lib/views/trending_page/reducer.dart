import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TrendingPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<TrendingPageState>>{
      TrendingPageAction.action: _onAction,
      TrendingPageAction.updateList: _onUpdateList
    },
  );
}

TrendingPageState _onAction(TrendingPageState state, Action action) {
  final TrendingPageState newState = state.clone();
  return newState;
}

TrendingPageState _onUpdateList(TrendingPageState state, Action action) {
  final TrendingPageState newState = state.clone();
  newState.trending = action.payload;
  return newState;
}
