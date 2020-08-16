import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:movie/views/detail_page/page.dart';
import 'package:movie/views/tvshow_detail_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<WatchlistDetailPageState> buildEffect() {
  return combineEffects(<Object, Effect<WatchlistDetailPageState>>{
    WatchlistDetailPageAction.action: _onAction,
    WatchlistDetailPageAction.meidaTap: _mediaTap,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<WatchlistDetailPageState> ctx) {}

Future _onInit(Action action, Context<WatchlistDetailPageState> ctx) async {
  final Object ticker = ctx.stfState;
  ctx.state.animationController = AnimationController(
      vsync: ticker,
      duration: Duration(milliseconds: 1500),
      reverseDuration: Duration(milliseconds: 300));
  await Future.delayed(Duration(milliseconds: 600),
      () => ctx.state.animationController.forward());
}

void _onDispose(Action action, Context<WatchlistDetailPageState> ctx) {
  ctx.state.animationController.dispose();
}

void _mediaTap(Action action, Context<WatchlistDetailPageState> ctx) async {
  final _media = ctx.state.mediaData;
  final Page _page =
      _media.mediaType == 'movie' ? MovieDetailPage() : TvShowDetailPage();
  var data = {
    'id': _media.mediaId,
    'bgpic': _media.photoUrl,
    'name': _media.name,
  };
  await Navigator.of(ctx.context).push(
    PageRouteBuilder(pageBuilder: (context, animation, secAnimation) {
      return FadeTransition(
        opacity: animation,
        child: _page.buildPage(data),
      );
    }),
  );
}
