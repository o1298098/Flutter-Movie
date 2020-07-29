import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/tvshow_detail.dart';
import 'package:movie/views/tvshow_detail_page/state.dart';

class LastEpisodeState implements Cloneable<LastEpisodeState> {
  AirData lastEpisodeToAir;
  @override
  LastEpisodeState clone() {
    return LastEpisodeState()..lastEpisodeToAir = lastEpisodeToAir;
  }
}

class LastEpisodeConnector extends ConnOp<TvShowDetailState, LastEpisodeState> {
  @override
  LastEpisodeState get(TvShowDetailState state) {
    LastEpisodeState substate = new LastEpisodeState();
    substate.lastEpisodeToAir = state.tvDetailModel?.lastEpisodeToAir;
    return substate;
  }
}
