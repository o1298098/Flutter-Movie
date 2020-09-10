import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<PremiumInfoState> buildEffect() {
  return combineEffects(<Object, Effect<PremiumInfoState>>{
    PremiumInfoAction.action: _onAction,
    PremiumInfoAction.subscribeChanged: _subscribeChanged,
  });
}

void _onAction(Action action, Context<PremiumInfoState> ctx) {}
void _subscribeChanged(Action action, Context<PremiumInfoState> ctx) {}
