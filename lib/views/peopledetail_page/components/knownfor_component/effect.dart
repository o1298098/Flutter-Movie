import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<KnownForState> buildEffect() {
  return combineEffects(<Object, Effect<KnownForState>>{
    KnownForAction.action: _onAction,
  });
}

void _onAction(Action action, Context<KnownForState> ctx) {
}
