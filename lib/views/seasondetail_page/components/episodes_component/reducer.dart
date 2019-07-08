import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/seasondetail.dart';

import 'action.dart';
import 'state.dart';

Reducer<EpisodesState> buildReducer() {
  return asReducer(
    <Object, Reducer<EpisodesState>>{
      EpisodesAction.action: _onAction,
      EpisodesAction.expansionOpen:_onExpansionOpen
    },
  );
}

EpisodesState _onAction(EpisodesState state, Action action) {
  final EpisodesState newState = state.clone();
  return newState;
}

EpisodesState _onExpansionOpen(EpisodesState state, Action action) {
 final int index=action.payload[0]??0;
 final bool opened=action.payload[1];
  final EpisodesState newState = state.clone();
  newState.episodes[index].expansionPanelOpened=opened;
  return newState;
}
