import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/base_movie.dart';

import 'action.dart';
import 'state.dart';

Reducer<AllStreamLinkPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<AllStreamLinkPageState>>{
      AllStreamLinkPageAction.action: _onAction,
      AllStreamLinkPageAction.initStreamList: _initStreamList,
      AllStreamLinkPageAction.loadMore: _loadMore,
    },
  );
}

AllStreamLinkPageState _onAction(AllStreamLinkPageState state, Action action) {
  final AllStreamLinkPageState newState = state.clone();
  return newState;
}

AllStreamLinkPageState _loadMore(AllStreamLinkPageState state, Action action) {
  final BaseMovieModel _list = action.payload;
  final AllStreamLinkPageState newState = state.clone();
  if (_list != null) {
    newState.streamList.page = _list.page;
    newState.streamList.data.addAll(_list?.data ?? []);
  }
  return newState;
}

AllStreamLinkPageState _initStreamList(
    AllStreamLinkPageState state, Action action) {
  final BaseMovieModel _list = action.payload;
  final AllStreamLinkPageState newState = state.clone();
  newState.streamList = _list;
  return newState;
}
