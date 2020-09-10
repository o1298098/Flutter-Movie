import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<TrendingState> buildEffect() {
  return combineEffects(<Object, Effect<TrendingState>>{
    TrendingAction.action: _onAction,
  });
}

void _onAction(Action action, Context<TrendingState> ctx) {
}
