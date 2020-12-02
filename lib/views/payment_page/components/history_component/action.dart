import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/braintree_transaction.dart';
import 'package:movie/models/models.dart';

enum HistoryAction {
  action,
  setTransactions,
  setCharges,
  loading,
}

class HistoryActionCreator {
  static Action onAction() {
    return const Action(HistoryAction.action);
  }

  static Action setTransactions(TransactionModel transactions) {
    return Action(HistoryAction.setTransactions, payload: transactions);
  }

  static Action setCharges(StripeCharges charges) {
    return Action(HistoryAction.setCharges, payload: charges);
  }

  static Action loading(bool loading) {
    return Action(HistoryAction.loading, payload: loading);
  }
}
