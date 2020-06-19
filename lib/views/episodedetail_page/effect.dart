import 'package:fish_redux/fish_redux.dart';
import 'package:movie/actions/http/apihelper.dart';
import 'action.dart';
import 'state.dart';

Effect<EpisodeDetailPageState> buildEffect() {
  return combineEffects(<Object, Effect<EpisodeDetailPageState>>{
    EpisodeDetailPageAction.action: _onAction,
    Lifecycle.initState: _onInit
  });
}

void _onAction(Action action, Context<EpisodeDetailPageState> ctx) {}
Future _onInit(Action action, Context<EpisodeDetailPageState> ctx) async {
  final r = await ApiHelper.getTVEpisodeDetail(ctx.state.tvid,
      ctx.state.episode.seasonNumber, ctx.state.episode.episodeNumber,
      appendToResponse: 'images,credits,videos');
  if (r.success)
    ctx.dispatch(
        EpisodeDetailPageActionCreator.onUpdateEpisodeDetail(r.result));
}
