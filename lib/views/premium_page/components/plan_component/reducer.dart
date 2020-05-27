import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PlanState> buildReducer() {
  return asReducer(<Object, Reducer<PlanState>>{
    PlanAction.action: _onAction,
    PlanAction.loading: _loading,
  });
}

PlanState _onAction(PlanState state, Action action) {
  final PlanState newState = state.clone();
  return newState;
}

PlanState _loading(PlanState state, Action action) {
  final bool _loading = action.payload ?? false;
  final PlanState newState = state.clone();
  newState.loading = _loading;
  return newState;
}
