import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<TabState> buildEffect() {
  return combineEffects(<Object, Effect<TabState>>{
    TabAction.action: _onAction,
  });
}

void _onAction(Action action, Context<TabState> ctx) {
}
