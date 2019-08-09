import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
import 'package:movie/actions/apihelper.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';
import 'action.dart';
import 'state.dart';

Effect<WatchlistPageState> buildEffect() {
  return combineEffects(<Object, Effect<WatchlistPageState>>{
    WatchlistPageAction.action: _onAction,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<WatchlistPageState> ctx) {}

Future _onInit(Action action, Context<WatchlistPageState> ctx) async {
  final ticker = ctx.stfState as CustomstfState;
  ctx.state.animationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 3000));
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
}
