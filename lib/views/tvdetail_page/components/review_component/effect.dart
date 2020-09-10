import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ReviewState> buildEffect() {
  return combineEffects(<Object, Effect<ReviewState>>{
    ReviewAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ReviewState> ctx) {
}
