import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/http/base_api.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/models/base_api_model/movie_stream_link.dart';
import 'action.dart';
import 'state.dart';

Effect<MovieLiveStreamState> buildEffect() {
  return combineEffects(<Object, Effect<MovieLiveStreamState>>{
    MovieLiveStreamAction.action: _onAction,
    MovieLiveStreamAction.getLike: _getLike,
    MovieLiveStreamAction.getComment: _getComment,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<MovieLiveStreamState> ctx) {}

void _onInit(Action action, Context<MovieLiveStreamState> ctx) async {
  ctx.state.scrollController = ScrollController();

  BaseApi.instance.getMovieStreamLinks(ctx.state.movieId).then((value) {
    if (value.success) {
      MovieStreamLink _link;
      if (value.result.list.length > 0) _link = value.result.list.first;

      ctx.dispatch(
          MovieLiveStreamActionCreator.setStreamLink(value.result, _link));
    } else
      ctx.dispatch(MovieLiveStreamActionCreator.setLoading(false));
  });
  await _getLike(action, ctx);
  await _getComment(action, ctx);
}

void _onDispose(Action action, Context<MovieLiveStreamState> ctx) {
  ctx.state.scrollController.dispose();
}

Future _getComment(Action action, Context<MovieLiveStreamState> ctx) async {
  final _comment = await BaseApi.instance.getMovieComments(ctx.state.movieId);
  if (_comment.success)
    ctx.dispatch(MovieLiveStreamActionCreator.setComment(_comment.result));
}

Future _getLike(Action action, Context<MovieLiveStreamState> ctx) async {
  final _user = GlobalStore.store.getState().user;
  final _like = await BaseApi.instance.getMovieLikes(
      movieid: ctx.state.movieId, uid: _user?.firebaseUser?.uid ?? '');
  if (_like.success)
    ctx.dispatch(MovieLiveStreamActionCreator.setLike(
        _like.result['likes'], _like.result['userLike']));
}
