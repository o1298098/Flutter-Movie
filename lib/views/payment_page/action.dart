import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/braintree_transaction.dart';
import 'package:movie/models/models.dart';

enum PaymentPageAction {
  action,
  setTransactions,
  setCustomer,
  setCreditCards,
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

  static Action setCustomer(StripeCustomer customer) {
    return Action(PaymentPageAction.setCustomer, payload: customer);
  }

  static Action setCreditCards(StripeCreditCards cards) {
    return Action(PaymentPageAction.setCreditCards, payload: cards);
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

  static Action insertCreditCard(StripeCreditCard card) {
    return Action(PaymentPageAction.insertCreditCard, payload: card);
  }
}
