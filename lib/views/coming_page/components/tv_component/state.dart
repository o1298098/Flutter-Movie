import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/models/videolist.dart';
import 'package:movie/views/coming_page/state.dart';

class TVListState implements Cloneable<TVListState> {
  VideoListModel tvcoming;
  ScrollController tvController;
  @override
  TVListState clone() {
    return TVListState()
    ..tvcoming=tvcoming
    ..tvController=tvController;
  }
}

class TVListConnector extends ConnOp<ComingPageState,TVListState>{
  @override
  TVListState get(ComingPageState state) {
    TVListState substate=new TVListState();
    substate.tvcoming=state.tvcoming;
    substate.tvController=state.tvController;
    return substate;
  }
  @override
  void set(ComingPageState state, TVListState subState) {
    state.tvcoming=subState.tvcoming;
  }
}
