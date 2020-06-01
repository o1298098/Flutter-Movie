import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie/views/payment_page/state.dart';

class CreateCardState implements Cloneable<CreateCardState> {
  String customerId;
  AnimationController animationController;
  TextEditingController cardNumberController;
  TextEditingController holderNameController;
  TextEditingController expriedDateController;
  TextEditingController cvvController;
  SwiperController swiperController;
  int inputIndex;
  bool loading;

  @override
  CreateCardState clone() {
    return CreateCardState()
      ..customerId = customerId
      ..animationController = animationController
      ..cardNumberController = cardNumberController
      ..holderNameController = holderNameController
      ..expriedDateController = expriedDateController
      ..cvvController = cvvController
      ..swiperController = swiperController
      ..inputIndex = inputIndex
      ..loading = loading;
  }
}

class CreateCardConnector extends ConnOp<PaymentPageState, CreateCardState> {
  @override
  CreateCardState get(PaymentPageState state) {
    CreateCardState mstate = state.createCardState;
    return mstate;
  }

  @override
  void set(PaymentPageState state, CreateCardState subState) {
    state.createCardState = subState;
  }
}
