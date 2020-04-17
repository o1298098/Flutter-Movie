import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<StreamLinkState> buildEffect() {
  return combineEffects(<Object, Effect<StreamLinkState>>{
    StreamLinkAction.action: _onAction,
  });
}

void _onAction(Action action, Context<StreamLinkState> ctx) {
}
