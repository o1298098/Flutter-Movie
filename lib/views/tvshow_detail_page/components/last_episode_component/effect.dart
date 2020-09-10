import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<LastEpisodeState> buildEffect() {
  return combineEffects(<Object, Effect<LastEpisodeState>>{
    LastEpisodeAction.action: _onAction,
  });
}

void _onAction(Action action, Context<LastEpisodeState> ctx) {
}
