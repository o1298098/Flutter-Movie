import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PremiumPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<PremiumPageState>>{
      PremiumPageAction.action: _onAction,
    },
  );
}

PremiumPageState _onAction(PremiumPageState state, Action action) {
  final PremiumPageState newState = state.clone();
  return newState;
}
