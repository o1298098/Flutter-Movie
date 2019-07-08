import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<EpisodeDetailPageState> buildEffect() {
  return combineEffects(<Object, Effect<EpisodeDetailPageState>>{
    EpisodeDetailPageAction.action: _onAction,
  });
}

void _onAction(Action action, Context<EpisodeDetailPageState> ctx) {
}
