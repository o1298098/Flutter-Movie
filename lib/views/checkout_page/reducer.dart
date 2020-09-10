import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_braintree/flutter_braintree.dart';

import 'action.dart';
import 'state.dart';

Reducer<CheckOutPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<CheckOutPageState>>{
      CheckOutPageAction.action: _onAction,
      CheckOutPageAction.updatePaymentMethod: _updatePaymentMethod,
      CheckOutPageAction.loading: _loading,
    },
  );
}

CheckOutPageState _onAction(CheckOutPageState state, Action action) {
  final CheckOutPageState newState = state.clone();
  return newState;
}

CheckOutPageState _updatePaymentMethod(CheckOutPageState state, Action action) {
  final BraintreeDropInResult _braintreeDropInResult = action.payload;
  final CheckOutPageState newState = state.clone();
  newState.braintreeDropInResult = _braintreeDropInResult;
  return newState;
}

CheckOutPageState _loading(CheckOutPageState state, Action action) {
  final bool _loading = action.payload ?? false;
  final CheckOutPageState newState = state.clone();
  newState.loading = _loading;
  return newState;
}
