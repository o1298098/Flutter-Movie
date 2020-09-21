import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/api/base_api.dart';
import 'action.dart';
import 'state.dart';

Effect<UserDataState> buildEffect() {
  return combineEffects(<Object, Effect<UserDataState>>{
    UserDataAction.action: _onAction,
    UserDataAction.navigatorPush: _navigatorPush,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<UserDataState> ctx) {}

void _onInit(Action action, Context<UserDataState> ctx) async {
  if (ctx.state.user?.firebaseUser == null || ctx.state.info != null) return;
  final _result = await BaseApi.instance
      .getUserAccountInfo(ctx.state.user.firebaseUser.uid);
  if (_result.success) {
    ctx.dispatch(UserDataActionCreator.setInfo(_result.result));
  }
}

void _navigatorPush(Action action, Context<UserDataState> ctx) async {
  if (ctx.state.user?.firebaseUser == null)
    await _onLogin(action, ctx);
  else {
    String routerName = action.payload[0];
    Object data = action.payload[1];
    await Navigator.of(ctx.context).pushNamed(routerName, arguments: data);
  }
}

Future _onLogin(Action action, Context<UserDataState> ctx) async {
  await Navigator.of(ctx.context).pushNamed('loginpage');
}
