import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/braintree_transaction.dart';

import 'action.dart';
import 'state.dart';

Reducer<BillingAddressState> buildReducer() {
  return asReducer(
    <Object, Reducer<BillingAddressState>>{
      BillingAddressAction.action: _onAction,
    },
  );
}

BillingAddressState _onAction(BillingAddressState state, Action action) {
  final BillingAddressState newState = state.clone();
  return newState;
}
