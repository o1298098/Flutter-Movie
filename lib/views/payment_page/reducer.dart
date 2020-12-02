import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/models.dart';

import 'action.dart';
import 'state.dart';

Reducer<PaymentPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<PaymentPageState>>{
      PaymentPageAction.action: _onAction,
      PaymentPageAction.setTransactions: _setTransactions,
      PaymentPageAction.setCustomer: _setCustomer,
      PaymentPageAction.setCreditCards: _setCreditCards,
      PaymentPageAction.insertCreditCard: _insertCreditCard,
    },
  );
}

PaymentPageState _onAction(PaymentPageState state, Action action) {
  final PaymentPageState newState = state.clone();
  return newState;
}

PaymentPageState _setCreditCards(PaymentPageState state, Action action) {
  final StripeCreditCards _cards = action.payload;
  final PaymentPageState newState = state.clone();
  newState.cards = _cards.list ?? [];
  return newState;
}

PaymentPageState _setTransactions(PaymentPageState state, Action action) {
  final _transactions = action.payload;
  final PaymentPageState newState = state.clone();
  newState.transactions = _transactions;
  return newState;
}

PaymentPageState _setCustomer(PaymentPageState state, Action action) {
  final StripeCustomer _customer = action.payload;
  final PaymentPageState newState = state.clone();
  newState.customer = _customer;
  newState.billingAddressState.address = _customer.address;
  newState.billingAddressState.customerId = _customer.id;
  newState.billingAddressState.customerName = _customer.name;
  return newState;
}

PaymentPageState _insertCreditCard(PaymentPageState state, Action action) {
  StripeCreditCard _card = action.payload;
  final PaymentPageState newState = state.clone();
  if (newState.cards != null) newState.cards.insert(0, _card);
  return newState;
}
