import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<WatchlistPageState> buildEffect() {
  return combineEffects(<Object, Effect<WatchlistPageState>>{
    WatchlistPageAction.action: _onAction,
  });
}

void _onAction(Action action, Context<WatchlistPageState> ctx) {
}
