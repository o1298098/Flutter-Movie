import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'action.dart';
import 'state.dart';

Reducer<DataPanelState> buildReducer() {
  return asReducer(
    <Object, Reducer<DataPanelState>>{
      DataPanelAction.updateDownloadTask: _updateDownloadTask,
    },
  );
}

DataPanelState _updateDownloadTask(DataPanelState state, Action action) {
  final List<DownloadTask> _task = action.payload;
  final DataPanelState newState = state.clone();
  newState.downloadTask = _task;
  return newState;
}
