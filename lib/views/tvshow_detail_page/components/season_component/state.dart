import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/season_detail.dart';
import 'package:movie/views/tvshow_detail_page/state.dart';

class SeasonState implements Cloneable<SeasonState> {
  List<Season> seasons;
  int tvid;
  String name;
  @override
  SeasonState clone() {
    return SeasonState()
      ..seasons = seasons
      ..tvid = tvid;
  }
}

class SeasonConnector extends ConnOp<TvShowDetailState, SeasonState> {
  @override
  SeasonState get(TvShowDetailState state) {
    SeasonState substate = new SeasonState();
    substate.seasons = state.tvDetailModel?.seasons;
    substate.tvid = state.tvid;
    substate.name = state.tvDetailModel?.name;
    return substate;
  }
}
