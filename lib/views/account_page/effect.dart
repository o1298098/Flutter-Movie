import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/apihelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

Effect<AccountPageState> buildEffect() {
  return combineEffects(<Object, Effect<AccountPageState>>{
    Lifecycle.initState:_onInit,
    AccountPageAction.action: _onAction,
    AccountPageAction.login:_onLogin,
    AccountPageAction.logout:_onLogout
  });
}
void _onAction(Action action, Context<AccountPageState> ctx) {
}
Future _onLogin(Action action, Context<AccountPageState> ctx) async{
   await Navigator.of(ctx.context).pushNamed('loginpage');
}
Future _onInit(Action action, Context<AccountPageState> ctx) async{
    var prefs = await SharedPreferences.getInstance();
    String name=prefs.getString('accountname');
    String avatar=prefs.getString('accountgravatar');
    bool islogin=prefs.getBool('islogin');
    ctx.dispatch(AccountPageActionCreator.onInit(name, avatar,islogin));
}
void _onLogout(Action action, Context<AccountPageState> ctx) async{
  var q=await ApiHelper.deleteSession();
  if(q)
  await _onInit(action, ctx);
   //await ctx.dispatch(AccountPageActionCreator.onLogout())
}
