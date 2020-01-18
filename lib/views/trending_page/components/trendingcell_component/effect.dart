import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<TrendingCellState> buildEffect() {
  return combineEffects(<Object, Effect<TrendingCellState>>{
    TrendingCellAction.action: _onAction,
  });
}

void _onAction(Action action, Context<TrendingCellState> ctx) {
}
