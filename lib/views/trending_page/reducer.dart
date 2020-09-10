import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/search_result.dart';

import 'action.dart';
import 'state.dart';

Reducer<TrendingPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<TrendingPageState>>{
      TrendingPageAction.action: _onAction,
      TrendingPageAction.updateList: _onUpdateList,
      TrendingPageAction.loadMore: _loadMore,
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

TrendingPageState _loadMore(TrendingPageState state, Action action) {
  final SearchResultModel _model = action.payload;
  final TrendingPageState newState = state.clone();
  if (_model != null) {
    newState.trending.results.addAll(_model.results);
    newState.trending.page = _model.page;
  }
  return newState;
}
