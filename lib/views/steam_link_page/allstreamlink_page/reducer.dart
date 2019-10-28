import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';

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
  final QuerySnapshot _list = action.payload;
  final AllStreamLinkPageState newState = state.clone();
  if (_list != null)
    newState.streamList.documents.addAll(_list?.documents ?? []);
  return newState;
}

AllStreamLinkPageState _initStreamList(
    AllStreamLinkPageState state, Action action) {
  final QuerySnapshot _list = action.payload;
  final AllStreamLinkPageState newState = state.clone();
  newState.streamList = _list;
  return newState;
}
