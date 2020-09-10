import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/braintree_transaction.dart';

import 'action.dart';
import 'state.dart';

Reducer<HistoryState> buildReducer() {
  return asReducer(
    <Object, Reducer<HistoryState>>{
      HistoryAction.action: _onAction,
      HistoryAction.setTransactions: _setTransactions,
      HistoryAction.loading: _loading,
    },
  );
}

HistoryState _onAction(HistoryState state, Action action) {
  final HistoryState newState = state.clone();
  return newState;
}

HistoryState _setTransactions(HistoryState state, Action action) {
  final TransactionModel _transasctions = action.payload;
  final HistoryState newState = state.clone();
  newState.transactions = _transasctions;
  return newState;
}

HistoryState _loading(HistoryState state, Action action) {
  final bool _loading = action.payload ?? false;
  final HistoryState newState = state.clone();
  newState.loading = _loading;
  return newState;
}
