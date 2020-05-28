import 'package:fish_redux/fish_redux.dart';

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
