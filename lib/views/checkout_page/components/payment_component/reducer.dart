import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/models.dart';

import 'action.dart';
import 'state.dart';

Reducer<PaymentState> buildReducer() {
  return asReducer(
    <Object, Reducer<PaymentState>>{
      PaymentAction.action: _onAction,
      PaymentAction.updateNatviePayValue: _updateNatviePayValue,
      PaymentAction.updateSelectedCard: _updateSelectedCard
    },
  );
}

PaymentState _onAction(PaymentState state, Action action) {
  final PaymentState newState = state.clone();
  return newState;
}

PaymentState _updateNatviePayValue(PaymentState state, Action action) {
  final bool _isNativePay = action.payload ?? true;
  final PaymentState newState = state.clone();
  newState.nativePay = _isNativePay;
  return newState;
}

PaymentState _updateSelectedCard(PaymentState state, Action action) {
  final StripeCreditCard _card = action.payload;
  final PaymentState newState = state.clone();
  newState.selectedCard = _card;
  return newState;
}
