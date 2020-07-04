import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/models/episodemodel.dart';
import 'action.dart';
import 'state.dart';

Effect<EpisodeLiveStreamState> buildEffect() {
  return combineEffects(<Object, Effect<EpisodeLiveStreamState>>{
    EpisodeLiveStreamAction.action: _onAction,
    EpisodeLiveStreamAction.episodeTapped: _episodeTapped,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<EpisodeLiveStreamState> ctx) {}

void _episodeTapped(Action action, Context<EpisodeLiveStreamState> ctx) {
  final Episode _episode = action.payload;
  if (_episode == null ||
      _episode.episodeNumber == ctx.state.selectedEpisode.episodeNumber) return;
  ctx.state.scrollController
      .animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.ease);
  ctx.dispatch(EpisodeLiveStreamActionCreator.setSelectedEpisode(_episode));
}

void _onInit(Action action, Context<EpisodeLiveStreamState> ctx) {
  ctx.state.scrollController = ScrollController();
}

void _onDispose(Action action, Context<EpisodeLiveStreamState> ctx) {
  ctx.state.scrollController.dispose();
}
