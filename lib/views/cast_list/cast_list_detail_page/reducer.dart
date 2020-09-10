import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/cast_list_detail.dart';

import 'action.dart';
import 'state.dart';

Reducer<CastListDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<CastListDetailState>>{
      CastListDetailAction.action: _onAction,
      CastListDetailAction.setListDetail: _setListDetail,
      CastListDetailAction.setLoadMore: _setLoadMore,
      CastListDetailAction.updateCastList: _updateCastList,
      CastListDetailAction.loading: _loading
    },
  );
}

CastListDetailState _onAction(CastListDetailState state, Action action) {
  final CastListDetailState newState = state.clone();
  return newState;
}

CastListDetailState _loading(CastListDetailState state, Action action) {
  final bool _loading = action.payload ?? false;
  final CastListDetailState newState = state.clone();
  newState.loading = _loading;
  return newState;
}

CastListDetailState _setListDetail(CastListDetailState state, Action action) {
  final CastListDetail _result = action.payload;
  final CastListDetailState newState = state.clone();
  newState.listDetail = _result;
  return newState;
}

CastListDetailState _setLoadMore(CastListDetailState state, Action action) {
  final CastListDetail _result = action.payload;
  final CastListDetailState newState = state.clone();
  if (_result != null) {
    newState.listDetail.page = _result.page;
    newState.listDetail.data.addAll(_result.data);
  }
  return newState;
}

CastListDetailState _updateCastList(CastListDetailState state, Action action) {
  final BaseCast _cast = action.payload;
  final CastListDetailState newState = state.clone();
  newState.listDetail.data.remove(_cast);
  return newState;
}
