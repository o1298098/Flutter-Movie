import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PlanState> buildReducer() {
  return asReducer(
    <Object, Reducer<PlanState>>{
      PlanAction.action: _onAction,
    },
  );
}

PlanState _onAction(PlanState state, Action action) {
  final PlanState newState = state.clone();
  return newState;
}
