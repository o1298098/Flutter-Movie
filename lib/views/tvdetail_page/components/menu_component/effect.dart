import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:movie/actions/apihelper.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/views/tvdetail_page/action.dart';
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
  if (user != null) {
    ctx.dispatch(MenuActionCreator.updateFavorite(!_isFavorite));
    var c = Firestore.instance
        .collection("Favorites")
        .document(user.uid)
        .collection("FavoriteTVShow")
        .document(ctx.state.id.toString());
    if (!_isFavorite)
      c.setData({
        'name': ctx.state.name,
        'overwatch': ctx.state.overWatch,
        'photourl': ctx.state.posterPic,
        'rate': ctx.state.detail.vote_average,
        'releaseDate': ctx.state.detail.first_air_date
      });
    else
      c.delete();
    Firestore.instance
        .collection('AccountState')
        .document(user.uid)
        .collection('TVShows')
        .document(ctx.state.id.toString())
        .setData({
      'favorite': !_isFavorite,
      'watchlist': ctx.state.accountState.watchlist,
      'rated': ctx.state.accountState.rated
    });
    ctx.broadcast(TVDetailPageActionCreator.showSnackBar(!_isFavorite
        ? 'has been mark as favorite'
        : 'has been removed from your favorites'));
  }
}

Future _setRating(Action action, Context<MenuState> ctx) async {
  final user = GlobalStore.store.getState().user;
  if (user != null) {
    ctx.dispatch(MenuActionCreator.updateRating(action.payload));
    Firestore.instance
        .collection("UserRated")
        .document(user.uid)
        .collection("RatedTVShows")
        .document(ctx.state.id.toString())
        .setData({
      'name': ctx.state.name,
      'overwatch': ctx.state.overWatch,
      'photourl': ctx.state.posterPic,
      'rated': action.payload ?? 0,
      'voteAverage': ctx.state.detail.vote_average
    });
    Firestore.instance
        .collection('AccountState')
        .document(user.uid)
        .collection('TVShows')
        .document(ctx.state.id.toString())
        .setData({
      'favorite': ctx.state.accountState.favorite,
      'watchlist': ctx.state.accountState.watchlist,
      'rated': action.payload ?? 0
    });
    ctx.broadcast(
        TVDetailPageActionCreator.showSnackBar('your rating has been saved'));
  }
}

Future _setWatchlist(Action action, Context<MenuState> ctx) async {
  final bool _isWatchlist = ctx.state.accountState.watchlist;
  final user = GlobalStore.store.getState().user;
  if (user != null) {
    ctx.dispatch(MenuActionCreator.updateWatctlist(!_isWatchlist));
    var c = Firestore.instance
        .collection("Watchlist")
        .document(user.uid)
        .collection("WatchlistTVShow")
        .document(ctx.state.id.toString());
    if (!_isWatchlist)
      c.setData({
        'name': ctx.state.name,
        'overwatch': ctx.state.overWatch,
        'photourl': ctx.state.posterPic,
        'rate': ctx.state.detail.vote_average,
        'releaseDate': ctx.state.detail.first_air_date,
        'genre': ctx.state.detail.genres.map((f) => f.id).toList(),
        'ratedCount': ctx.state.detail.vote_count,
        'popular': ctx.state.detail.popularity ?? 0,
      });
    else
      c.delete();
    Firestore.instance
        .collection('AccountState')
        .document(user.uid)
        .collection('TVShows')
        .document(ctx.state.id.toString())
        .setData({
      'favorite': ctx.state.accountState.favorite,
      'watchlist': !_isWatchlist,
      'rated': ctx.state.accountState.rated
    });
    ctx.broadcast(TVDetailPageActionCreator.showSnackBar(!_isWatchlist
        ? 'has been add to your watchlist'
        : 'has been removed from your watchlist'));
  }
  final bool f = action.payload;
  ctx.dispatch(MenuActionCreator.updateWatctlist(f));
  var r = await ApiHelper.addToWatchlist(ctx.state.id, MediaType.movie, f);
  if (r)
    ctx.broadcast(TVDetailPageActionCreator.showSnackBar(f
        ? 'has been add to your watchlist'
        : 'has been removed from your watchlist'));
}
