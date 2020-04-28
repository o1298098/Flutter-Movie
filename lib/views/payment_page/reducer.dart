import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PaymentPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<PaymentPageState>>{
      PaymentPageAction.action: _onAction,
      PaymentPageAction.setTransactions: _setTransactions
    },
  );
}

PaymentPageState _onAction(PaymentPageState state, Action action) {
  final PaymentPageState newState = state.clone();
  return newState;
}

PaymentPageState _setTransactions(PaymentPageState state, Action action) {
  final _transactions = action.payload;
  final PaymentPageState newState = state.clone();
  newState.transactions = _transactions;
  return newState;
}
