import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<FilterState> buildReducer() {
  return asReducer(
    <Object, Reducer<FilterState>>{
      FilterAction.action: _onAction,
      FilterAction.updateDate: _updateDate,
      FilterAction.updateMediaType: _updateMediaType,
    },
  );
}

FilterState _onAction(FilterState state, Action action) {
  final FilterState newState = state.clone();
  return newState;
}

FilterState _updateDate(FilterState state, Action action) {
  final bool _isTiday = action.payload ?? true;
  final FilterState newState = state.clone();
  newState.isToday = _isTiday;
  return newState;
}

FilterState _updateMediaType(FilterState state, Action action) {
  final _mediaTypes = action.payload[0];
  final _selectType = action.payload[1];
  final FilterState newState = state.clone();
  newState.mediaTypes = _mediaTypes;
  newState.selectMediaType = _selectType;
  return newState;
}
