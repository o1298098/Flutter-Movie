import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ShareCardState> buildEffect() {
  return combineEffects(<Object, Effect<ShareCardState>>{
    ShareCardAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ShareCardState> ctx) {
}
