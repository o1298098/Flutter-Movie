import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie/actions/api/base_api.dart';
import 'package:movie/actions/creditcard_verify.dart';
import 'package:movie/models/base_api_model/braintree_creditcard.dart';
import 'package:movie/models/models.dart';
import 'package:movie/views/payment_page/action.dart';
import 'package:movie/views/payment_page/components/create_card_component/components/scan_component/state.dart';
import 'package:toast/toast.dart';
import 'action.dart';
import 'state.dart';

Effect<CreateCardState> buildEffect() {
  return combineEffects(<Object, Effect<CreateCardState>>{
    CreateCardAction.action: _onAction,
    CreateCardAction.nextTapped: _nextTapped,
    CreateCardAction.backTapped: _backTapped,
    CreateCardAction.scan: _onScan,
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
      ctx.state.swiperController
          .next()
          .then((value) => ctx.state.cardNumberFocusNode.nextFocus());
      break;
    case 1:
      if (ctx.state.holderNameController.text.isEmpty ||
          ctx.state.holderNameController.text.length < 4) return;

      ctx.state.inputIndex++;
      ctx.state.swiperController
          .next()
          .then((value) => ctx.state.holderNameFocusNode.nextFocus());

      break;
    case 2:
      if (ctx.state.expriedDateController.text.isEmpty ||
          ctx.state.expriedDateController.text.length < 3) return;

      ctx.state.inputIndex++;
      ctx.dispatch(CreateCardActionCreator.setInputIndex(ctx.state.inputIndex));
      ctx.state.animationController.forward();
      ctx.state.swiperController
          .next()
          .then((value) => ctx.state.expriedDaterFocusNode.nextFocus());

      break;
    case 3:
      if (ctx.state.cvvController.text.isEmpty ||
          ctx.state.cvvController.text.length < 2) return;
      ctx.state.cvvFocusNode.unfocus();
      ctx.dispatch(CreateCardActionCreator.loading(true));
      final _baseApi = BaseApi.instance;
      final _r = await _baseApi.createStripeCreditCard(CreditCard.fromParams(
        customerId: ctx.state.customerId,
        expirationMonth: ctx.state.expriedDateController.text.substring(0, 2),
        expirationYear: ctx.state.expriedDateController.text.substring(2, 4),
        maskedNumber: ctx.state.cardNumberController.text,
        cardholderName: ctx.state.holderNameController.text,
        bin: ctx.state.cvvController.text,
      ));
      if (_r.success) {
        if (_r.result['status']) {
          final _card = StripeCreditCard.fromJson(_r.result['data']);
          ctx.dispatch(PaymentPageActionCreator.insertCreditCard(_card));
          Navigator.of(ctx.context).pop();
        } else
          Toast.show(_r.result['message'], ctx.context, duration: 5);
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
      ctx.state.swiperController
          .previous()
          .then((value) => ctx.state.holderNameFocusNode.previousFocus());
      break;
    case 2:
      ctx.state.inputIndex--;
      ctx.state.swiperController
          .previous()
          .then((value) => ctx.state.expriedDaterFocusNode.previousFocus());

      break;
    case 3:
      ctx.state.animationController.reverse();
      ctx.state.inputIndex--;
      ctx.dispatch(CreateCardActionCreator.setInputIndex(ctx.state.inputIndex));
      ctx.state.swiperController
          .previous()
          .then((value) => ctx.state.cvvFocusNode.previousFocus());
      break;
  }
}

void _onScan(Action action, Context<CreateCardState> ctx) async {
  ctx.state.scanState = ScanState();
  await Navigator.of(ctx.context).push(
      MaterialPageRoute(builder: (context) => ctx.buildComponent('scan')));
}

void _onInit(Action action, Context<CreateCardState> ctx) async {
  ctx.state.inputIndex = 0;
  ctx.state.swiperController = SwiperController();
  ctx.state.cardNumberController = TextEditingController();
  ctx.state.holderNameController = TextEditingController();
  ctx.state.expriedDateController = TextEditingController();
  ctx.state.cvvController = TextEditingController();
  ctx.state.cardNumberFocusNode = FocusNode();
  ctx.state.holderNameFocusNode = FocusNode();
  ctx.state.expriedDaterFocusNode = FocusNode();
  ctx.state.cvvFocusNode = FocusNode();
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
  ctx.state.cardNumberFocusNode.dispose();
  ctx.state.expriedDaterFocusNode.dispose();
  ctx.state.cvvFocusNode.dispose();
  ctx.state.holderNameFocusNode.dispose();
}
