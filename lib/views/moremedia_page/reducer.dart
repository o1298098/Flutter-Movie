import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/video_list.dart';

import 'action.dart';
import 'state.dart';

Reducer<MoreMediaPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<MoreMediaPageState>>{
      MoreMediaPageAction.action: _onAction,
      MoreMediaPageAction.loadMore: _loadMore
    },
  );
}

MoreMediaPageState _onAction(MoreMediaPageState state, Action action) {
  final MoreMediaPageState newState = state.clone();
  return newState;
}

MoreMediaPageState _loadMore(MoreMediaPageState state, Action action) {
  final VideoListModel model =
      action.payload ?? VideoListModel.fromParams(results: []);
  final MoreMediaPageState newState = state.clone();
  newState.videoList.results.addAll(model.results);
  newState.videoList.page = model.page;
  return newState;
}
