import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'action.dart';
import 'state.dart';

Effect<AccountPageState> buildEffect() {
  return combineEffects(<Object, Effect<AccountPageState>>{
    AccountPageAction.action: _onAction,
    AccountPageAction.login:_onLogin
  });
}

void _onAction(Action action, Context<AccountPageState> ctx) {
}
void _onLogin(Action action, Context<AccountPageState> ctx) async{
   await Navigator.of(ctx.context).pushNamed('loginpage');
}
