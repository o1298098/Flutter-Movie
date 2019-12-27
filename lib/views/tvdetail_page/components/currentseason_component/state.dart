import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/tvdetail.dart';
import 'package:movie/views/tvdetail_page/state.dart';

class CurrentSeasonState implements Cloneable<CurrentSeasonState> {
  
  int tvid;
  String name;
  Season nowseason;
  AirData nextToAirData;
  AirData lastToAirData;
  List<Season> seasons;

  @override
  CurrentSeasonState clone() {
    return CurrentSeasonState();
  }
}


class CurrentSeasonConnector extends ConnOp<TVDetailPageState,CurrentSeasonState>{
  @override
  CurrentSeasonState get(TVDetailPageState state) {
    CurrentSeasonState substate=new CurrentSeasonState();
    substate.nowseason=state.tvDetailModel.seasons?.last;
    substate.nextToAirData= state.tvDetailModel?.nextEpisodeToAir;
    substate.lastToAirData=state.tvDetailModel?.lastEpisodeToAir;
    substate.name=state.tvDetailModel.name;
    substate.tvid=state.tvDetailModel.id;
    substate.seasons=state.tvDetailModel.seasons;
    return substate;
  }
}

