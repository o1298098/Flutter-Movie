import 'package:fish_redux/fish_redux.dart';
import 'package:movie/actions/apihelper.dart';
import 'action.dart';
import 'state.dart';

Effect<WatchlistPageState> buildEffect() {
  return combineEffects(<Object, Effect<WatchlistPageState>>{
    WatchlistPageAction.action: _onAction,
    Lifecycle.initState:_onInit,
  });
}

void _onAction(Action action, Context<WatchlistPageState> ctx) {
}

Future _onInit(Action action, Context<WatchlistPageState> ctx) async{
  int accountid = ctx.state.accountId;
  if (accountid != null) {
    var movie = await ApiHelper.getMoviesWatchlist(accountid);
    if (movie != null) ctx.dispatch(WatchlistPageActionCreator.setMovieList(movie));
    var tv=await ApiHelper.getTVShowsWacthlist(accountid);
    if (tv != null) ctx.dispatch(WatchlistPageActionCreator.setTVShowList(tv));
  }
}
