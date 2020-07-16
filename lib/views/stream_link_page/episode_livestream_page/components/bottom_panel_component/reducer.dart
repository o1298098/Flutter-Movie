import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<BottomPanelState> buildReducer() {
  return asReducer(
    <Object, Reducer<BottomPanelState>>{
      BottomPanelAction.action: _onAction,
      BottomPanelAction.setUseVideoSource: _setUseVideoSource,
      BottomPanelAction.setStreamInBrowser: _setStreamInBrowser,
    },
  );
}

BottomPanelState _onAction(BottomPanelState state, Action action) {
  final BottomPanelState newState = state.clone();
  return newState;
}

BottomPanelState _setUseVideoSource(BottomPanelState state, Action action) {
  final bool _b = action.payload;
  final BottomPanelState newState = state.clone();
  newState.useVideoSourceApi = _b;
  return newState;
}

BottomPanelState _setStreamInBrowser(BottomPanelState state, Action action) {
  final bool _b = action.payload;
  final BottomPanelState newState = state.clone();
  newState.streamInBrowser = _b;
  return newState;
}
