import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/models/episode_model.dart';
import 'action.dart';
import 'state.dart';

Effect<EpisodeListState> buildEffect() {
  return combineEffects(<Object, Effect<EpisodeListState>>{
    EpisodeListAction.action: _onAction,
    EpisodeListAction.episodeCellTapped: _onEpisodeCellTapped,
  });
}

void _onAction(Action action, Context<EpisodeListState> ctx) {}

void _onEpisodeCellTapped(Action action, Context<EpisodeListState> ctx) async {
  final _episode = action.payload as Episode;
  final _season = ctx.state.season;
  if (_episode.streamLink != null) {
    final index = _season.episodes.indexOf(_episode);
    if (_season.playStates[index] != '1') {
      _season.playStates[index] = '1';
      _episode.playState = true;
      ctx.state.preferences
          .setStringList('TvSeason${_season.id}', _season.playStates)
          .then((d) {
        if (d) ctx.dispatch(EpisodeListActionCreator.updateSeason(_season));
      });
    }
    await Navigator.of(ctx.context)
        .pushNamed('tvShowLiveStreamPage', arguments: {
      'tvid': ctx.state.tvid,
      'name': ctx.state.name,
      'season': _season,
      'episode': _episode,
    });
  }
}
