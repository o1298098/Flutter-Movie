import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie/actions/base_api.dart';
import 'package:movie/actions/creditcard_verify.dart';
import 'package:movie/models/base_api_model/braintree_creditcard.dart';
import 'package:movie/views/payment_page/action.dart';
import 'package:toast/toast.dart';
import 'action.dart';
import 'state.dart';

Effect<CreateCardState> buildEffect() {
  return combineEffects(<Object, Effect<CreateCardState>>{
    CreateCardAction.action: _onAction,
    CreateCardAction.nextTapped: _nextTapped,
    CreateCardAction.backTapped: _backTapped,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<CreateCardState> ctx) {}
final _cardVerify = CreditCardVerify();
void _nextTapped(Action action, Context<CreateCardState> ctx) async {
  switch (ctx.state.inputIndex) {
    case 0:
      if (_cardVerify.verify(ctx.state.cardNumberController.text) == '-' ||
          ctx.state.cardNumberController.text.length < 16) return;
      ctx.state.inputIndex++;
      ctx.dispatch(CreateCardActionCreator.setInputIndex(ctx.state.inputIndex));
      ctx.state.swiperController.next();
      break;
    case 1:
      if (ctx.state.holderNameController.text.isEmpty &&
          ctx.state.holderNameController.text.length < 4) return;

      ctx.state.inputIndex++;
      ctx.state.swiperController.next();
      break;
    case 2:
      if (ctx.state.expriedDateController.text.isEmpty &&
          ctx.state.expriedDateController.text.length < 3) return;

      ctx.state.inputIndex++;
      ctx.dispatch(CreateCardActionCreator.setInputIndex(ctx.state.inputIndex));
      ctx.state.animationController.forward();
      ctx.state.swiperController.next();
      break;
    case 3:
      if (ctx.state.cvvController.text.isEmpty &&
          ctx.state.cvvController.text.length < 2) return;
      ctx.dispatch(CreateCardActionCreator.loading(true));

      final _r = await BaseApi.createCreditCard(CreditCard.fromParams(
        customerId: ctx.state.customerId,
        expirationMonth: ctx.state.expriedDateController.text.substring(0, 2),
        expirationYear: ctx.state.expriedDateController.text.substring(2, 4),
        maskedNumber: ctx.state.cardNumberController.text,
        cardholderName: ctx.state.holderNameController.text,
        bin: ctx.state.cvvController.text,
      ));
      if (_r != null) {
        if (_r['status']) {
          final _card = CreditCard(_r['data']);
          ctx.dispatch(PaymentPageActionCreator.insertCreditCard(_card));
          Navigator.of(ctx.context).pop();
        } else
          Toast.show(_r['message'], ctx.context, duration: 5);
      }

      ctx.dispatch(CreateCardActionCreator.loading(false));
      break;
  }
}

void _backTapped(Action action, Context<CreateCardState> ctx) async {
  switch (ctx.state.inputIndex) {
    case 1:
      ctx.state.inputIndex--;
      ctx.dispatch(CreateCardActionCreator.setInputIndex(ctx.state.inputIndex));
      ctx.state.swiperController.previous();
      break;
    case 2:
      ctx.state.inputIndex--;
      ctx.state.swiperController.previous();
      break;
    case 3:
      ctx.state.animationController.reverse();
      ctx.state.inputIndex--;
      ctx.state.swiperController.previous();
      break;
  }
}

void _onInit(Action action, Context<CreateCardState> ctx) async {
  ctx.state.inputIndex = 0;
  ctx.state.swiperController = SwiperController();
  ctx.state.cardNumberController = TextEditingController();
  ctx.state.holderNameController = TextEditingController();
  ctx.state.expriedDateController = TextEditingController();
  ctx.state.cvvController = TextEditingController();
  final Object _ticker = ctx.stfState;
  ctx.state.animationController = AnimationController(
      vsync: _ticker, duration: Duration(milliseconds: 600));
}

void _onDispose(Action action, Context<CreateCardState> ctx) {
  ctx.state.swiperController.dispose();
  ctx.state.cardNumberController.dispose();
  ctx.state.holderNameController.dispose();
  ctx.state.expriedDateController.dispose();
  ctx.state.cvvController.dispose();
  ctx.state.animationController.dispose();
}