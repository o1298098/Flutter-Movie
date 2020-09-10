import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<EpisodesState> buildReducer() {
  return asReducer(
    <Object, Reducer<EpisodesState>>{
      EpisodesAction.action: _onAction,
      EpisodesAction.expansionOpen: _onExpansionOpen
    },
  );
}

EpisodesState _onAction(EpisodesState state, Action action) {
  final EpisodesState newState = state.clone();
  return newState;
}

EpisodesState _onExpansionOpen(EpisodesState state, Action action) {
  final EpisodesState newState = state.clone();
  return newState;
}
