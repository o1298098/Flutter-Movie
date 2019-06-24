import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/videolist.dart';

import 'action.dart';
import 'state.dart';

Reducer<AccountPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<AccountPageState>>{
      AccountPageAction.action: _onAction,

      AccountPageAction.loadData:_onLoadData,
      AccountPageAction.loadMore:_onLoadMore,
    },
  );
}

AccountPageState _onAction(AccountPageState state, Action action) {
  final AccountPageState newState = state.clone();
  return newState;
}
AccountPageState _onLoadData(AccountPageState state, Action action) {
  VideoListModel m=action.payload??VideoListModel.fromParams(results: List<VideoListResult>());
  final AccountPageState newState = state.clone();
  newState.moiveListModel=m;
  return newState;
}
AccountPageState _onLoadMore(AccountPageState state, Action action) {
  final List<VideoListResult> m=action.payload??List<VideoListResult>();
  final AccountPageState newState = state.clone();
  newState.moiveListModel.page++;
  newState.moiveListModel.results.addAll(m);
  return newState;
}
