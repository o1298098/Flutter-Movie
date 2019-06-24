import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<FilterState> buildReducer() {
  return asReducer(
    <Object, Reducer<FilterState>>{
      FilterAction.action: _onAction,
      FilterAction.sortChanged:_onSortChanged,
      FilterAction.genresChanged: _onGenresChanged,
      FilterAction.keywordschanged:_onKeyWordsChanged
    },
  );
}

FilterState _onAction(FilterState state, Action action) {
  final FilterState newState = state.clone();
  return newState;
}
FilterState _onSortChanged(FilterState state, Action action) {
  bool i=action.payload??true;
  final FilterState newState = state.clone();
  newState.isMovie=i;
  return newState;
}
FilterState _onGenresChanged(FilterState state, Action action) {
  final FilterState newState = state.clone();
  return newState;
}

FilterState _onKeyWordsChanged(FilterState state, Action action) {
  String s=action.payload??'';
  final FilterState newState = state.clone();
  newState.keywords=s;
  return newState;
}
