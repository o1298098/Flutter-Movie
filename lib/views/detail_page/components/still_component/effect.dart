import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<StillState> buildEffect() {
  return combineEffects(<Object, Effect<StillState>>{
    StillAction.action: _onAction,
  });
}

void _onAction(Action action, Context<StillState> ctx) {
}
