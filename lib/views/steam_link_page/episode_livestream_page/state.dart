import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';
import 'package:movie/models/episodemodel.dart';
import 'package:movie/models/seasondetail.dart';

class EpisodeLiveStreamState implements Cloneable<EpisodeLiveStreamState> {
  int tvid;
  TvShowStreamLinks streamLinks;
  Episode selectedEpisode;
  Season season;
  ScrollController scrollController;
  @override
  EpisodeLiveStreamState clone() {
    return EpisodeLiveStreamState()
      ..tvid = tvid
      ..season = season
      ..streamLinks = streamLinks
      ..selectedEpisode = selectedEpisode
      ..scrollController = scrollController;
  }
}

EpisodeLiveStreamState initState(Map<String, dynamic> args) {
  EpisodeLiveStreamState state = EpisodeLiveStreamState();
  state.tvid = args['tvid'];
  state.season = args['season'];
  state.selectedEpisode = args['selectedEpisode'];
  state.streamLinks = args['streamlinks'];
  return state;
}
