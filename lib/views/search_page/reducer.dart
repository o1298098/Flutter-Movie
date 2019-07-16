
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:movie/models/searchresult.dart';

import 'action.dart';
import 'state.dart';

Reducer<SearchPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<SearchPageState>>{
      SearchPageAction.action: _onAction,
      SearchPageAction.setSearchResult: _setSearchResult,
      SearchPageAction.setGlobalkey:_setGlobalkey
    },
  );
}

SearchPageState _onAction(SearchPageState state, Action action) {
  final SearchPageState newState = state.clone();
  return newState;
}

SearchPageState _setSearchResult(SearchPageState state, Action action) {
  SearchResultModel model = action.payload ??
      SearchResultModel.fromParams(results: List<SearchResult>());
  final SearchPageState newState = state.clone();
    newState.searchResultModel = model;
  return newState;
}
SearchPageState _setGlobalkey(SearchPageState state, Action action) {
  final SearchPageState newState = state.clone();
  return newState;
}
