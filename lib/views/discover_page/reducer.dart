import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/sortcondition.dart';
import 'package:movie/models/videolist.dart';

import 'action.dart';
import 'state.dart';

Reducer<DiscoverPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<DiscoverPageState>>{
      DiscoverPageAction.action: _onAction,
      DiscoverPageAction.sortChanged:_onSortChanged,
      DiscoverPageAction.loadData:_onLoadData,
      DiscoverPageAction.loadMore:_onLoadMore,
     // DiscoverPageAction.busyChanged:_onBusyChanged,
      //Lifecycle.dispose:_onDispose,
    },
  );
}

DiscoverPageState _onAction(DiscoverPageState state, Action action) {
  final DiscoverPageState newState = state.clone();
  return newState;
}
DiscoverPageState _onLoadData(DiscoverPageState state, Action action) {
  VideoListModel m=action.payload??VideoListModel.fromParams(results: List<VideoListResult>());
  final DiscoverPageState newState = state.clone();
  newState.videoListModel=m;
  return newState;
}
DiscoverPageState _onSortChanged(DiscoverPageState state, Action action) {
  final String s=action.payload;
  final DiscoverPageState newState = state.clone();
  newState.selectedSort=s;
  return newState;
}
DiscoverPageState _onBusyChanged(DiscoverPageState state, Action action) {
  final bool s=action.payload??false;
  final DiscoverPageState newState = state.clone();
  newState.isbusy=s;
  return newState;
}


DiscoverPageState _onLoadMore(DiscoverPageState state, Action action) {
  final List<VideoListResult> m=action.payload??List<VideoListResult>();
  final DiscoverPageState newState = state.clone();
  newState.videoListModel.page++;
  newState.videoListModel.results.addAll(m);
  return newState;
}
