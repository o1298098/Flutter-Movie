import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/coming_page/components/tv_component/action.dart';
import 'action.dart';
import 'state.dart';

Effect<TVCellState> buildEffect() {
  return combineEffects(<Object, Effect<TVCellState>>{
    TVCellAction.action: _onAction,
    Lifecycle.initState: _onLoadSeason
  });
}

void _onAction(Action action, Context<TVCellState> ctx) {}
Future _onLoadSeason(Action action, Context<TVCellState> ctx) async {
  ctx.broadcast(TVListActionCreator.onLoadSeason(ctx.state.index));
}
