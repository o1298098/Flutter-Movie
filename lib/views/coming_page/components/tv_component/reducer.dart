import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/tvdetail.dart';

import 'action.dart';
import 'state.dart';

Reducer<TVListState> buildReducer() {
  return asReducer(
    <Object, Reducer<TVListState>>{
      TVListAction.action: _onAction,
      TVListAction.updateSeason:_onUpdateSeason
    },
  );
}

TVListState _onAction(TVListState state, Action action) {
  final TVListState newState = state.clone();
  return newState;
}
TVListState _onUpdateSeason(TVListState state, Action action) {
  final int i=action.payload[0]??0;
  final TVDetailModel d=action.payload[1];
  final TVListState newState = state.clone();
  newState.tvcoming.results[i].nextAirDate=d.next_episode_to_air.air_date??'-';
  newState.tvcoming.results[i].nextEpisodeName=d.next_episode_to_air.name??'-';
  newState.tvcoming.results[i].nextEpisodeNumber=d.next_episode_to_air.episode_number.toString();
  newState.tvcoming.results[i].season=d.number_of_seasons.toString();
  return newState;
}
