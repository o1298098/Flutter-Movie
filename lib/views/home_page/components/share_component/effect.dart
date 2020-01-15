import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ShareState> buildEffect() {
  return combineEffects(<Object, Effect<ShareState>>{
    ShareAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ShareState> ctx) {
}
