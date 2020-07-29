import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/models/video_list.dart';
import 'package:movie/views/coming_page/components/tv_component/tvcell_component/state.dart';
import 'package:movie/views/coming_page/state.dart';

import 'shimmercell_component/state.dart';

class TVListState extends MutableSource implements Cloneable<TVListState> {
  VideoListModel tvcoming;
  int page;
  ScrollController tvController;
  @override
  TVListState clone() {
    return TVListState()
      ..tvcoming = tvcoming
      ..tvController = tvController;
  }

  @override
  Object getItemData(int index) {
    if (index < tvcoming.results.length)
      return TVCellState(tvResult: tvcoming.results[index], index: index);
    else
      return ShimmerCellState(
          showShimmer: tvcoming.page == tvcoming.totalResults &&
              tvcoming.results.length > 0);
  }

  @override
  String getItemType(int index) {
    if (index < tvcoming.results.length)
      return 'tvcell';
    else
      return 'shimmercell';
  }

  @override
  int get itemCount => tvcoming.results.length + 1;

  @override
  void setItemData(int index, Object data) {}
}

class TVListConnector extends ConnOp<ComingPageState, TVListState> {
  @override
  TVListState get(ComingPageState state) {
    TVListState substate = new TVListState();
    substate.tvcoming = state.tvcoming;
    substate.tvController = state.tvController;
    substate.page = state.tvPage;
    return substate;
  }

  @override
  void set(ComingPageState state, TVListState subState) {
    state.tvcoming = subState.tvcoming;
  }
}
