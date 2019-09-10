import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<Theme2State> buildEffect() {
  return combineEffects(<Object, Effect<Theme2State>>{
    Theme2Action.action: _onAction,
  });
}

void _onAction(Action action, Context<Theme2State> ctx) {
}
