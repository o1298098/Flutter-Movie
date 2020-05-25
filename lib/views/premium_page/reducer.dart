import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/braintree_subscription.dart';

import 'action.dart';
import 'state.dart';

Reducer<PremiumPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<PremiumPageState>>{
      PremiumPageAction.action: _onAction,
      PremiumPageAction.setSubscription: _setSubscription,
      PremiumPageAction.loading: _loading,
    },
  );
}

PremiumPageState _onAction(PremiumPageState state, Action action) {
  final PremiumPageState newState = state.clone();
  return newState;
}

PremiumPageState _setSubscription(PremiumPageState state, Action action) {
  BraintreeSubscription _subscription = action.payload;
  final PremiumPageState newState = state.clone();
  newState.subscription = _subscription;
  return newState;
}

PremiumPageState _loading(PremiumPageState state, Action action) {
  final bool _loading = action.payload ?? false;
  final PremiumPageState newState = state.clone();
  newState.loading = _loading;
  return newState;
}
