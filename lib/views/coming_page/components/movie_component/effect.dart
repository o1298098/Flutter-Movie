import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<MovieListState> buildEffect() {
  return combineEffects(<Object, Effect<MovieListState>>{
    MovieListAction.action: _onAction,
  });
}

void _onAction(Action action, Context<MovieListState> ctx) {
}
