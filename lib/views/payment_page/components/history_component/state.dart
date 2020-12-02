import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/models/base_api_model/braintree_transaction.dart';
import 'package:movie/models/models.dart';
import 'package:movie/views/payment_page/state.dart';

class HistoryState implements Cloneable<HistoryState> {
  String stripeId;
  TransactionModel transactions;
  StripeCharges charges;
  AppUser user;
  bool loading;
  @override
  HistoryState clone() {
    return HistoryState()
      ..stripeId = stripeId
      ..charges = charges
      ..transactions = transactions
      ..loading = loading
      ..user = user;
  }
}

class HistoryConnector extends ConnOp<PaymentPageState, HistoryState> {
  @override
  HistoryState get(PaymentPageState state) {
    HistoryState mstate = HistoryState();
    mstate.transactions = state.transactions;
    mstate.stripeId = state.customer?.id;
    mstate.charges = state.charges;
    mstate.user = state.user;
    mstate.loading = state.loading;
    return mstate;
  }

  @override
  void set(PaymentPageState state, HistoryState subState) {
    state.transactions = subState.transactions;
    state.charges = subState.charges;
    state.loading = subState.loading;
  }
}
