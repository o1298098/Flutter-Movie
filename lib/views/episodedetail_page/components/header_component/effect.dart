import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<EpisodeHeaderState> buildEffect() {
  return combineEffects(<Object, Effect<EpisodeHeaderState>>{
    EpisodeHeaderAction.action: _onAction,
  });
}

void _onAction(Action action, Context<EpisodeHeaderState> ctx) {
}
