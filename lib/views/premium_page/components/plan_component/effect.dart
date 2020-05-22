import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<PlanState> buildEffect() {
  return combineEffects(<Object, Effect<PlanState>>{
    PlanAction.action: _onAction,
  });
}

void _onAction(Action action, Context<PlanState> ctx) {
}
