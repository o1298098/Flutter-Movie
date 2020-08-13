import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<TabbarState> buildEffect() {
  return combineEffects(<Object, Effect<TabbarState>>{
    TabbarAction.action: _onAction,
  });
}

void _onAction(Action action, Context<TabbarState> ctx) {
}
