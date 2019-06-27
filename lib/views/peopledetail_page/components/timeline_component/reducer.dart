import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TimeLineState> buildReducer() {
  return asReducer(
    <Object, Reducer<TimeLineState>>{
      TimeLineAction.action: _onAction,
      TimeLineAction.actingChanged:_onActingChanged,
    },
  );
}

TimeLineState _onAction(TimeLineState state, Action action) {
  final TimeLineState newState = state.clone();
  return newState;
}
TimeLineState _onActingChanged(TimeLineState state, Action action) {
  final b=action.payload??true;
  final TimeLineState newState = state.clone();
  newState.showmovie=b;
  return newState;
}
