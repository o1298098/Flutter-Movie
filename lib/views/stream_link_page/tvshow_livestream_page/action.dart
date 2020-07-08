import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/models/base_api_model/tvshow_comment.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';
import 'package:movie/models/episodemodel.dart';

enum TvShowLiveStreamPageAction {
  action,
  headerExpanded,
  setStreamLinks,
  episodeCellTapped,
  episodeChanged,
  setComments,
  showBottom,
  addComment,
  insertComment,
  episodesMoreTapped,
  streamLinkReport,
  loading,
}

class TvShowLiveStreamPageActionCreator {
  static Action onAction() {
    return const Action(TvShowLiveStreamPageAction.action);
  }

  static Action streamLinkReport() {
    return const Action(TvShowLiveStreamPageAction.streamLinkReport);
  }

  static Action headerExpanded() {
    return const Action(TvShowLiveStreamPageAction.headerExpanded);
  }

  static Action setStreamLinks(TvShowStreamLinks d) {
    return Action(TvShowLiveStreamPageAction.setStreamLinks, payload: d);
  }

  static Action episodeCellTapped(TvShowStreamLink episode) {
    return Action(TvShowLiveStreamPageAction.episodeCellTapped,
        payload: episode);
  }

  static Action episodeChanged(Episode ep, TvShowStreamLink link) {
    return Action(TvShowLiveStreamPageAction.episodeChanged,
        payload: [ep, link]);
  }

  static Action setComments(TvShowComments d) {
    return Action(TvShowLiveStreamPageAction.setComments, payload: d);
  }

  static Action onShowBottom(bool d) {
    return Action(TvShowLiveStreamPageAction.showBottom, payload: d);
  }

  static Action addComment(String comment) {
    return Action(TvShowLiveStreamPageAction.addComment, payload: comment);
  }

  static Action insertComment(TvShowComment comment) {
    return Action(TvShowLiveStreamPageAction.insertComment, payload: comment);
  }

  static Action episodesMoreTapped(Widget child) {
    return Action(TvShowLiveStreamPageAction.episodesMoreTapped,
        payload: child);
  }

  static Action loading(bool isLoading) {
    return Action(TvShowLiveStreamPageAction.loading, payload: isLoading);
  }
}
