import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<CommentState> buildEffect() {
  return combineEffects(<Object, Effect<CommentState>>{
    CommentAction.action: _onAction,
  });
}

void _onAction(Action action, Context<CommentState> ctx) {
}
