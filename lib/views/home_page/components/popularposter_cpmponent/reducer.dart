import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PopularPosterState> buildReducer() {
  return asReducer(
    <Object, Reducer<PopularPosterState>>{
      PopularPosterAction.action: _onAction,
    },
  );
}

PopularPosterState _onAction(PopularPosterState state, Action action) {
  final PopularPosterState newState = state.clone();
  return newState;
}
