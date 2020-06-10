import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<KeywordState> buildEffect() {
  return combineEffects(<Object, Effect<KeywordState>>{
    KeywordAction.action: _onAction,
  });
}

void _onAction(Action action, Context<KeywordState> ctx) {
}
