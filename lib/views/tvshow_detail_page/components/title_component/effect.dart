import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<TitleState> buildEffect() {
  return combineEffects(<Object, Effect<TitleState>>{
    TitleAction.action: _onAction,
  });
}

void _onAction(Action action, Context<TitleState> ctx) {
}
