import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie/actions/base_api.dart';
import 'action.dart';
import 'state.dart';

Effect<PaymentPageState> buildEffect() {
  return combineEffects(<Object, Effect<PaymentPageState>>{
    PaymentPageAction.action: _onAction,
    PaymentPageAction.showHistory: _showHistory,
    PaymentPageAction.showBillingAddress: _showBillingAddress,
    PaymentPageAction.createCard: _createCard,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<PaymentPageState> ctx) {}

void _onInit(Action action, Context<PaymentPageState> ctx) async {
  ctx.state.swiperController = SwiperController();
  if (ctx.state.user == null) return;
  ctx.state.billingAddressState.customerId = ctx.state.user.firebaseUser.uid;
  final _customer =
      await BaseApi.getBraintreeCustomer(ctx.state.user.firebaseUser.uid);
  if (_customer != null)
    ctx.dispatch(PaymentPageActionCreator.setCustomer(_customer));
}

void _onDispose(Action action, Context<PaymentPageState> ctx) {
  ctx.state.swiperController.dispose();
}

void _showHistory(Action action, Context<PaymentPageState> ctx) async {
  await Navigator.of(ctx.context)
      .push(MaterialPageRoute(builder: (_) => ctx.buildComponent('history')));
}

void _showBillingAddress(Action action, Context<PaymentPageState> ctx) async {
  await Navigator.of(ctx.context).push(
      MaterialPageRoute(builder: (_) => ctx.buildComponent('billingAddress')));
}

void _createCard(Action action, Context<PaymentPageState> ctx) async {
  await Navigator.of(ctx.context).push(
      MaterialPageRoute(builder: (_) => ctx.buildComponent('createCard')));
}
