import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_swiper/flutter_swiper.dart';
import 'action.dart';
import 'state.dart';

Effect<CreateCardState> buildEffect() {
  return combineEffects(<Object, Effect<CreateCardState>>{
    CreateCardAction.action: _onAction,
    CreateCardAction.nextTapped: _nextTapped,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<CreateCardState> ctx) {}
void _nextTapped(Action action, Context<CreateCardState> ctx) {
  ctx.state.inputIndex++;
  switch (ctx.state.inputIndex) {
    case 1:
      ctx.state.swiperController.move(1);
      break;
    case 2:
      ctx.state.swiperController.move(2);
      break;
    case 3:
      ctx.state.animationController.forward();
      ctx.state.swiperController.move(3);
      break;
    case 4:
      ctx.state.inputIndex = 0;
      ctx.state.animationController.reverse();
      ctx.state.swiperController.move(0);
      break;
  }
}

void _onInit(Action action, Context<CreateCardState> ctx) async {
  ctx.state.inputIndex = 0;
  ctx.state.swiperController = SwiperController();
  ctx.state.cardNumberController = TextEditingController();
  ctx.state.hosterNameController = TextEditingController();
  ctx.state.expriedDateController = TextEditingController();
  ctx.state.cvvController = TextEditingController();
  final Object _ticker = ctx.stfState;
  ctx.state.animationController = AnimationController(
      vsync: _ticker, duration: Duration(milliseconds: 600));
}

void _onDispose(Action action, Context<CreateCardState> ctx) {
  ctx.state.swiperController.dispose();
  ctx.state.cardNumberController.dispose();
  ctx.state.hosterNameController.dispose();
  ctx.state.expriedDateController.dispose();
  ctx.state.cvvController.dispose();
  ctx.state.animationController.dispose();
}
