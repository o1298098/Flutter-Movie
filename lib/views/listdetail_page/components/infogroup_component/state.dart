import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/listdetail_page/state.dart';

class InfoGroupState implements Cloneable<InfoGroupState> {
  int itemCount;
  double rating;
  int runTime;
  double revenue;
  @override
  InfoGroupState clone() {
    return InfoGroupState();
  }
}

class InfoGroupConnector extends ConnOp<ListDetailPageState, InfoGroupState> {
  @override
  InfoGroupState get(ListDetailPageState state) {
    InfoGroupState mstate = InfoGroupState();
    mstate.itemCount = state.listDetailModel?.itemCount ?? 0;
    mstate.rating = state.listDetailModel?.totalRated ?? 0.0;
    mstate.runTime = state.listDetailModel?.runTime ?? 0;
    mstate.revenue = state.listDetailModel?.revenue ?? 0;
    return mstate;
  }

  @override
  void set(ListDetailPageState state, InfoGroupState subState) {}
}
