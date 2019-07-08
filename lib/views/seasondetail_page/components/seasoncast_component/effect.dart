import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SeasonCastState> buildEffect() {
  return combineEffects(<Object, Effect<SeasonCastState>>{
    SeasonCastAction.action: _onAction,
  });
}

void _onAction(Action action, Context<SeasonCastState> ctx) {
}
