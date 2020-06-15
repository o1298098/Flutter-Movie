import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/apihelper.dart';
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
    if (_detail != null)
      ctx.dispatch(
          SeasonDetailPageActionCreator.onSeasonDetailChanged(_detail));
    final _videos = await ApiHelper.getTvShowSeasonVideo(
        ctx.state.tvid, ctx.state.seasonNumber);
    if (_videos != null)
      ctx.dispatch(SeasonDetailPageActionCreator.setVideos(_videos));
    final _images = await ApiHelper.getTvShowSeasonImages(
        ctx.state.tvid, ctx.state.seasonNumber);
    if (_images != null)
      ctx.dispatch(SeasonDetailPageActionCreator.setImages(_images));
  }
}
