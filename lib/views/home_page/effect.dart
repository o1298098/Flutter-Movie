import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:movie/actions/apihelper.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';
import 'package:movie/customwidgets/searchbar_delegate.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/enums/time_window.dart';
import 'action.dart';
import 'state.dart';

Effect<HomePageState> buildEffect() {
  return combineEffects(<Object, Effect<HomePageState>>{
    HomePageAction.action: _onAction,
    HomePageAction.moreTapped: _moreTapped,
    HomePageAction.searchBarTapped: _onSearchBarTapped,
    HomePageAction.cellTapped: _onCellTapped,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<HomePageState> ctx) {}

Future _onInit(Action action, Context<HomePageState> ctx) async {
  final ticker = ctx.stfState as CustomstfState;
  ctx.state.animatedController =
      AnimationController(vsync: ticker, duration: Duration(milliseconds: 600));
  ctx.state.scrollController = new ScrollController();
  var r = await ApiHelper.getNowPlayingMovie();
  if (r != null) ctx.dispatch(HomePageActionCreator.onInitMovie(r));
  var s = await ApiHelper.getTVOnTheAir();
  if (s != null) ctx.dispatch(HomePageActionCreator.onInitTV(s));
  var trending = await ApiHelper.getTrending(MediaType.all, TimeWindow.day);
  if (trending != null)
    ctx.dispatch(HomePageActionCreator.initTrending(trending));
  var p = await ApiHelper.getPopularMovies();
  if (p != null) ctx.dispatch(HomePageActionCreator.onInitPopularMovie(p));
  var t = await ApiHelper.getPopularTVShows();
  if (t != null) ctx.dispatch(HomePageActionCreator.onInitPopularTV(t));
}

void _onDispose(Action action, Context<HomePageState> ctx) {
  ctx.state.animatedController.dispose();
  ctx.state.scrollController.dispose();
}

Future _moreTapped(Action action, Context<HomePageState> ctx) async {
  await Navigator.of(ctx.context).pushNamed('MoreMediaPage',
      arguments: {'list': action.payload[0], 'type': action.payload[1]});
}

Future _onSearchBarTapped(Action action, Context<HomePageState> ctx) async {
  await showSearch(context: ctx.context, delegate: SearchBarDelegate());
}

Future _onCellTapped(Action action, Context<HomePageState> ctx) async {
  final MediaType type = action.payload[4];
  final int id = action.payload[0];
  final String bgpic = action.payload[1];
  final String title = action.payload[2];
  final String posterpic = action.payload[3];
  final String pagename =
      type == MediaType.movie ? 'detailpage' : 'tvdetailpage';
  var data = {
    type == MediaType.movie ? 'id' : 'tvid': id,
    'bgpic': type == MediaType.movie ? posterpic : bgpic,
    type == MediaType.movie ? 'title' : 'name': title,
    'posterpic': posterpic
  };

  await Navigator.of(ctx.context).pushNamed(pagename, arguments: data);
}
