import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<KeyWordState> buildEffect() {
  return combineEffects(<Object, Effect<KeyWordState>>{
    KeyWordAction.action: _onAction,
  });
}

void _onAction(Action action, Context<KeyWordState> ctx) {
}
