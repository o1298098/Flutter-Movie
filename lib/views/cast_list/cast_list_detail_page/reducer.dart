import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/cast_list_detail.dart';

import 'action.dart';
import 'state.dart';

Reducer<CastListDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<CastListDetailState>>{
      CastListDetailAction.action: _onAction,
      CastListDetailAction.setListDetail: _setListDetail,
    },
  );
}

CastListDetailState _onAction(CastListDetailState state, Action action) {
  final CastListDetailState newState = state.clone();
  return newState;
}

CastListDetailState _setListDetail(CastListDetailState state, Action action) {
  final CastListDetail _result = action.payload;
  final CastListDetailState newState = state.clone();
  newState.listDetail = _result;
  return newState;
}
