import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SeasonCastState> buildReducer() {
  return asReducer(
    <Object, Reducer<SeasonCastState>>{
      SeasonCastAction.action: _onAction,
      SeasonCastAction.buttonClicked:_onButtonCilcked
    },
  );
}

SeasonCastState _onAction(SeasonCastState state, Action action) {
  final SeasonCastState newState = state.clone();
  return newState;
}
SeasonCastState _onButtonCilcked(SeasonCastState state, Action action) {
  final SeasonCastState newState = state.clone();
  newState.showcount=state.showcount ==state.castData.length?6:state.castData.length;
  return newState;
}
