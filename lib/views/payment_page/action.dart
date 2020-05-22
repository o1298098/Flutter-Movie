import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/braintree_customer.dart';
import 'package:movie/models/base_api_model/braintree_transaction.dart';

enum PaymentPageAction { action, setTransactions, setCustomer }

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
}
