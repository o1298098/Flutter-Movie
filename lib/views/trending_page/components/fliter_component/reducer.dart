import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<FliterState> buildReducer() {
  return asReducer(
    <Object, Reducer<FliterState>>{
      FliterAction.action: _onAction,
      FliterAction.updateDate: _updateDate,
      FliterAction.updateMediaType: _updateMediaType,
    },
  );
}

FliterState _onAction(FliterState state, Action action) {
  final FliterState newState = state.clone();
  return newState;
}

FliterState _updateDate(FliterState state, Action action) {
  final bool _isTiday = action.payload ?? true;
  final FliterState newState = state.clone();
  newState.isToday = _isTiday;
  return newState;
}

FliterState _updateMediaType(FliterState state, Action action) {
  final _mediaTypes = action.payload[0];
  final _selectType = action.payload[1];
  final FliterState newState = state.clone();
  newState.mediaTypes = _mediaTypes;
  newState.selectMediaType = _selectType;
  return newState;
}
