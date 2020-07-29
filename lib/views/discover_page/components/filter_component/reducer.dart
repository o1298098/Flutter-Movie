import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/sort_condition.dart';
import 'action.dart';
import 'state.dart';

Reducer<FilterState> buildReducer() {
  return asReducer(
    <Object, Reducer<FilterState>>{
      FilterAction.action: _onAction,
      FilterAction.sortChanged: _onSortChanged,
      FilterAction.updateGenres: _updateGenres,
      FilterAction.keywordschanged: _onKeyWordsChanged,
      FilterAction.mediaTypeChange: _mediaTypeChanged,
      FilterAction.dataSortChange: _dataSortChange,
    },
  );
}

FilterState _onAction(FilterState state, Action action) {
  final FilterState newState = state.clone();
  return newState;
}

FilterState _onSortChanged(FilterState state, Action action) {
  final SortCondition _sort = action.payload;
  final FilterState newState = state.clone();
  newState.selectedSort = _sort;
  return newState;
}

FilterState _updateGenres(FilterState state, Action action) {
  final List<SortCondition> _genres = action.payload;
  final FilterState newState = state.clone();
  newState.currentGenres = _genres;
  return newState;
}

FilterState _onKeyWordsChanged(FilterState state, Action action) {
  String s = action.payload ?? '';
  final FilterState newState = state.clone();
  newState.keywords = s;
  return newState;
}

FilterState _mediaTypeChanged(FilterState state, Action action) {
  final bool _isMovie = action.payload ?? false;
  final FilterState newState = state.clone();
  newState.isMovie = _isMovie;
  newState.currentGenres = _isMovie ? state.movieGenres : state.tvGenres;
  return newState;
}

FilterState _dataSortChange(FilterState state, Action action) {
  final bool _desc = action.payload;
  final FilterState newState = state.clone();
  newState.sortDesc = _desc;
  return newState;
}
