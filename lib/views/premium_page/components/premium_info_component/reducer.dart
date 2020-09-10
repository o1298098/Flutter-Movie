import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PremiumInfoState> buildReducer() {
  return asReducer(
    <Object, Reducer<PremiumInfoState>>{
      PremiumInfoAction.action: _onAction,
    },
  );
}

PremiumInfoState _onAction(PremiumInfoState state, Action action) {
  final PremiumInfoState newState = state.clone();
  return newState;
}
