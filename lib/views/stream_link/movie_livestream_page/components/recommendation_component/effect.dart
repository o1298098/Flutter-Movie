import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
import 'package:movie/actions/api/base_api.dart';
import 'package:movie/actions/api/tmdb_api.dart';
import 'package:movie/models/models.dart';
import 'package:movie/views/stream_link/movie_livestream_page/action.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  BaseApi.instance.getMovieStreamLinks(_movie.id).then((value) async {
    if (value.success) {
      MovieStreamLinks _result = value.result;
      MovieStreamLink _link;
      List<MovieStreamLink> _lists = _result.list;
      if (value.result.list.length > 0) {
        final _pre = await SharedPreferences.getInstance();
        if (_pre.containsKey('defaultVideoLanguage')) {
          final _defaultVideoLanguage = _pre.getString('defaultVideoLanguage');
          final _languageList = _lists
              .where((e) => e.language.code == _defaultVideoLanguage)
              .toList();
          if (_languageList.length > 0) {
            for (var d in _languageList) _result.list.remove(d);
            _result.list.insertAll(0, _languageList);
          }
        }
        if (_pre.containsKey('preferHost')) {
          final _preferHost = _pre.getString('preferHost');
          final _hostList =
              _lists.where((e) => e.streamLink.contains(_preferHost)).toList();
          if (_hostList.length > 0) {
            for (var d in _hostList) _result.list.remove(d);
            _result.list.insertAll(0, _hostList);
          }
        }
        _link = _result.list.first;
      }
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
