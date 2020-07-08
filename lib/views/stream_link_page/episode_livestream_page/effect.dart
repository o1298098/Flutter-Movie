import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/http/base_api.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/models/base_api_model/tvshow_like_model.dart';
import 'package:movie/models/episodemodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

Effect<EpisodeLiveStreamState> buildEffect() {
  return combineEffects(<Object, Effect<EpisodeLiveStreamState>>{
    EpisodeLiveStreamAction.action: _onAction,
    EpisodeLiveStreamAction.episodeTapped: _episodeTapped,
    EpisodeLiveStreamAction.likeTvShow: _likeTvShow,
    EpisodeLiveStreamAction.commentTap: _commentTap,
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
  ctx.dispatch(EpisodeLiveStreamActionCreator.setSelectedEpisode(_episode));
  await _getLike(action, ctx);
  await _getComment(action, ctx);
}

void _onInit(Action action, Context<EpisodeLiveStreamState> ctx) async {
  ctx.state.scrollController = ScrollController();
  final _pre = await SharedPreferences.getInstance();
  if (_pre.containsKey('useVideoSourceApi'))
    ctx.state.useVideoSourceApi = _pre.getBool('useVideoSourceApi');
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

Future _likeTvShow(Action action, Context<EpisodeLiveStreamState> ctx) async {
  final user = GlobalStore.store.getState().user;
  int _likeCount = ctx.state.likeCount;
  bool _userLike = ctx.state.userliked;
  if (user?.firebaseUser == null) return;
  _userLike ? _likeCount-- : _likeCount++;
  ctx.dispatch(EpisodeLiveStreamActionCreator.setLike(_likeCount, !_userLike));
  final _likeModel = TvShowLikeModel.fromParams(
      tvId: ctx.state.tvid,
      season: ctx.state.selectedEpisode.seasonNumber,
      episode: ctx.state.selectedEpisode.episodeNumber,
      id: 0,
      uid: user.firebaseUser.uid);

  final _result = _userLike
      ? await BaseApi.instance.unlikeTvShow(_likeModel)
      : await BaseApi.instance.likeTvShow(_likeModel);
  print(_result.result);
}

Future _commentTap(Action action, Context<EpisodeLiveStreamState> ctx) async {
  await Navigator.of(ctx.context).push(
    PageRouteBuilder(
        barrierColor: const Color(0xAA000000),
        fullscreenDialog: true,
        barrierDismissible: true,
        opaque: false,
        pageBuilder: (context, animation, subAnimation) {
          return SlideTransition(
            position: Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0.3))
                .animate(
                    CurvedAnimation(parent: animation, curve: Curves.ease)),
            child: ctx.buildComponent('comments'),
          );
        }),
  );
}
