import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/braintree_creditcard.dart';
import 'package:movie/models/base_api_model/braintree_customer.dart';

import 'action.dart';
import 'state.dart';

Reducer<PaymentPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<PaymentPageState>>{
      PaymentPageAction.action: _onAction,
      PaymentPageAction.setTransactions: _setTransactions,
      PaymentPageAction.setCustomer: _setCustomer,
      PaymentPageAction.insertCreditCard: _insertCreditCard,
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

PaymentPageState _setCustomer(PaymentPageState state, Action action) {
  final BraintreeCustomer _customer = action.payload;
  final PaymentPageState newState = state.clone();
  newState.customer = _customer;
  newState.billingAddressState = newState.billingAddressState.clone()
    ..addresses = _customer.addresses;
  return newState;
}

PaymentPageState _insertCreditCard(PaymentPageState state, Action action) {
  CreditCard _card = action.payload;
  final PaymentPageState newState = state.clone();
  if (newState.customer?.creditCards != null)
    newState.customer.creditCards.insert(0, _card);
  return newState;
}
