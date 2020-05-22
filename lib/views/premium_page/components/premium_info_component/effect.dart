import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<PremiumInfoState> buildEffect() {
  return combineEffects(<Object, Effect<PremiumInfoState>>{
    PremiumInfoAction.action: _onAction,
  });
}

void _onAction(Action action, Context<PremiumInfoState> ctx) {
}
