import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/stripe_address.dart';

import 'action.dart';
import 'state.dart';

Reducer<BillingAddressState> buildReducer() {
  return asReducer(
    <Object, Reducer<BillingAddressState>>{
      BillingAddressAction.action: _onAction,
      BillingAddressAction.update: _onUpdate,
      BillingAddressAction.delete: _onDelete,
    },
  );
}

BillingAddressState _onAction(BillingAddressState state, Action action) {
  final BillingAddressState newState = state.clone();
  return newState;
}

BillingAddressState _onUpdate(BillingAddressState state, Action action) {
  final StripeAddress _address = action.payload;
  final BillingAddressState newState = state.clone();
  newState.address = _address;
  return newState;
}

BillingAddressState _onDelete(BillingAddressState state, Action action) {
  final BillingAddressState newState = state.clone();
  return newState;
}
