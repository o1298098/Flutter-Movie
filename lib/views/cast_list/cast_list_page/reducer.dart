import 'package:fish_redux/fish_redux.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'action.dart';
import 'state.dart';

Reducer<CastListState> buildReducer() {
  return asReducer(
    <Object, Reducer<CastListState>>{
      CastListAction.action: _onAction,
      CastListAction.setCastList: _setCastList
    },
  );
}

CastListState _onAction(CastListState state, Action action) {
  final CastListState newState = state.clone();
  return newState;
}

CastListState _setCastList(CastListState state, Action action) {
  final Stream<FetchResult> _stream = action.payload;
  final CastListState newState = state.clone();
  newState.castList = _stream;
  return newState;
}
