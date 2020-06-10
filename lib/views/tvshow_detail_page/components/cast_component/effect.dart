import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<CastState> buildEffect() {
  return combineEffects(<Object, Effect<CastState>>{
    CastAction.action: _onAction,
  });
}

void _onAction(Action action, Context<CastState> ctx) {
}
