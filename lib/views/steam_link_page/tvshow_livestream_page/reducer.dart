import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/models/base_api_model/tvshow_comment.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';
import 'package:movie/models/episodemodel.dart';

import 'action.dart';
import 'state.dart';

Reducer<TvShowLiveStreamPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<TvShowLiveStreamPageState>>{
      TvShowLiveStreamPageAction.action: _onAction,
      TvShowLiveStreamPageAction.setStreamLinks: _setStreamLinks,
      TvShowLiveStreamPageAction.episodeChanged: _episodeChanged,
      TvShowLiveStreamPageAction.headerExpanded: _headerExpanded,
      TvShowLiveStreamPageAction.setComments: _setComment,
      TvShowLiveStreamPageAction.showBottom: _showBottom,
      TvShowLiveStreamPageAction.insertComment: _insertComment,
    },
  );
}

TvShowLiveStreamPageState _onAction(
    TvShowLiveStreamPageState state, Action action) {
  final TvShowLiveStreamPageState newState = state.clone();
  return newState;
}

TvShowLiveStreamPageState _headerExpanded(
    TvShowLiveStreamPageState state, Action action) {
  final TvShowLiveStreamPageState newState = state.clone();
  newState.isExpanded = state.isExpanded == CrossFadeState.showFirst
      ? CrossFadeState.showSecond
      : CrossFadeState.showFirst;
  return newState;
}

TvShowLiveStreamPageState _showBottom(
    TvShowLiveStreamPageState state, Action action) {
  final bool b = action.payload ?? false;
  final TvShowLiveStreamPageState newState = state.clone();
  newState.showBottom = b;
  return newState;
}

TvShowLiveStreamPageState _setStreamLinks(
    TvShowLiveStreamPageState state, Action action) {
  final TvShowStreamLinks model = action.payload;
  final TvShowLiveStreamPageState newState = state.clone();
  newState.streamLinks = model;
  return newState;
}

TvShowLiveStreamPageState _episodeChanged(
    TvShowLiveStreamPageState state, Action action) {
  final Episode ep = action.payload;
  final TvShowLiveStreamPageState newState = state.clone();
  newState.selectedEpisode = ep;
  newState.episodeNumber = ep.episode_number;
  newState.comments = null;
  return newState;
}

TvShowLiveStreamPageState _setComment(
    TvShowLiveStreamPageState state, Action action) {
  final TvShowComments comment = action.payload;
  final TvShowLiveStreamPageState newState = state.clone();
  newState.comments = comment;
  return newState;
}

TvShowLiveStreamPageState _insertComment(
    TvShowLiveStreamPageState state, Action action) {
  final TvShowComment _comment = action.payload;
  final TvShowLiveStreamPageState newState = state.clone();
  if (_comment != null) newState.comments.data.insert(0, _comment);
  return newState;
}
