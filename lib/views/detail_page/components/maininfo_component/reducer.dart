import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MainInfoState> buildReducer() {
  return asReducer(
    <Object, Reducer<MainInfoState>>{
      MainInfoAction.action: _onAction,
    },
  );
}

MainInfoState _onAction(MainInfoState state, Action action) {
  final MainInfoState newState = state.clone();
  return newState;
}
