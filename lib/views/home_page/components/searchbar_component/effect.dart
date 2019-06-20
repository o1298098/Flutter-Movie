import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SearchBarState> buildEffect() {
  return combineEffects(<Object, Effect<SearchBarState>>{
    SearchBarAction.action: _onAction,
  });
}

void _onAction(Action action, Context<SearchBarState> ctx) {
}
