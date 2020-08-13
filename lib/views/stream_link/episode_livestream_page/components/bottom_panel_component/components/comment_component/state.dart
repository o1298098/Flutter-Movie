import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/base_api_model/tvshow_comment.dart';
import 'package:movie/views/stream_link/episode_livestream_page/components/bottom_panel_component/state.dart';

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

class CommentConnector extends ConnOp<BottomPanelState, CommentState> {
  @override
  CommentState get(BottomPanelState state) {
    CommentState mstate = state.commentState;
    mstate.tvId = state.tvId;
    mstate.season = state.season;
    mstate.episode = state.selectEpisode;
    return mstate;
  }

  @override
  void set(BottomPanelState state, CommentState subState) {
    state.commentState = subState;
  }
}
