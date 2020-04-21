import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<AppBarState> buildEffect() {
  return combineEffects(<Object, Effect<AppBarState>>{
    AppBarAction.action: _onAction,
  });
}

void _onAction(Action action, Context<AppBarState> ctx) {
}
