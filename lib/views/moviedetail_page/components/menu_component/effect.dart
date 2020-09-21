import 'package:fish_redux/fish_redux.dart';
import 'package:movie/actions/api/tmdb_api.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/views/moviedetail_page/action.dart';
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

Future _setRating(Action action, Context<MenuState> ctx) async {
  ctx.dispatch(MenuActionCreator.updateRating(action.payload));
  final _tmdb = TMDBApi.instance;
  var r = await _tmdb.rateMovie(ctx.state.id, action.payload);
  if (r)
    ctx.broadcast(MovieDetailPageActionCreator.showSnackBar(
        'your rating has been saved'));
}

Future _setFavorite(Action action, Context<MenuState> ctx) async {
  final bool f = action.payload;
  ctx.dispatch(MenuActionCreator.updateFavorite(f));
  final _tmdb = TMDBApi.instance;
  var r = await _tmdb.markAsFavorite(ctx.state.id, MediaType.movie, f);
  if (r)
    ctx.broadcast(MovieDetailPageActionCreator.showSnackBar(
        f ? 'has been mark as favorite' : 'has been removed'));
}

Future _setWatchlist(Action action, Context<MenuState> ctx) async {
  final bool f = action.payload;
  ctx.dispatch(MenuActionCreator.updateWatctlist(f));
  final _tmdb = TMDBApi.instance;
  var r = await _tmdb.addToWatchlist(ctx.state.id, MediaType.movie, f);
  if (r)
    ctx.broadcast(MovieDetailPageActionCreator.showSnackBar(f
        ? 'has been add to your watchlist'
        : 'has been removed from your watchlist'));
}
