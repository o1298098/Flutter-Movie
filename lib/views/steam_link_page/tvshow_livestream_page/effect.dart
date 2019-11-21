import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/base_api.dart';
import 'action.dart';
import 'state.dart';

Effect<TvShowLiveStreamPageState> buildEffect() {
  return combineEffects(<Object, Effect<TvShowLiveStreamPageState>>{
    TvShowLiveStreamPageAction.action: _onAction,
    TvShowLiveStreamPageAction.episodeCellTapped: _episodeCellTapped,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<TvShowLiveStreamPageState> ctx) {}

void _onInit(Action action, Context<TvShowLiveStreamPageState> ctx) async {
  ctx.state.episodelistController = ScrollController();
  final _streamLinks =
      await BaseApi.getTvSeasonStreamLinks(ctx.state.tvid, ctx.state.season);
  if (_streamLinks != null)
    ctx.dispatch(
        TvShowLiveStreamPageActionCreator.setStreamLinks(_streamLinks));
}

void _onDispose(Action action, Context<TvShowLiveStreamPageState> ctx) {
  ctx.state.episodelistController.dispose();
}

void _episodeCellTapped(
    Action action, Context<TvShowLiveStreamPageState> ctx) async {
  final int episode = action.payload;
  if (episode != null) {
    ctx.dispatch(TvShowLiveStreamPageActionCreator.episodeChanged(episode));
    await ctx.state.episodelistController.animateTo(
        Adapt.px(330) * (episode - 1),
        curve: Curves.ease,
        duration: Duration(milliseconds: 300));
  }
}
