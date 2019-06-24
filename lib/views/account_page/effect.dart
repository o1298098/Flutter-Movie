import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/apihelper.dart';
import 'action.dart';
import 'state.dart';

Effect<AccountPageState> buildEffect() {
  return combineEffects(<Object, Effect<AccountPageState>>{
    AccountPageAction.action: _onAction,
    AccountPageAction.login:_onLogin,
    Lifecycle.initState:_onInit,
  });
}
Future _onInit(Action action, Context<AccountPageState> ctx) async{
  ctx.state.scrollController=new ScrollController();
  ctx.state.scrollController.addListener(() async{
      bool isBottom = ctx.state.scrollController.position.pixels ==
          ctx.state.scrollController.position.maxScrollExtent;
      if (isBottom) {
       _onLoadMore(action,ctx);
      }
    });
   await _onLoadData(action,ctx);
}
Future _onLoadData(Action action, Context<AccountPageState> ctx) async{
  var r=await ApiHelper.getMovieDiscover();
  if(r!=null)ctx.dispatch(AccountPageActionCreator.onLoadData(r));
}

void _onLoadMore(Action action, Context<AccountPageState> ctx) async{
  var r=await ApiHelper.getMovieDiscover(page: ctx.state.moiveListModel.page+1);
  if(r!=null)ctx.dispatch(AccountPageActionCreator.onLoadMore(r.results));
}

void _onAction(Action action, Context<AccountPageState> ctx) {
}
void _onLogin(Action action, Context<AccountPageState> ctx) async{
   await Navigator.of(ctx.context).pushNamed('loginpage');
}
