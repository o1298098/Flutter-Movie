import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/api/tmdb_api.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/response_model.dart';
import 'package:movie/models/video_list.dart';
import 'action.dart';
import 'state.dart';

Effect<MoreMediaPageState> buildEffect() {
  return combineEffects(<Object, Effect<MoreMediaPageState>>{
    MoreMediaPageAction.action: _onAction,
    MoreMediaPageAction.cellTapped: _cellTapped,
    Lifecycle.initState: _onInit,
    Lifecycle.build: _onBuild,
    Lifecycle.dispose: _onDispose
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
  final Object tickerProvider = ctx.stfState;
  ctx.state.animationController = AnimationController(
      vsync: tickerProvider,
      duration:
          Duration(milliseconds: 300 * ctx.state.videoList.results.length));
}

void _onBuild(Action action, Context<MoreMediaPageState> ctx) {
  Future.delayed(const Duration(milliseconds: 200),
      () => ctx.state.animationController.forward());
}

void _onDispose(Action action, Context<MoreMediaPageState> ctx) {
  ctx.state.animationController.stop(canceled: false);
  ctx.state.animationController.dispose();
  ctx.state.scrollController.dispose();
}

void _onAction(Action action, Context<MoreMediaPageState> ctx) {}

Future _loadMore(Action action, Context<MoreMediaPageState> ctx) async {
  ResponseModel<VideoListModel> model;
  final _tmdb = TMDBApi.instance;
  int page = ctx.state.videoList.page + 1;
  if (page <= ctx.state.videoList.totalPages) {
    if (ctx.state.mediaType == MediaType.movie)
      model = await _tmdb.getNowPlayingMovie(page: page);
    else
      model = await _tmdb.getTVOnTheAir(page: page);
  }
  if (model.success)
    ctx.dispatch(MoreMediaPageActionCreator.loadMore(model.result));
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
