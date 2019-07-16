import 'package:fish_redux/fish_redux.dart';
import 'package:movie/actions/apihelper.dart';
import 'action.dart';
import 'state.dart';

Effect<EpisodeDetailPageState> buildEffect() {
  return combineEffects(<Object, Effect<EpisodeDetailPageState>>{
    EpisodeDetailPageAction.action: _onAction,
    Lifecycle.initState:_onInit
  });
}

void _onAction(Action action, Context<EpisodeDetailPageState> ctx) {
}
Future _onInit(Action action, Context<EpisodeDetailPageState> ctx) async{
  var r= await ApiHelper.getTVEpisodeDetail(ctx.state.tvid, ctx.state.episode.season_number, ctx.state.episode.episode_number,appendToResponse: 'images,credits,videos');
  if(r!=null)ctx.dispatch(EpisodeDetailPageActionCreator.onUpdateEpisodeDetail(r));
}
