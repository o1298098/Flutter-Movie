import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/base_api_model/tvshow_comment.dart';
import 'package:movie/views/stream_link_page/episode_livestream_page/state.dart';

class CommentState implements Cloneable<CommentState> {
  TvShowComments comments;
  ScrollController scrollController;
  bool isBusy;
  int tvId;
  int episode;
  int season;

  @override
  CommentState clone() {
    return CommentState()
      ..comments = comments
      ..season = season
      ..episode = episode
      ..tvId = tvId
      ..isBusy = isBusy
      ..scrollController = scrollController;
  }
}

class CommentConnector extends ConnOp<EpisodeLiveStreamState, CommentState> {
  @override
  CommentState get(EpisodeLiveStreamState state) {
    CommentState mstate = CommentState();
    mstate = state.commentState;
    mstate.season = state.selectedEpisode.seasonNumber;
    mstate.episode = state.selectedEpisode.episodeNumber;
    mstate.tvId = state.tvid;
    return mstate;
  }

  @override
  void set(EpisodeLiveStreamState state, CommentState subState) {
    state.commentState = subState;
    state.comments = subState.comments;
  }
}
