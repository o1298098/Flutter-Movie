import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie/views/payment_page/state.dart';

class CreateCardState implements Cloneable<CreateCardState> {
  AnimationController animationController;
  TextEditingController cardNumberController;
  TextEditingController hosterNameController;
  TextEditingController expriedDateController;
  TextEditingController cvvController;
  SwiperController swiperController;
  int inputIndex;

  @override
  CreateCardState clone() {
    return CreateCardState()
      ..animationController = animationController
      ..cardNumberController = cardNumberController
      ..hosterNameController = hosterNameController
      ..expriedDateController = expriedDateController
      ..cvvController = cvvController
      ..swiperController = swiperController
      ..inputIndex = inputIndex;
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
