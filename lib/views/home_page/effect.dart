import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:movie/actions/apihelper.dart';
import 'action.dart';
import 'state.dart';

Effect<HomePageState> buildEffect() {
  return combineEffects(<Object, Effect<HomePageState>>{
    HomePageAction.action: _onAction,
    HomePageAction.moreTapped:_moreTapped,
    Lifecycle.initState:_onInit,
  });
}

void _onAction(Action action, Context<HomePageState> ctx) {
}

Future _onInit(Action action, Context<HomePageState> ctx) async{
  ctx.state.scrollController=new ScrollController();
   var r=await ApiHelper.getNowPlayingMovie();
   if(r!=null)ctx.dispatch(HomePageActionCreator.onInitMovie(r));
   var s=await ApiHelper.getTVOnTheAir();
   if(s!=null)ctx.dispatch(HomePageActionCreator.onInitTV(s));
   var p=await ApiHelper.getPopularMovies();
   if(p!=null)ctx.dispatch(HomePageActionCreator.onInitPopularMovie(p));
   var t=await ApiHelper.getPopularTVShows();
   if(t!=null)ctx.dispatch(HomePageActionCreator.onInitPopularTV(t));
}

Future _moreTapped(Action action, Context<HomePageState> ctx) async{
  await Navigator.of(ctx.context).pushNamed('MoreMediaPage',arguments: {'list':action.payload[0],'type':action.payload[1]});
}