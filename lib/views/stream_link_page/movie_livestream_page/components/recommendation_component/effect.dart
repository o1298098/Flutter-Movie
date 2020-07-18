import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
import 'package:movie/actions/http/base_api.dart';
import 'package:movie/actions/http/tmdb_api.dart';
import 'package:movie/models/base_api_model/movie_stream_link.dart';
import 'package:movie/models/videolist.dart';
import 'package:movie/views/stream_link_page/movie_livestream_page/action.dart';
import 'action.dart';
import 'state.dart';

Effect<RecommendationState> buildEffect() {
  return combineEffects(<Object, Effect<RecommendationState>>{
    RecommendationAction.action: _onAction,
    RecommendationAction.cellTap: _cellTap,
  });
}

void _onAction(Action action, Context<RecommendationState> ctx) {}

void _cellTap(Action action, Context<RecommendationState> ctx) async {
  final VideoListResult _movie = action.payload;
  ctx.state.controller.animateTo(0.0,
      duration: Duration(milliseconds: 300), curve: Curves.ease);
  ctx.dispatch(RecommendationActionCreator.setInfo(_movie));
  BaseApi.instance.getMovieStreamLinks(_movie.id).then((value) {
    if (value.success) {
      MovieStreamLink _link;
      if (value.result.list.length > 0) _link = value.result.list.first;
      ctx.dispatch(
          MovieLiveStreamActionCreator.setStreamLink(value.result, _link));
    }
  });
  final _tmdb = TMDBApi.instance;
  _tmdb
      .getMovieDetail(_movie.id, appendtoresponse: 'recommendations,credits')
      .then((d) {
    if (d.success)
      ctx.dispatch(RecommendationActionCreator.setDetail(d.result));
  });
  ctx.dispatch(MovieLiveStreamActionCreator.getLike());
  ctx.dispatch(MovieLiveStreamActionCreator.getComment());
}
