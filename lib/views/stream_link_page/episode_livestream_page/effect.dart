import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/http/base_api.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';
import 'package:movie/models/episodemodel.dart';
import 'action.dart';
import 'state.dart';

Effect<EpisodeLiveStreamState> buildEffect() {
  return combineEffects(<Object, Effect<EpisodeLiveStreamState>>{
    EpisodeLiveStreamAction.action: _onAction,
    EpisodeLiveStreamAction.episodeTapped: _episodeTapped,
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
      .then((value) {
    if (value.success) if (value.result.list.length > 0) {
      final _link = value.result.list.firstWhere(
          (e) => e.episode == ctx.state.selectedEpisode.episodeNumber,
          orElse: () => null);
      ctx.dispatch(
          EpisodeLiveStreamActionCreator.setStreamLink(value.result, _link));
    }
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
