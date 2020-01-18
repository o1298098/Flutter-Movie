import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ListCellState> buildEffect() {
  return combineEffects(<Object, Effect<ListCellState>>{
    ListCellAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ListCellState> ctx) {
}
