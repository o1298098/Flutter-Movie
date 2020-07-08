import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/base_api_model/tvshow_comment.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';
import 'package:movie/models/episodemodel.dart';
import 'package:movie/models/seasondetail.dart';

import 'components/comment_component/state.dart';

class EpisodeLiveStreamState implements Cloneable<EpisodeLiveStreamState> {
  int tvid;
  bool useVideoSourceApi;
  bool userliked;
  int likeCount;
  TvShowStreamLinks streamLinks;
  Episode selectedEpisode;
  Season season;
  TvShowComments comments;
  ScrollController scrollController;
  CommentState commentState;

  @override
  EpisodeLiveStreamState clone() {
    return EpisodeLiveStreamState()
      ..tvid = tvid
      ..season = season
      ..streamLinks = streamLinks
      ..selectedEpisode = selectedEpisode
      ..comments = comments
      ..likeCount = likeCount
      ..userliked = userliked
      ..scrollController = scrollController
      ..useVideoSourceApi = useVideoSourceApi
      ..commentState = commentState;
  }
}

EpisodeLiveStreamState initState(Map<String, dynamic> args) {
  EpisodeLiveStreamState state = EpisodeLiveStreamState();
  state.tvid = args['tvid'];
  state.season = args['season'];
  state.selectedEpisode = args['selectedEpisode'];
  state.streamLinks = args['streamlinks'];
  state.useVideoSourceApi = false;
  state.likeCount = 0;
  state.userliked = false;
  state.commentState = CommentState()
    ..comments = TvShowComments.fromParams(data: []);
  return state;
}
