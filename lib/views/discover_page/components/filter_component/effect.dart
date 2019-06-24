import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<FilterState> buildEffect() {
  return combineEffects(<Object, Effect<FilterState>>{
    FilterAction.action: _onAction,
  });
}

void _onAction(Action action, Context<FilterState> ctx) {
}
