import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/transaction.dart';

enum PaymentPageAction { action, setTransactions }

class PaymentPageActionCreator {
  static Action onAction() {
    return const Action(PaymentPageAction.action);
  }

  static Action setTransactions(TransactionModel transactions) {
    return Action(PaymentPageAction.setTransactions, payload: transactions);
  }
}
