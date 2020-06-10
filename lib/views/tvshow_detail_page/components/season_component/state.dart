import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/tvdetail.dart';
import 'package:movie/views/tvshow_detail_page/state.dart';

class SeasonState implements Cloneable<SeasonState> {
  List<Season> seasons;
  @override
  SeasonState clone() {
    return SeasonState();
  }
}

class SeasonConnector extends ConnOp<TvShowDetailState, SeasonState> {
  @override
  SeasonState get(TvShowDetailState state) {
    SeasonState substate = new SeasonState();
    substate.seasons = state.tvDetailModel?.seasons;
    return substate;
  }
}
