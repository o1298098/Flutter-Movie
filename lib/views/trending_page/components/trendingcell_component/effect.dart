import 'package:fish_redux/fish_redux.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:movie/actions/api/base_api.dart';
import 'package:movie/actions/api/graphql_client.dart';
import 'package:movie/models/base_api_model/movie_like_model.dart';
import 'package:movie/models/base_api_model/tvshow_like_model.dart';
import 'action.dart';
import 'state.dart';

Effect<TrendingCellState> buildEffect() {
  return combineEffects(<Object, Effect<TrendingCellState>>{
    TrendingCellAction.action: _onAction,
    TrendingCellAction.onLikeTap: _onLikeTap,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<TrendingCellState> ctx) {}

void _onInit(Action action, Context<TrendingCellState> ctx) async {
  if (ctx.state.user.firebaseUser == null) return;
  final _type = ctx.state.cellData.mediaType;
  String _mapKey = '';
  final _id = ctx.state.cellData.id;
  final _uid = ctx.state.user.firebaseUser.uid;
  QueryResult _result;
  bool _liked = false;
  switch (_type) {
    case 'movie':
      _mapKey = 'movie';
      _result = await BaseGraphQLClient.instance.getMovieLiked(_id, _uid);
      break;
    case 'tv':
      _mapKey = 'tvshow';
      _result = await BaseGraphQLClient.instance.getTvShowLiked(_id, _uid);
      break;
    case 'person':
      _mapKey = 'cast';
      return;
  }
  if (_result == null || _result?.hasException == true) return;
  final _data = _result.data[_mapKey];
  _liked = _data['userLiked'];
  if (_liked != ctx.state.liked)
    ctx.dispatch(TrendingCellActionCreator.setLiked(_liked, ctx.state.index));
}

void _onLikeTap(Action action, Context<TrendingCellState> ctx) async {
  if (ctx.state.user.firebaseUser == null) return;
  final _type = ctx.state.cellData.mediaType;
  final _id = ctx.state.cellData.id;
  final _uid = ctx.state.user.firebaseUser.uid;
  final bool _liked = ctx.state.liked;
  switch (_type) {
    case 'movie':
      _liked
          ? BaseApi.instance
              .unlikeMovie(MovieLikeModel.fromParams(movieId: _id, uid: _uid))
          : BaseApi.instance
              .likeMovie(MovieLikeModel.fromParams(movieId: _id, uid: _uid));
      break;
    case 'tv':
      _liked
          ? BaseApi.instance.unlikeTvShow(TvShowLikeModel.fromParams(
              tvId: _id, uid: _uid, season: 1, episode: 1))
          : BaseApi.instance.likeTvShow(TvShowLikeModel.fromParams(
              tvId: _id, uid: _uid, season: 1, episode: 1));
      break;
    case 'person':
      break;
  }
  ctx.dispatch(TrendingCellActionCreator.setLiked(!_liked, ctx.state.index));
}
