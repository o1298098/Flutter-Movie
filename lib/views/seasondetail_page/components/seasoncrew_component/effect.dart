import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SeasonCrewState> buildEffect() {
  return combineEffects(<Object, Effect<SeasonCrewState>>{
    SeasonCrewAction.action: _onAction,
  });
}

void _onAction(Action action, Context<SeasonCrewState> ctx) {
}
