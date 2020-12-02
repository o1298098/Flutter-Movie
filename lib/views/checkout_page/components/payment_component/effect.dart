import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/api/base_api.dart';

import 'action.dart';
import 'state.dart';

Effect<PaymentState> buildEffect() {
  return combineEffects(<Object, Effect<PaymentState>>{
    PaymentAction.action: _onAction,
    PaymentAction.selectPayment: _selectPayment,
  });
}

void _onAction(Action action, Context<PaymentState> ctx) {}
void _selectPayment(Action action, Context<PaymentState> ctx) async {
  final bool _isNativePay = action.payload ?? true;
  if (_isNativePay != ctx.state.nativePay)
    ctx.dispatch(PaymentActionCreator.updateNatviePayValue(_isNativePay));
  if (!_isNativePay) {
    if (ctx.state.user.firebaseUser == null) return;
    final _cards =
        await BaseApi.instance.getCreditCards(ctx.state.user.firebaseUser.uid);
    if (_cards.success) {
      ctx.dispatch(
          PaymentActionCreator.updateSelectedCard(_cards.result.list[0]));
    }
  }
  //if (_isNativePay)
  Navigator.of(ctx.context).pop();
}
