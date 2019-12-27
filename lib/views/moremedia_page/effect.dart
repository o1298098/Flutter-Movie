import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/apihelper.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/videolist.dart';
import 'action.dart';
import 'state.dart';

Effect<MoreMediaPageState> buildEffect() {
  return combineEffects(<Object, Effect<MoreMediaPageState>>{
    MoreMediaPageAction.action: _onAction,
    MoreMediaPageAction.cellTapped: _cellTapped,
    Lifecycle.initState: _onInit,
    Lifecycle.build:_onBuild,
    Lifecycle.dispose:_onDispose
  });
}

void _onInit(Action action, Context<MoreMediaPageState> ctx) {
  ctx.state.scrollController = ScrollController()
    ..addListener(() {
      bool isBottom = ctx.state.scrollController.position.pixels ==
          ctx.state.scrollController.position.maxScrollExtent;
      if (isBottom) {
        _loadMore(action, ctx);
      }
    });
    final TickerProvider tickerProvider = ctx.stfState as CustomstfState;
    ctx.state.animationController=AnimationController(
      vsync: tickerProvider, duration: Duration(milliseconds: 300*ctx.state.videoList.results.length)
    );
}

void _onBuild(Action action, Context<MoreMediaPageState> ctx) {
 Future.delayed(const Duration(milliseconds: 200),()=> ctx.state.animationController.forward());
}
void _onDispose(Action action, Context<MoreMediaPageState> ctx) {
  ctx.state.animationController.stop(canceled: false);
  ctx.state.animationController.dispose();
  ctx.state.scrollController.dispose();
}
void _onAction(Action action, Context<MoreMediaPageState> ctx) {}

Future _loadMore(Action action, Context<MoreMediaPageState> ctx) async {
  VideoListModel model;
  int page = ctx.state.videoList.page + 1;
  if (page <= ctx.state.videoList.totalPages) {
    if (ctx.state.mediaType == MediaType.movie)
      model = await ApiHelper.getNowPlayingMovie(page: page);
    else
      model = await ApiHelper.getTVOnTheAir(page: page);
  }
  if (model != null) ctx.dispatch(MoreMediaPageActionCreator.loadMore(model));
}

Future _cellTapped(Action action, Context<MoreMediaPageState> ctx) async {
  if (ctx.state.mediaType == MediaType.movie)
    await Navigator.of(ctx.context).pushNamed('moviedetailpage', arguments: {
      'movieid': action.payload[0],
      'bgpic': action.payload[2],
      'title': action.payload[1],
      'posterpic': action.payload[3]
    });
  else
    await Navigator.of(ctx.context).pushNamed('tvdetailpage', arguments: {
      'tvid': action.payload[0],
      'bgpic': action.payload[2],
      'name': action.payload[1],
      'posterpic': action.payload[3]
    });
}
