import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/http/apihelper.dart';
import 'action.dart';
import 'state.dart';

Effect<SeasonDetailPageState> buildEffect() {
  return combineEffects(<Object, Effect<SeasonDetailPageState>>{
    SeasonDetailPageAction.action: _onAction,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<SeasonDetailPageState> ctx) {}

Future _onInit(Action action, Context<SeasonDetailPageState> ctx) async {
  ctx.state.scrollController = new ScrollController();
  if (ctx.state.tvid != null && ctx.state.seasonNumber != null) {
    final _detail = await ApiHelper.getTVSeasonDetail(
        ctx.state.tvid, ctx.state.seasonNumber,
        appendToResponse: 'credits');
    if (_detail.success)
      ctx.dispatch(
          SeasonDetailPageActionCreator.onSeasonDetailChanged(_detail.result));
    final _videos = await ApiHelper.getTvShowSeasonVideo(
        ctx.state.tvid, ctx.state.seasonNumber);
    if (_videos.success)
      ctx.dispatch(SeasonDetailPageActionCreator.setVideos(_videos.result));
    final _images = await ApiHelper.getTvShowSeasonImages(
        ctx.state.tvid, ctx.state.seasonNumber);
    if (_images.success)
      ctx.dispatch(SeasonDetailPageActionCreator.setImages(_images.result));
  }
}
