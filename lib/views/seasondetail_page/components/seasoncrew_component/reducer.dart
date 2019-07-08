import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SeasonCrewState> buildReducer() {
  return asReducer(
    <Object, Reducer<SeasonCrewState>>{
      SeasonCrewAction.action: _onAction,
    },
  );
}

SeasonCrewState _onAction(SeasonCrewState state, Action action) {
  final SeasonCrewState newState = state.clone();
  return newState;
}
