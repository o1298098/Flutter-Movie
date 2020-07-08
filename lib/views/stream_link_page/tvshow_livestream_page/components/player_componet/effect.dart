import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<TvPlayerState> buildEffect() {
  return combineEffects(<Object, Effect<TvPlayerState>>{
    TvPlayerAction.action: _onAction,
  });
}

void _onAction(Action action, Context<TvPlayerState> ctx) {
}
