import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/api/base_api.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

Effect<EpisodeLiveStreamState> buildEffect() {
  return combineEffects(<Object, Effect<EpisodeLiveStreamState>>{
    EpisodeLiveStreamAction.action: _onAction,
    EpisodeLiveStreamAction.episodeTapped: _episodeTapped,
    EpisodeLiveStreamAction.markWatched: _markWatched,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<EpisodeLiveStreamState> ctx) {}

void _episodeTapped(Action action, Context<EpisodeLiveStreamState> ctx) async {
  final Episode _episode = action.payload;
  if (_episode == null ||
      _episode.episodeNumber == ctx.state.selectedEpisode.episodeNumber) return;
  ctx.state.scrollController.animateTo(0.0,
      duration: Duration(milliseconds: 300), curve: Curves.ease);
  TvShowStreamLink _link;
  if (ctx.state.streamLinks != null)
    _link = ctx.state.streamLinks.list.firstWhere(
        (e) => e.episode == _episode.episodeNumber,
        orElse: () => null);
  ctx.dispatch(
      EpisodeLiveStreamActionCreator.setSelectedEpisode(_episode, _link));
  await _getLike(action, ctx);
  await _getComment(action, ctx);
}

void _onInit(Action action, Context<EpisodeLiveStreamState> ctx) async {
  ctx.state.scrollController = ScrollController();

  BaseApi.instance
      .getTvSeasonStreamLinks(
          ctx.state.tvid, ctx.state.selectedEpisode.seasonNumber)
      .then((value) async {
    TvShowStreamLink _link;
    if (value.success) {
      TvShowStreamLinks _links = value.result;
      if (value.result.list.length > 0) {
        _links = await _sortStreamLink(_links);
        _link = value.result.list.firstWhere(
            (e) => e.episode == ctx.state.selectedEpisode.episodeNumber,
            orElse: () => null);
      }

      ctx.dispatch(EpisodeLiveStreamActionCreator.setStreamLink(_links, _link));
    } else
      ctx.dispatch(EpisodeLiveStreamActionCreator.setLoading(false));
  });
  await _getLike(action, ctx);
  await _getComment(action, ctx);
}

void _onDispose(Action action, Context<EpisodeLiveStreamState> ctx) {
  ctx.state.scrollController.dispose();
}

Future _getComment(Action action, Context<EpisodeLiveStreamState> ctx) async {
  final _comment = await BaseApi.instance.getTvShowComments(
      ctx.state.tvid,
      ctx.state.selectedEpisode.seasonNumber,
      ctx.state.selectedEpisode.episodeNumber);
  if (_comment.success)
    ctx.dispatch(EpisodeLiveStreamActionCreator.setComment(_comment.result));
}

Future _getLike(Action action, Context<EpisodeLiveStreamState> ctx) async {
  final _user = GlobalStore.store.getState().user;
  final _like = await BaseApi.instance.getTvShowLikes(
      tvid: ctx.state.tvid,
      season: ctx.state.selectedEpisode.seasonNumber,
      episode: ctx.state.selectedEpisode.episodeNumber,
      uid: _user?.firebaseUser?.uid ?? '');
  if (_like.success)
    ctx.dispatch(EpisodeLiveStreamActionCreator.setLike(
        _like.result['likes'], _like.result['userLike']));
}

Future<TvShowStreamLinks> _sortStreamLink(TvShowStreamLinks links) async {
  List<TvShowStreamLink> _lists = links.list;
  final _pre = await SharedPreferences.getInstance();
  if (_pre.containsKey('defaultVideoLanguage')) {
    final _defaultVideoLanguage = _pre.getString('defaultVideoLanguage');
    final _languageList =
        _lists.where((e) => e.language.code == _defaultVideoLanguage).toList();
    if (_languageList.length > 0) {
      for (var d in _languageList) links.list.remove(d);
      links.list.insertAll(0, _languageList);
    }
  }
  if (_pre.containsKey('preferHost')) {
    final _preferHost = _pre.getString('preferHost');
    final _hostList =
        _lists.where((e) => e.streamLink.contains(_preferHost)).toList();
    if (_hostList.length > 0) {
      for (var d in _hostList) links.list.remove(d);
      links.list.insertAll(0, _hostList);
    }
  }
  return links;
}

void _markWatched(Action action, Context<EpisodeLiveStreamState> ctx) async {
  final _pre = await SharedPreferences.getInstance();
  final _episode = action.payload as Episode;
  final index = ctx.state.season.episodes.indexOf(_episode);
  if (ctx.state.season.playStates[index] != '1') {
    ctx.state.season.playStates[index] = '1';
    _episode.playState = true;
    _pre.setStringList(
        'TvSeason${ctx.state.season.id}', ctx.state.season.playStates);
  }
}
