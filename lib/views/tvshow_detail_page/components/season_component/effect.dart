import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SeasonState> buildEffect() {
  return combineEffects(<Object, Effect<SeasonState>>{
    SeasonAction.action: _onAction,
  });
}

void _onAction(Action action, Context<SeasonState> ctx) {
}
