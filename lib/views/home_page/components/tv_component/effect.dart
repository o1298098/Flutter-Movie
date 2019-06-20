import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<TVCellsState> buildEffect() {
  return combineEffects(<Object, Effect<TVCellsState>>{
    TVCellsAction.action: _onAction,
  });
}

void _onAction(Action action, Context<TVCellsState> ctx) {
}
