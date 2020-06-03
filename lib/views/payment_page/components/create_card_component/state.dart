import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie/views/payment_page/state.dart';

import 'components/scan_component/state.dart';

class CreateCardState implements Cloneable<CreateCardState> {
  String customerId;
  AnimationController animationController;
  TextEditingController cardNumberController;
  TextEditingController holderNameController;
  TextEditingController expriedDateController;
  TextEditingController cvvController;
  FocusNode cardNumberFocusNode;
  FocusNode holderNameFocusNode;
  FocusNode expriedDaterFocusNode;
  FocusNode cvvFocusNode;
  SwiperController swiperController;
  int inputIndex;
  bool loading;
  ScanState scanState;

  @override
  CreateCardState clone() {
    return CreateCardState()
      ..customerId = customerId
      ..animationController = animationController
      ..cardNumberController = cardNumberController
      ..holderNameController = holderNameController
      ..expriedDateController = expriedDateController
      ..cvvController = cvvController
      ..cardNumberFocusNode = cardNumberFocusNode
      ..holderNameFocusNode = holderNameFocusNode
      ..expriedDaterFocusNode = expriedDaterFocusNode
      ..cvvFocusNode = cvvFocusNode
      ..swiperController = swiperController
      ..inputIndex = inputIndex
      ..loading = loading
      ..scanState = scanState;
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
