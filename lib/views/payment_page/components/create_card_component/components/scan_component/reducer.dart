import 'package:camera/camera.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ScanState> buildReducer() {
  return asReducer(
    <Object, Reducer<ScanState>>{
      ScanAction.action: _onAction,
      ScanAction.updateController: _updateController
    },
  );
}

ScanState _onAction(ScanState state, Action action) {
  final ScanState newState = state.clone();
  return newState;
}

ScanState _updateController(ScanState state, Action action) {
  final CameraController _controller = action.payload;
  final ScanState newState = state.clone();
  newState.controller = _controller;
  return newState;
}
