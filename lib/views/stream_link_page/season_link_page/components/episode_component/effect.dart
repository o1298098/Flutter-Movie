import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<EpisodeState> buildEffect() {
  return combineEffects(<Object, Effect<EpisodeState>>{
    EpisodeAction.action: _onAction,
  });
}

void _onAction(Action action, Context<EpisodeState> ctx) {
}
