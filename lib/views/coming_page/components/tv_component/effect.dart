import 'package:fish_redux/fish_redux.dart';
import 'package:movie/actions/apihelper.dart';
import 'action.dart';
import 'state.dart';

Effect<TVListState> buildEffect() {
  return combineEffects(<Object, Effect<TVListState>>{
    TVListAction.action: _onAction,
    TVListAction.loadSeason: _onLoadSeason
  });
}

void _onAction(Action action, Context<TVListState> ctx) {}

Future _onLoadSeason(Action action, Context<TVListState> ctx) async {
  if (ctx.state.tvcoming.results[action.payload].nextAirDate == null) {
    var r = await ApiHelper.getTVDetail(
        ctx.state.tvcoming.results[action.payload].id);
    if (r != null)
      ctx.dispatch(TVListActionCreator.onUpdateSeason(action.payload, r));
  }
}
