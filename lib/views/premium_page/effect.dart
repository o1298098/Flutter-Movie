import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<PremiumPageState> buildEffect() {
  return combineEffects(<Object, Effect<PremiumPageState>>{
    PremiumPageAction.action: _onAction,
  });
}

void _onAction(Action action, Context<PremiumPageState> ctx) {
}
