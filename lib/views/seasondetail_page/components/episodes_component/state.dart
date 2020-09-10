import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/episode_model.dart';
import 'package:movie/views/seasondetail_page/state.dart';

class EpisodesState implements Cloneable<EpisodesState> {
  List<Episode> episodes;
  int tvid;

  EpisodesState({
    this.episodes,
    this.tvid,
  });

  @override
  EpisodesState clone() {
    return EpisodesState()..episodes = episodes;
  }
}

class EpisodesConnector extends ConnOp<SeasonDetailPageState, EpisodesState> {
  @override
  EpisodesState get(SeasonDetailPageState state) {
    EpisodesState mstate = EpisodesState();
    mstate.episodes = state.seasonDetailModel.episodes;
    mstate.tvid = state.tvid;
    return mstate;
  }
}
