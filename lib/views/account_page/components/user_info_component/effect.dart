import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/user_info_operate.dart';
import 'action.dart';
import 'state.dart';

Effect<UserInfoState> buildEffect() {
  return combineEffects(<Object, Effect<UserInfoState>>{
    UserInfoAction.action: _onAction,
    UserInfoAction.signOut: _onSignOut,
    UserInfoAction.signIn: _onSignIn,
    UserInfoAction.paymentTap: _onPaymentTap,
    UserInfoAction.openNotifications: _openNotifications,
  });
}

void _onAction(Action action, Context<UserInfoState> ctx) {}

void _onSignOut(Action action, Context<UserInfoState> ctx) async {
  await UserInfoOperate.whenLogout();
}

void _onSignIn(Action action, Context<UserInfoState> ctx) async {
  await Navigator.of(ctx.context).pushNamed('loginpage');
}

void _onPaymentTap(Action action, Context<UserInfoState> ctx) async {
  await Navigator.of(ctx.context).pushNamed('paymentPage');
}

void _openNotifications(Action action, Context<UserInfoState> ctx) async {
  await Navigator.of(ctx.context).pushNamed('notificationPage');
}
