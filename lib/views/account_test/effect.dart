import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<AccountState> buildEffect() {
  return combineEffects(<Object, Effect<AccountState>>{
    AccountAction.action: _onAction,
    AccountAction.navigatorPush: _navigatorPush,
  });
}

void _onAction(Action action, Context<AccountState> ctx) {}

void _navigatorPush(Action action, Context<AccountState> ctx) async {
  if (ctx.state.user?.firebaseUser == null)
    await _onLogin(action, ctx);
  else {
    String routerName = action.payload[0];
    Object data = action.payload[1];
    await Navigator.of(ctx.context).pushNamed(routerName, arguments: data);
  }
}

Future _onLogin(Action action, Context<AccountState> ctx) async {
  await Navigator.of(ctx.context).pushNamed('loginpage');
}
