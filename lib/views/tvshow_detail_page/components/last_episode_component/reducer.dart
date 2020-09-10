import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<LastEpisodeState> buildReducer() {
  return asReducer(
    <Object, Reducer<LastEpisodeState>>{
      LastEpisodeAction.action: _onAction,
    },
  );
}

LastEpisodeState _onAction(LastEpisodeState state, Action action) {
  final LastEpisodeState newState = state.clone();
  return newState;
}
