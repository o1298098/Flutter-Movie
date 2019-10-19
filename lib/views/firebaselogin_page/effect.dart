import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<FirebaseLoginPageState> buildEffect() {
  return combineEffects(<Object, Effect<FirebaseLoginPageState>>{
    FirebaseLoginPageAction.action: _onAction,
  });
}

void _onAction(Action action, Context<FirebaseLoginPageState> ctx) {
}
