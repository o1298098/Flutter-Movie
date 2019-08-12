import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/apihelper.dart';
import 'package:movie/models/videolist.dart';
import 'action.dart';
import 'state.dart';

Effect<ComingPageState> buildEffect() {
  return combineEffects(<Object, Effect<ComingPageState>>{
    ComingPageAction.action: _onAction,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose
  });
}

void _onAction(Action action, Context<ComingPageState> ctx) {}

Future _onInit(Action action, Context<ComingPageState> ctx) async {
  ctx.state.movieController = new ScrollController()
    ..addListener(() async {
      bool isBottom = ctx.state.movieController.position.pixels ==
          (ctx.state.movieController.position.maxScrollExtent);
      if (isBottom) {
        await _onLoadMore(action, ctx);
      }
    });
  ctx.state.tvController = new ScrollController()
    ..addListener(() async {
      bool isBottom = ctx.state.tvController.position.pixels ==
          ctx.state.tvController.position.maxScrollExtent;
      if (isBottom) {
        await _onLoadMore(action, ctx);
      }
    });
  var q = await ApiHelper.getMovieUpComing();
  if (q != null) ctx.dispatch(ComingPageActionCreator.onInitMoviesComing(q));
  var t = await ApiHelper.getTVOnTheAir();
  if (t != null) ctx.dispatch(ComingPageActionCreator.onInitTVComing(t));
}

void _onDispose(Action action, Context<ComingPageState> ctx) {
  ctx.state.tvController.dispose();
  ctx.state.movieController.dispose();
}

Future _onLoadMore(Action action, Context<ComingPageState> ctx) async {
  VideoListModel q;
  if (ctx.state.showmovie) {
    if (ctx.state.moviecoming.page == ctx.state.moviecoming.total_pages) return;
    q = await ApiHelper.getMovieUpComing(page: ctx.state.moviecoming.page + 1);
  } else {
    if (ctx.state.tvcoming.page == ctx.state.tvcoming.total_pages) return;
    q = await ApiHelper.getTVOnTheAir(page: ctx.state.tvcoming.page + 1);
  }
  if (q != null) ctx.dispatch(ComingPageActionCreator.onLoadMore(q));
}
