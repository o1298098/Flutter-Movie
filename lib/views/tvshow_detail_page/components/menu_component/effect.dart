import 'package:fish_redux/fish_redux.dart';
import 'package:movie/actions/api/tmdb_api.dart';
import 'package:movie/actions/api/base_api.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/models/base_api_model/user_media.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/views/tvshow_detail_page/action.dart';
import 'action.dart';
import 'state.dart';

Effect<MenuState> buildEffect() {
  return combineEffects(<Object, Effect<MenuState>>{
    MenuAction.action: _onAction,
    MenuAction.setRating: _setRating,
    MenuAction.setFavorite: _setFavorite,
    MenuAction.setWatchlist: _setWatchlist
  });
}

void _onAction(Action action, Context<MenuState> ctx) {}

void _setFavorite(Action action, Context<MenuState> ctx) async {
  final bool _isFavorite = ctx.state.accountState.favorite;
  final user = GlobalStore.store.getState().user;
  final _baseApi = BaseApi.instance;

  if (user != null) {
    ctx.dispatch(MenuActionCreator.updateFavorite(!_isFavorite));
    if (_isFavorite)
      await _baseApi.deleteFavorite(
          user.firebaseUser.uid, MediaType.tv, ctx.state.id);
    else
      await _baseApi.setFavorite(UserMedia.fromParams(
          uid: user.firebaseUser.uid,
          name: ctx.state.name,
          photoUrl: ctx.state.detail.posterPath,
          overwatch: ctx.state.detail.overview,
          rated: ctx.state.detail.voteAverage,
          ratedCount: ctx.state.detail.voteCount,
          releaseDate: ctx.state.detail.firstAirDate,
          popular: ctx.state.detail.popularity,
          genre: ctx.state.detail.genres.map((f) => f.name).toList().join(','),
          mediaId: ctx.state.id,
          mediaType: 'tv'));
    await _baseApi.updateAccountState(ctx.state.accountState);
    ctx.broadcast(TvShowDetailActionCreator.showSnackBar(!_isFavorite
        ? 'has been mark as favorite'
        : 'has been removed from your favorites'));
  }
}

Future _setRating(Action action, Context<MenuState> ctx) async {
  final user = GlobalStore.store.getState().user;
  if (user != null) {
    ctx.dispatch(MenuActionCreator.updateRating(action.payload));
    final _baseApi = BaseApi.instance;
    _baseApi.updateAccountState(ctx.state.accountState);
    ctx.broadcast(
        TvShowDetailActionCreator.showSnackBar('your rating has been saved'));
  }
}

Future _setWatchlist(Action action, Context<MenuState> ctx) async {
  final bool _isWatchlist = ctx.state.accountState.watchlist;
  final user = GlobalStore.store.getState().user;
  final _baseApi = BaseApi.instance;

  if (user != null) {
    ctx.dispatch(MenuActionCreator.updateWatctlist(!_isWatchlist));
    if (_isWatchlist)
      await _baseApi.deleteWatchlist(
          user.firebaseUser.uid, MediaType.tv, ctx.state.id);
    else
      await _baseApi.setWatchlist(UserMedia.fromParams(
          uid: user.firebaseUser.uid,
          name: ctx.state.name,
          photoUrl: ctx.state.detail.posterPath,
          overwatch: ctx.state.detail.overview,
          rated: ctx.state.detail.voteAverage,
          ratedCount: ctx.state.detail.voteCount,
          releaseDate: ctx.state.detail.firstAirDate,
          popular: ctx.state.detail.popularity,
          genre: ctx.state.detail.genres.map((f) => f.name).toList().join(','),
          mediaId: ctx.state.id,
          mediaType: 'tv'));
    await _baseApi.updateAccountState(ctx.state.accountState);
    ctx.broadcast(TvShowDetailActionCreator.showSnackBar(!_isWatchlist
        ? 'has been add to your watchlist'
        : 'has been removed from your watchlist'));
  }
  final bool f = action.payload;
  ctx.dispatch(MenuActionCreator.updateWatctlist(f));
  final _tmdb = TMDBApi.instance;
  var r = await _tmdb.addToWatchlist(ctx.state.id, MediaType.movie, f);
  if (r)
    ctx.broadcast(TvShowDetailActionCreator.showSnackBar(f
        ? 'has been add to your watchlist'
        : 'has been removed from your watchlist'));
}
