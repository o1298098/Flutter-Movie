import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SwiperState> buildReducer() {
  return asReducer(
    <Object, Reducer<SwiperState>>{
      SwiperAction.action: _onAction,
    },
  );
}

SwiperState _onAction(SwiperState state, Action action) {
  final SwiperState newState = state.clone();
  return newState;
}
