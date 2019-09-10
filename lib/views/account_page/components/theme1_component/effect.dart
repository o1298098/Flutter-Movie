import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<Theme1State> buildEffect() {
  return combineEffects(<Object, Effect<Theme1State>>{
    Theme1Action.action: _onAction,
  });
}

void _onAction(Action action, Context<Theme1State> ctx) {
}
