import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<KeyWordsState> buildEffect() {
  return combineEffects(<Object, Effect<KeyWordsState>>{
    KeyWordsAction.action: _onAction,
  });
}

void _onAction(Action action, Context<KeyWordsState> ctx) {
}
