import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<Theme3State> buildEffect() {
  return combineEffects(<Object, Effect<Theme3State>>{
    Theme3Action.action: _onAction,
  });
}

void _onAction(Action action, Context<Theme3State> ctx) {
}
