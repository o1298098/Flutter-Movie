import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<PlayerState> buildEffect() {
  return combineEffects(<Object, Effect<PlayerState>>{
    PlayerAction.action: _onAction,
  });
}

void _onAction(Action action, Context<PlayerState> ctx) {
}
