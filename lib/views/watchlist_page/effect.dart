import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie/actions/apihelper.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';
import 'package:movie/views/watchlistdetail_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<WatchlistPageState> buildEffect() {
  return combineEffects(<Object, Effect<WatchlistPageState>>{
    WatchlistPageAction.action: _onAction,
    WatchlistPageAction.swiperCellTapped: _swiperCellTapped,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<WatchlistPageState> ctx) {}

Future _onInit(Action action, Context<WatchlistPageState> ctx) async {
  final Object ticker = ctx.stfState;
  ctx.state.animationController =
      AnimationController(vsync: ticker, duration: Duration(milliseconds: 300));
  ctx.state.swiperController = SwiperController();
  int accountid = ctx.state.accountId;
  if (accountid != null) {
    var movie = await ApiHelper.getMoviesWatchlist(accountid);
    if (movie != null)
      ctx.dispatch(WatchlistPageActionCreator.setMovieList(movie));
    var tv = await ApiHelper.getTVShowsWacthlist(accountid);
    if (tv != null) ctx.dispatch(WatchlistPageActionCreator.setTVShowList(tv));
  }
}

void _onDispose(Action action, Context<WatchlistPageState> ctx) {
  ctx.state.animationController.dispose();
  ctx.state.swiperController.dispose();
}

Future _swiperCellTapped(Action action, Context<WatchlistPageState> ctx) async {
  await Navigator.of(ctx.context)
    ..push(PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 600),
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.ease)),
            child: WatchlistDetailPage()
                .buildPage({'data': ctx.state.selectMdeia}),
          );
        }));
}
