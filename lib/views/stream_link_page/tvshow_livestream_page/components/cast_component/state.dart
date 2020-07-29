import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/credits_model.dart';

import '../../state.dart';

class CastState implements Cloneable<CastState> {
  CreditsModel credits;
  List<CastData> guestStars;
  List<CrewData> crew;
  @override
  CastState clone() {
    return CastState();
  }
}

class CastConnector extends ConnOp<TvShowLiveStreamPageState, CastState> {
  @override
  CastState get(TvShowLiveStreamPageState state) {
    CastState substate = new CastState();
    substate.credits = state.season.credits;
    substate.guestStars = state.selectedEpisode?.guestStars;
    substate.crew = state.selectedEpisode?.crew;
    return substate;
  }
}
