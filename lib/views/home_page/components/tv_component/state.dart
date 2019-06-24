import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/videolist.dart';

import '../../state.dart';

class TVCellsState implements Cloneable<TVCellsState> {
 VideoListModel tv=new VideoListModel.fromParams(results:List<VideoListResult>());
  @override
  TVCellsState clone() {
    return TVCellsState();
  }
}

TVCellsState initTVCellState(Map<String, dynamic> args) {
  return TVCellsState();
}

class TVCellsConnector
    extends ConnOp<HomePageState, TVCellsState> {
  @override
  TVCellsState get(HomePageState state) {
    TVCellsState mstate = TVCellsState();
    mstate.tv= state.tv;
    return mstate;
  }
}
