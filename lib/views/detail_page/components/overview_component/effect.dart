import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<OverViewState> buildEffect() {
  return combineEffects(<Object, Effect<OverViewState>>{
    OverViewAction.action: _onAction,
  });
}

void _onAction(Action action, Context<OverViewState> ctx) {
}
