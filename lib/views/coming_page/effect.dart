import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/api/tmdb_api.dart';
import 'package:movie/models/response_model.dart';
import 'package:movie/models/video_list.dart';
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
  final _tmdb = TMDBApi.instance;
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
  var q = await _tmdb.getMovieUpComing();
  if (q.result != null)
    ctx.dispatch(ComingPageActionCreator.onInitMoviesComing(q.result));
  var t = await _tmdb.getTVOnTheAir();
  if (t.result != null)
    ctx.dispatch(ComingPageActionCreator.onInitTVComing(t.result));
}

void _onDispose(Action action, Context<ComingPageState> ctx) {
  ctx.state.tvController.dispose();
  ctx.state.movieController.dispose();
}

Future _onLoadMore(Action action, Context<ComingPageState> ctx) async {
  ResponseModel<VideoListModel> q;
  final _tmdb = TMDBApi.instance;
  if (ctx.state.showmovie) {
    if (ctx.state.moviecoming.page == ctx.state.moviecoming.totalPages) return;
    q = await _tmdb.getMovieUpComing(page: ctx.state.moviecoming.page + 1);
  } else {
    if (ctx.state.tvcoming.page == ctx.state.tvcoming.totalPages) return;
    q = await _tmdb.getTVOnTheAir(page: ctx.state.tvcoming.page + 1);
  }
  if (q.result != null)
    ctx.dispatch(ComingPageActionCreator.onLoadMore(q.result));
}
