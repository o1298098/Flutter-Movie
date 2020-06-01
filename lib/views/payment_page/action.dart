import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/braintree_creditcard.dart';
import 'package:movie/models/base_api_model/braintree_customer.dart';
import 'package:movie/models/base_api_model/braintree_transaction.dart';

enum PaymentPageAction {
  action,
  setTransactions,
  setCustomer,
  showHistory,
  showBillingAddress,
  createCard,
  insertCreditCard,
}

class PaymentPageActionCreator {
  static Action onAction() {
    return const Action(PaymentPageAction.action);
  }

  static Action setTransactions(TransactionModel transactions) {
    return Action(PaymentPageAction.setTransactions, payload: transactions);
  }

  static Action setCustomer(BraintreeCustomer customer) {
    return Action(PaymentPageAction.setCustomer, payload: customer);
  }

  static Action showHistory() {
    return const Action(PaymentPageAction.showHistory);
  }

  static Action showBillingAddress() {
    return const Action(PaymentPageAction.showBillingAddress);
  }

  static Action createCard() {
    return const Action(PaymentPageAction.createCard);
  }

  static Action insertCreditCard(CreditCard card) {
    return Action(PaymentPageAction.insertCreditCard, payload: card);
  }
}
