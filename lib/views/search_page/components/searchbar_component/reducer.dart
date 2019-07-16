import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/models/searchresult.dart';

import 'action.dart';
import 'state.dart';

Reducer<SearchBarState> buildReducer() {
  return asReducer(
    <Object, Reducer<SearchBarState>>{
      SearchBarAction.action: _onAction,
      SearchBarAction.setSearchResult:_setSearchResult,
      SearchBarAction.setFocus:_setFocus
    },
  );
}

SearchBarState _onAction(SearchBarState state, Action action) {
  final SearchBarState newState = state.clone();
  return newState;
}
SearchBarState _setSearchResult(SearchBarState state, Action action) {
  final SearchResultModel model=action.payload??SearchResultModel.fromParams(results: List<SearchResult>());
  final SearchBarState newState = state.clone();
  newState.searchResultModel=model;
  return newState;
}

SearchBarState _setFocus(SearchBarState state, Action action) {
  final FocusNode focus=action.payload??FocusNode();
  final SearchBarState newState = state.clone();
  newState.focus=focus;
  return newState;
}
