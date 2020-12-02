import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/models.dart';

import 'action.dart';
import 'state.dart';

Reducer<HistoryState> buildReducer() {
  return asReducer(
    <Object, Reducer<HistoryState>>{
      HistoryAction.action: _onAction,
      HistoryAction.setCharges: _setCharges,
      HistoryAction.loading: _loading,
    },
  );
}

HistoryState _onAction(HistoryState state, Action action) {
  final HistoryState newState = state.clone();
  return newState;
}

HistoryState _setCharges(HistoryState state, Action action) {
  final StripeCharges _charges = action.payload;
  final HistoryState newState = state.clone();
  newState.charges = _charges;
  return newState;
}

HistoryState _loading(HistoryState state, Action action) {
  final bool _loading = action.payload ?? false;
  final HistoryState newState = state.clone();
  newState.loading = _loading;
  return newState;
}
