import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PopularPosterState> buildReducer() {
  return asReducer(
    <Object, Reducer<PopularPosterState>>{
      PopularPosterAction.action: _onAction,
      PopularPosterAction.popularFilterChanged: _onPopularFilterChanged,
    },
  );
}

PopularPosterState _onAction(PopularPosterState state, Action action) {
  final PopularPosterState newState = state.clone();
  return newState;
}

PopularPosterState _onPopularFilterChanged(
    PopularPosterState state, Action action) {
  final bool e = action.payload ?? true;
  final PopularPosterState newState = state.clone();
  newState.showmovie = e;
  return newState;
}
