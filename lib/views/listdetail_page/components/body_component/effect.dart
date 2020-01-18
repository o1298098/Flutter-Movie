import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<BodyState> buildEffect() {
  return combineEffects(<Object, Effect<BodyState>>{
    BodyAction.action: _onAction,
  });
}

void _onAction(Action action, Context<BodyState> ctx) {
}
